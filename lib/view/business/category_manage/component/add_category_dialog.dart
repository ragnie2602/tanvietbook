import 'package:flutter/material.dart';
import '../../../../data/resources/colors.dart';
import '../../../../data/resources/themes.dart';
import '../../../../model/business/category/business_category_response.dart';
import '../../../../shared/widgets/dialog_helper.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../bloc/category_manage_bloc/category_manage_bloc.dart';

import '../../../../data/constants.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/primary_switch.dart';
import '../../../../shared/widgets/secondary_text_field.dart';

class AddCategoryDialog extends StatelessWidget {
  final CategoryManageBloc categoryManageBloc;

  const AddCategoryDialog({Key? key, required this.categoryManageBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final nameFormKey = GlobalKey<FormState>();
    final typeController = TextEditingController()..text = 'Landing Page';
    int typeIndex = 0;
    bool enable = true;

    return Dialog(
      child: Container(
        color: AppColor.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text('Tạo mới danh mục',
                      style: AppTextTheme.textPrimary),
                  const Spacer(),
                  IconButton(
                      hoverColor: AppColor.primaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
            ),
            const Divider(height: 0, color: AppColor.gray06, thickness: 0.5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SecondaryTextField(
                    isRequired: true,
                    formKey: nameFormKey,
                    validator: Utils.textEmptyValidator,
                    label: 'Tên danh mục',
                    hintText: 'Nhập tên danh mục',
                    controller: nameController,
                  ),
                  const SizedBox(height: 20),
                  SecondaryTextField(
                    isDense: true,
                    isRequired: true,
                    label: 'Loại danh mục',
                    inputType: AppInputType.dropDown,
                    data: const ['Landing Page', 'Bài đăng'],
                    controller: typeController,
                    onDropdownValueChanged: (value, index) {
                      typeIndex = index;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Hiển thị:'),
                      const SizedBox(width: 14),
                      PrimarySwitch(
                        initialValue: enable,
                        onToggle: (value) {
                          enable = value;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          context: context,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          label: 'Hủy',
                          borderColor: AppColor.primaryColor,
                          textStyle: AppTextTheme.textPrimary,
                          backgroundColor: AppColor.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: PrimaryButton(
                          context: context,
                          onPressed: () {
                            final checkName =
                                nameFormKey.currentState!.validate();
                            if (!checkName) return;
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => getLoadingDialog());
                            categoryManageBloc.add(CategoryManageCreateEvent(
                                categoryResponse: BusinessCategoryResponse(
                              categoryName: nameController.text.trim(),
                              subTabId: categoryManageBloc.currentSubTabId,
                              type: typeIndex == 0
                                  ? CategoryType.landingPage
                                  : CategoryType.post,
                              enable: enable,
                            )));
                          },
                          label: 'Lưu',
                          backgroundColor: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
