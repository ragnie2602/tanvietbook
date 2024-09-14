import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../config/routes.dart';
import '../../../../data/constants.dart';
import '../../../../data/resources/resources.dart';
import '../../../../shared/etx/view_extensions.dart';
import '../../../../shared/widgets/bouncing.dart';
import '../../../../shared/widgets/container/primary_gesture_detector.dart';
import '../../../../shared/widgets/loading.dart';
import '../../bloc/business_bloc.dart';

import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/container/primary_container.dart';
import '../../../../shared/widgets/image/primary_image.dart';

class ProductCategory extends StatefulWidget {
  final String categoryId;
  final String? username;
  final BusinessBloc businessBloc;

  const ProductCategory({
    Key? key,
    required this.categoryId,
    this.username,
    required this.businessBloc,
  }) : super(key: key);

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    widget.businessBloc.add(BusinessGetAllProductEvent(
        pageNum: 1, pageSize: 999999, categoryId: widget.categoryId));
    return BlocProvider.value(
      value: widget.businessBloc,
      child: BlocBuilder<BusinessBloc, BusinessState>(
        buildWhen: (pre, current) =>
            current is BusinessGetAllProductSuccessState &&
            widget.categoryId == current.categoryId,
        builder: (context, state) {
          if (state is BusinessGetAllProductSuccessState) {
            if (state.productList.isNotEmpty) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        context.platform == AppPlatform.tablet ? 3 : 2,
                    childAspectRatio: 170 / 240,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: state.productList.length,
                itemBuilder: (context, index) => PrimaryContainer(
                  backgroundColor: AppColor.white,
                  child: Bouncing(
                    child: PrimaryGestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoute.businessViewProduct,
                            arguments: BusinessViewProductArgs(
                                productId: state.productList[index].id!));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: PrimaryNetworkImage(
                                  fit: BoxFit.contain,
                                  imageUrl:
                                      (state.productList[index].images ?? [])
                                              .isEmpty
                                          ? ''
                                          : (state.productList[index].images ??
                                              [])[0]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.productList[index].postName ?? '',
                                  style: AppTextTheme.textPrimary.copyWith(
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 2,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      Utils.formatMoney(state.productList[index]
                                              .discountPrices ??
                                          0),
                                      style: AppTextTheme.textPrimaryBold
                                          .copyWith(
                                              color: AppColor.secondaryColor),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      Utils.formatMoney(
                                          state.productList[index].prices ?? 0),
                                      style: AppTextTheme.textPrimaryBold
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: SvgPicture.asset(Assets.icNoData),
              );
            }
          } else {
            return const Center(
              child: Loading(),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
