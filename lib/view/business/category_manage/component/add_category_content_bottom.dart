import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../config/routes.dart';
import '../../../../data/constants.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../bloc/add_category_content_bloc/add_category_content_bloc.dart';

import '../../../../data/resources/colors.dart';
import '../../../../data/resources/themes.dart' show AppTextTheme;
import '../../../../shared/utils/view_utils.dart';
import '../../../../shared/widgets/loading.dart';
import '../../../../shared/widgets/secondary_text_field.dart';

class AddCategoryContent extends StatefulWidget {
  const AddCategoryContent(
      {Key? key, this.subTabId, this.categoryId, this.categoryName})
      : super(key: key);

  final String? subTabId;
  final String? categoryId;
  final String? categoryName;

  @override
  State<AddCategoryContent> createState() => _AddCategoryContentState();
}

class _AddCategoryContentState extends State<AddCategoryContent> {
  final List<String> imgAssetList = [
    "assets/images/affiliate.svg",
    "assets/images/collab_benefit.svg",
    "assets/images/img_contact_blank.svg"
  ];

  String? currentCategoryId;
  TextEditingController currentCategoryNameController = TextEditingController();

  final AddCategoryContentBloc addCategoryContentBloc =
      AddCategoryContentBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => addCategoryContentBloc
        ..add(AddCategoryContentInitEvent(subTabId: widget.subTabId)),
      child: BlocBuilder<AddCategoryContentBloc, AddCategoryContentState>(
        builder: (context, state) {
          if (state is AddCategoryContentInitial) {
            return Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Text('Tạo mới Landing Page',
                            style: AppTextTheme.textPrimary),
                        const Spacer(),
                        IconButton(
                          hoverColor: AppColor.primaryColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                      height: 0, color: AppColor.gray06, thickness: 0.5),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: '* ',
                                style: AppTextTheme.textRed,
                                children: [
                                  TextSpan(
                                    text: 'Chọn danh mục',
                                    style: AppTextTheme.textPrimary,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            widget.categoryId == null &&
                                    state.listCategory.isNotEmpty
                                ? SecondaryTextField(
                                    controller: currentCategoryNameController
                                      ..text =
                                          state.listCategory[0].categoryName ??
                                              '',
                                    inputType: AppInputType.dropDown,
                                    data: state.listCategory
                                        .map((e) => e.categoryName ?? '')
                                        .toList(),
                                  )
                                : SecondaryTextField(
                                    controller: TextEditingController()
                                      ..text = widget.categoryName ?? '',
                                    readOnly: true,
                                  ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Text('1. Tạo mới hoàn toàn',
                                    style: AppTextTheme.textPrimary),
                                const Spacer(),
                                PrimaryButton(
                                    context: context,
                                    onPressed: () {
                                      if (state.listCategory.isEmpty &&
                                          widget.categoryId == null) {
                                        toastWarning(
                                            'Cần chọn ít nhất 1 danh mục để tạo landing page');
                                        return;
                                      }
                                      currentCategoryId = widget.categoryId;
                                      currentCategoryId ??= state.listCategory
                                          .firstWhere((element) =>
                                              element.categoryName ==
                                              currentCategoryNameController
                                                  .text)
                                          .id;
                                      Navigator.popAndPushNamed(
                                        context,
                                        AppRoute.categoryContentDetail,
                                        arguments: CategoryContentDetailArgs(
                                          categoryId: currentCategoryId ?? '',
                                          subTabId: widget.subTabId ?? '',
                                          type: LandingPageViewType.add,
                                        ),
                                      );
                                    },
                                    label: 'Tạo mới')
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Row(
                            //   children: [
                            //     const Text('2. Tạo mới bằng link giao diện',
                            //         style: AppTextTheme.textPrimary),
                            //     const SizedBox(width: 4),
                            //     SvgPicture.asset(
                            //         'assets/icons/ic_more_info.svg')
                            //   ],
                            // ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Expanded(
                            //       child: SecondaryTextField(
                            //         controller: TextEditingController(),
                            //         hintText: 'Nhập link giao diện',
                            //         isDense: true,
                            //       ),
                            //     ),
                            //     const SizedBox(width: 10),
                            //     PrimaryButton(
                            //         // contentPadding: 6,
                            //         context: context,
                            //         onPressed: () {},
                            //         label: 'Dán liên kết')
                            //   ],
                            // ),
                            // const SizedBox(height: 20),
                            // const Text('3. Tạo theo mẫu có sẵn',
                            //     style: AppTextTheme.textPrimary),
                            // const SizedBox(height: 10),
                            // GridView.builder(
                            //   shrinkWrap: true,
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   itemCount: imgAssetList.length,
                            //   gridDelegate:
                            //       const SliverGridDelegateWithFixedCrossAxisCount(
                            //           crossAxisSpacing: 10,
                            //           crossAxisCount: 2,
                            //           mainAxisSpacing: 10),
                            //   itemBuilder: (context, index) =>
                            //       AvailableExampleItem(
                            //     asset: imgAssetList[index],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}

class AvailableExampleItem extends StatefulWidget {
  final String asset;
  const AvailableExampleItem({Key? key, required this.asset}) : super(key: key);

  @override
  State<AvailableExampleItem> createState() => _AvailableExampleItemState();
}

class _AvailableExampleItemState extends State<AvailableExampleItem> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppColor.gray04)),
      child: Stack(
        children: [
          InkWell(
            child: SvgPicture.asset(widget.asset),
            onTap: () {
              setState(() {
                isClick = !isClick;
              });
            },
          ),
          if (isClick == true)
            InkWell(
              onTap: () {
                setState(() {
                  isClick = !isClick;
                });
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(10),
                color: AppColor.black.withOpacity(0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                      context: context,
                      onPressed: () {},
                      label: "Xem chi tiết",
                      textStyle: AppTextTheme.textPrimaryColor,
                      backgroundColor: AppColor.white,
                      borderColor: AppColor.primaryColor,
                    ),
                    PrimaryButton(
                      context: context,
                      onPressed: () {},
                      label: "Áp dụng",
                      borderColor: AppColor.white,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
