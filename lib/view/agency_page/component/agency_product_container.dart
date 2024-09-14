import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes.dart';
import '../../../data/resources/resources.dart';
import '../../../domain/entity/agency/agency_detail.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/carousel/primary_carousel.dart';
import '../../../shared/widgets/loading.dart';
import '../../../shared/widgets/no_data.dart';
import '../cubit/agency_cubit.dart';
import 'product_image_item.dart';

class AgencyProductContainer extends StatelessWidget {
  final AgencyDetail agencyDetail;
  const AgencyProductContainer({super.key, required this.agencyDetail});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgencyCubit, AgencyState>(
      buildWhen: (previous, current) => current is GetAllAgencyProductSuccess,
      builder: (context, state) {
        return state.maybeWhen(
            getAllAgencyProductsSuccess: (agencyProductsResponse) {
          final agencyProducts = agencyProductsResponse.toList()
            ..removeWhere((element) => element.hidden == true);
          return agencyProducts.isNotEmpty
              ? PrimaryCarousel(
                  aspectRatio: 14 / 9,
                  showIndicator: true,
                  autoPlay: false,
                  viewportFraction: 0.33333,
                  customData: agencyProducts
                      .map((e) => InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoute.agencyProductDetailPage,
                                  arguments: AgencyProductDetailPageAgrs(
                                      productId: e.id!,
                                      agencyCubit: context.read()));
                            },
                            child: Card(
                              // margin: const EdgeInsets.only(right: 20, left: 12),
                              // backgroundColor: AppColor.white,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(2),
                              // ),
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProductImageItemWidget(
                                    images: e.images
                                            ?.map((e) => e.image ?? '')
                                            .toList() ??
                                        [],
                                    productStatus: e.status,
                                  ),
                                  // const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${e.name ?? ''}\n',
                                          maxLines: 2,
                                          style: AppTextTheme.bodyRegular
                                              .copyWith(
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                        ),
                                        const SizedBox(height: 4),
                                        ProductPriceItem(
                                          salePrice: e.salePrice,
                                          price: e.price,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                )
              : const NoData();
        }, orElse: () {
          return const Loading();
        });
      },
    );
  }
}

class ProductPriceItem extends StatelessWidget {
  final int? salePrice;
  final int? price;
  final bool showOrginalPrice;
  const ProductPriceItem({
    super.key,
    this.salePrice,
    this.price,
    this.showOrginalPrice = true,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          Utils.formatMoney((salePrice ?? 0).toDouble()),
          style: AppTextTheme.bodyStrong.copyWith(color: AppColor.red),
        ),
        if (showOrginalPrice)
          Text(
            Utils.formatMoney((price ?? 0).toDouble()),
            style: AppTextTheme.bodyDescription
                .copyWith(decoration: TextDecoration.lineThrough),
          ),
      ],
    );
  }
}
