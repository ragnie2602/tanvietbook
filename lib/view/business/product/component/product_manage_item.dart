import 'package:flutter/material.dart';
import '../../../../config/routes.dart';
import '../../../../data/repository/remote/app_repository.dart';
import '../../../../di/di.dart';
import '../../../../model/business/product/product_detail_response.dart';
import '../../../../shared/etx/view_extensions.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/container/primary_container.dart';
import '../../../../shared/widgets/container/primary_gesture_detector.dart';
import '../../../../shared/widgets/primary_shimmer.dart';
import '../../../../shared/widgets/primary_switch.dart';

import '../../../../data/resources/resources.dart';
import '../../../../shared/widgets/container_shimmer.dart';
import '../../../../shared/widgets/dialog_helper.dart';
import '../../../../shared/widgets/image/primary_image.dart';
import '../../../../shared/widgets/primary_button.dart';

// ignore: must_be_immutable
class ProductManageItem extends StatefulWidget {
  ProductDetailResponse productDetailResponse;
  final String subTabId;
  final Function() onDeletePressed;
  final Function(bool isEnable) onEnableChanged;

  ProductManageItem(
      {Key? key,
      required this.productDetailResponse,
      required this.subTabId,
      required this.onDeletePressed,
      required this.onEnableChanged})
      : super(key: key);

  @override
  State<ProductManageItem> createState() => _ProductManageItemState();
}

class _ProductManageItemState extends State<ProductManageItem> {
  AppRepository appRepository = getIt.get<AppRepository>();
  bool productHidden = false;

  @override
  void initState() {
    productHidden = widget.productDetailResponse.hidden ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryGestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.businessViewProduct,
            arguments: BusinessViewProductArgs(
                productId: widget.productDetailResponse.id ?? ''));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryContainer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: PrimaryNetworkImage(
                  imageUrl: (widget.productDetailResponse.images ?? []).isEmpty
                      ? ''
                      : widget.productDetailResponse.images![0],
                  height: context.screenWidth * 74 / 343,
                  width: context.screenWidth * 74 / 343,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.productDetailResponse.categoryName.toString(),
                    style: AppTextTheme.textPrimarySmall
                        .copyWith(color: AppColor.gray04),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.productDetailResponse.postName ?? '',
                    style: AppTextTheme.textPrimary
                        .copyWith(overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        Utils.formatMoney(
                            widget.productDetailResponse.discountPrices ?? 0),
                        style: AppTextTheme.textPrimary
                            .copyWith(color: AppColor.secondaryColor),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          Utils.formatMoney(
                              widget.productDetailResponse.prices ?? 0),
                          style: AppTextTheme.textPrimary
                              .copyWith(decoration: TextDecoration.lineThrough)
                              .copyWith(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  widget.productDetailResponse.outOfStock ?? false
                      ? const Row(
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: AppColor.errorColor,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Hết hàng',
                              style: AppTextTheme.textPrimary,
                            )
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Hiển thị:', style: AppTextTheme.textPrimary),
                      const SizedBox(width: 4),
                      PrimarySwitch(
                        key: UniqueKey(),
                        onToggle: (isEnable) {
                          widget.onEnableChanged.call(isEnable);
                        },
                        initialValue:
                            !(widget.productDetailResponse.hidden ?? false),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          PrimaryButton(
                            context: context,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => getAlertDialog(
                                  context: context,
                                  title: "Xác nhận",
                                  message: AlertText.alertDeleteText,
                                  onPositivePressed: () =>
                                      widget.onDeletePressed.call(),
                                ),
                              );
                            },
                            label: 'Xoá',
                            backgroundColor: AppColor.white,
                            borderColor: AppColor.secondaryColor,
                            textStyle: AppTextTheme.textButtonSecondary,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          const SizedBox(width: 10),
                          PrimaryButton(
                            context: context,
                            onPressed: () async {
                              await Navigator.pushNamed(
                                      context, AppRoute.businessUpdateProduct,
                                      arguments: BusinessUpdateProductArgs(
                                          isAddNew: false,
                                          subTabId: widget.subTabId,
                                          productId:
                                              widget.productDetailResponse.id))
                                  .then((value) {
                                if (value == null) return;
                                value as ProductDetailResponse;
                                setState(() {
                                  widget.productDetailResponse = value;
                                });
                              });
                            },
                            label: 'Sửa',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductManageItemShimmer extends StatelessWidget {
  const ProductManageItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryShimmer(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryContainer(
            height: context.screenWidth * 74 / 343,
            width: context.screenWidth * 74 / 343,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ContainerShimmer(
                  width: 150,
                ),
                const SizedBox(height: 8),
                const ContainerShimmer(
                  width: 250,
                ),
                const SizedBox(height: 10),
                ContainerShimmer(
                  width:
                      (context.screenWidth - context.screenWidth * 74 / 343) *
                          2 /
                          3,
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
