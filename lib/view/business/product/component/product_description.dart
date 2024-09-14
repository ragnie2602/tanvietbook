import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/resources/themes.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/button/primary_group_checkbox.dart';
import '../../../../shared/widgets/primary_drop_down_form_field.dart';
import '../../../../shared/widgets/primary_shimmer.dart';
import '../../bloc/business_update_bloc.dart';

import '../../../../data/resources/colors.dart';
import '../../../../shared/widgets/secondary_text_field.dart';
import '../../bloc/business_bloc.dart';

class ProductDescription extends StatelessWidget {
  final BusinessUpdateBloc businessUpdateBloc;
  final Function(bool Function() updateProductInfo)
      productDescriptionUpdateCallback;
  final bool isAddNew;

  ProductDescription(
      {Key? key,
      required this.businessUpdateBloc,
      required this.productDescriptionUpdateCallback,
      required this.isAddNew})
      : super(key: key);

  final nameController = TextEditingController();
  final originalPriceController = TextEditingController();
  final discountPriceController = TextEditingController();
  final actionController = TextEditingController();
  final categoryController = TextEditingController();

  final nameFormKey = GlobalKey<FormState>();
  final originalPriceFormKey = GlobalKey<FormState>();
  final discountPriceFormKey = GlobalKey<FormState>();
  final actionFormKey = GlobalKey<FormState>();

  bool updateProductInfo() {
    if (!nameFormKey.currentState!.validate() ||
        !nameFormKey.currentState!.validate() ||
        !actionFormKey.currentState!.validate() ||
        !nameFormKey.currentState!.validate()) {
      return false;
    }
    businessUpdateBloc.productDetailResponse =
        businessUpdateBloc.productDetailResponse.copyWith(
      postName: nameController.text.trim(),
      prices: double.tryParse(originalPriceController.text) ?? 0,
      discountPrices: double.tryParse(discountPriceController.text) ?? 0,
      actionInfor: actionController.text.trim(),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    productDescriptionUpdateCallback.call(updateProductInfo);
    nameController.text =
        businessUpdateBloc.productDetailResponse.postName ?? '';
    originalPriceController.text =
        (businessUpdateBloc.productDetailResponse.prices ?? 0).toString();
    discountPriceController.text =
        (businessUpdateBloc.productDetailResponse.discountPrices ?? 0)
            .toString();
    actionController.text = businessUpdateBloc
            .productDetailResponse.actionInfor ??
        'Bạn có thắc mắc? Đừng lo, hãy để lại liên hệ ngay cho chúng tôi!';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SecondaryTextField(
          controller: nameController,
          label: 'Tên sản phẩm',
          isRequired: true,
          labelStyle: AppTextTheme.textPrimaryBold,
          validator: Utils.textEmptyValidator,
          formKey: nameFormKey,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 20),
        SecondaryTextField(
          controller: originalPriceController,
          label: 'Giá gốc',
          isRequired: true,
          labelStyle: AppTextTheme.textPrimaryBold,
          validator: Utils.textEmptyValidator,
          formKey: originalPriceFormKey,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        SecondaryTextField(
          controller: discountPriceController,
          label: 'Giá khuyến mại',
          labelStyle: AppTextTheme.textPrimaryBold,
          isRequired: true,
          validator: Utils.textEmptyValidator,
          formKey: discountPriceFormKey,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 20),
        const Text(
          'Trạng thái bài đăng',
          style: AppTextTheme.textPrimaryBold,
        ),
        const SizedBox(height: 10),
        PrimaryGroupCheckbox(
          items: const ['Hết hàng', 'Ẩn bài đăng'],
          initialValue: [
            businessUpdateBloc.productDetailResponse.outOfStock ?? false,
            businessUpdateBloc.productDetailResponse.hidden ?? false,
          ],
          onChanged: (result) {
            businessUpdateBloc.productDetailResponse =
                businessUpdateBloc.productDetailResponse.copyWith(
              outOfStock: result[0],
              hidden: result[1],
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              "*",
              style: AppTextTheme.textPrimaryBold
                  .copyWith(color: AppColor.errorColor),
            ),
            const Text(
              ' Danh mục website mini',
              style: AppTextTheme.textPrimaryBold,
            ),
          ],
        ),
        const SizedBox(height: 10),
        BlocBuilder<BusinessBloc, BusinessState>(
          buildWhen: (pre, current) =>
              current is BusinessGetCategorySuccessState,
          builder: (context, state) {
            late final String initialCategory;
            if (state is BusinessGetCategorySuccessState) {
              if (state.categoryList.isNotEmpty) {
                if (isAddNew) {
                  businessUpdateBloc.productDetailResponse =
                      businessUpdateBloc.productDetailResponse.copyWith(
                          categoryID: state.categoryList[0].id,
                          categoryName: state.categoryList[0].categoryName);
                  initialCategory =
                      state.categoryList[0].categoryName.toString();
                } else {
                  int initialIndex = 0;
                  for (int i = 0; i < state.categoryList.length; i++) {
                    if (state.categoryList[i].categoryName ==
                        businessUpdateBloc.productDetailResponse.categoryName) {
                      initialIndex = i;
                      break;
                    }
                  }
                  initialCategory =
                      state.categoryList[initialIndex].categoryName.toString();
                }
              } else {
                return const Text(
                  'Bạn cần tạo danh mục trước khi tạo bài đăng.',
                  style: AppTextTheme.textLowPriority,
                );
              }

              return PrimaryDropDownFormField(
                items: state.categoryList
                    .map((e) => e.categoryName.toString())
                    .toList(),
                controller: categoryController,
                onChanged: (value, index) {
                  businessUpdateBloc.productDetailResponse =
                      businessUpdateBloc.productDetailResponse.copyWith(
                    categoryID: state.categoryList[index].id,
                  );
                },
                initialValue: initialCategory,
                hintText: 'Chọn danh mục',
              );
            } else {
              return PrimaryShimmer(
                  child: Container(
                color: AppColor.gray09,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: PrimaryDropDownFormField(
                  items: const [],
                  fillColor: AppColor.gray09,
                  initialValue: null,
                  controller: TextEditingController(),
                ),
              ));
            }
          },
        ),
        const SizedBox(height: 20),
        SecondaryTextField(
          controller: actionController,
          label: 'Tiêu đề lời kêu gọi',
          labelStyle: AppTextTheme.textPrimaryBold,
          isRequired: true,
          validator: Utils.textEmptyValidator,
          formKey: actionFormKey,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
