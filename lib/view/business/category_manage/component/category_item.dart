import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../config/routes.dart';
import '../../../../data/constants.dart';
import '../../../../data/resources/resources.dart';
import '../../../../model/business/category/business_category_response.dart';
import '../../../../shared/utils/view_utils.dart';
import '../../../../shared/widgets/dialog_helper.dart';
import '../../../../shared/widgets/primary_icon_button.dart';
import '../../../../shared/widgets/primary_switch.dart';
import '../../../../shared/widgets/secondary_text_field.dart';

import '../../../../data/repository/remote/category_repository.dart';
import '../../../../di/di.dart';
import '../../../../model/api/base_response.dart';
import '../../../../shared/widgets/primary_button.dart';
import 'add_category_content_bottom.dart';

class CategoryItem extends StatefulWidget {
  final BusinessCategoryResponse data;

  final Function() onDeletePressed;

  const CategoryItem(
      {Key? key, required this.data, required this.onDeletePressed})
      : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool onEdit = false;
  final CategoryRepository categoryRepository = getIt.get<CategoryRepository>();
  final TextEditingController _categoryNameController = TextEditingController();
  late String categoryName;
  late bool categoryEnable;

  @override
  void initState() {
    categoryName = widget.data.categoryName ?? '';
    _categoryNameController.text = categoryName;
    categoryEnable = widget.data.enable ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          onEdit == false
              ? Row(
                  children: [
                    Text(categoryName, style: AppTextTheme.textPrimary),
                    const SizedBox(width: 10),
                    PrimaryIconButton(
                      context: context,
                      iconColor: AppColor.primaryColor,
                      onPressed: () {
                        setState(() {
                          onEdit = true;
                        });
                      },
                      icon: Assets.icEdit,
                    )
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SecondaryTextField(
                        isDense: true,
                        maxLength: 50,
                        controller: _categoryNameController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      child:
                          SvgPicture.asset('assets/icons/ic_button_accept.svg'),
                      onTap: () {
                        _changeCategoryName();
                        setState(() {
                          onEdit = false;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      child:
                          SvgPicture.asset('assets/icons/ic_button_close.svg'),
                      onTap: () {
                        setState(() {
                          onEdit = false;
                        });
                      },
                    ),
                  ],
                ),
          const SizedBox(height: 10),
          Text('Loại: ${widget.data.type}', style: AppTextTheme.textDisable),
          const SizedBox(height: 10),
          const Divider(height: 0, thickness: 0.5, color: AppColor.gray06),
          Row(
            children: [
              const Text('Hiển thị:'),
              const SizedBox(width: 4),
              PrimarySwitch(
                initialValue: categoryEnable,
                onToggle: (value) {
                  _changeEnable(value);
                },
              ),
              const Spacer(),
              PrimaryButton(
                backgroundColor: Colors.white,
                textStyle: AppTextTheme.textButtonSecondary,
                borderColor: AppColor.secondaryColor,
                context: context,
                onPressed: () => showDialog(
                    context: context,
                    builder: (_) => getAlertDialog(
                          context: context,
                          message: 'Xác nhận',
                          title: AlertText.alertDeleteText,
                          onPositivePressed: () =>
                              widget.onDeletePressed.call(),
                        )),
                label: 'Xóa',
              ),
              const SizedBox(width: 10),
              PrimaryButton(
                backgroundColor: AppColor.primaryColor,
                textStyle: AppTextTheme.textPrimaryWhite,
                context: context,
                onPressed: () => _onManagePressed(context, widget.data),
                label: 'Quản lý',
              ),
            ],
          )
        ],
      ),
    );
  }

  void _changeCategoryName() async {
    log("${_categoryNameController.text} & ${widget.data.categoryName}");
    if (_categoryNameController.text.isEmpty ||
        _categoryNameController.text == widget.data.categoryName) return;
    final response = await categoryRepository.updateCategory(
      data: {
        "id": widget.data.id,
        "description": widget.data.description,
        "categoryName": _categoryNameController.text,
        "enable": categoryEnable,
        "memberId": widget.data.memberId,
      },
    );
    if (response.status == ResponseStatus.success) {
      toastSuccess('Đổi tên thành công');
      setState(() {
        categoryName = _categoryNameController.text;
        onEdit = false;
      });
    }
  }

  void _changeEnable(bool value) async {
    final response = await categoryRepository.updateCategory(
      data: {
        "id": widget.data.id,
        "description": widget.data.description,
        "categoryName": categoryName,
        "enable": value,
        "memberId": widget.data.memberId,
      },
    );
    if (response.status == ResponseStatus.success) {
      toastSuccess('Đổi trạng thái thành công');
      setState(() {
        categoryEnable = value;
      });
    }
  }

  void _onManagePressed(
      BuildContext context, BusinessCategoryResponse categoryResponse) {
    switch (categoryResponse.type) {
      case CategoryType.post:
        Navigator.pushNamed(context, AppRoute.businessProductManage,
            arguments: BusinessProductManageArgs(
                categoryId: categoryResponse.id,
                categoryName: categoryResponse.categoryName,
                subTabId: categoryResponse.subTabId!));
        break;
      case CategoryType.landingPage:
        if (!(categoryResponse.isInitialized ?? false)) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => FractionallySizedBox(
              heightFactor: 0.8,
              child: AddCategoryContent(
                  categoryId: categoryResponse.id,
                  categoryName: categoryResponse.categoryName),
            ),
          );
        } else {
          Navigator.pushNamed(
            context,
            AppRoute.categoryContentDetail,
            arguments: CategoryContentDetailArgs(
              categoryId: categoryResponse.id ?? '',
              subTabId: categoryResponse.subTabId ?? '',
              type: LandingPageViewType.edit,
            ),
          );
        }
        break;
    }
  }
}
