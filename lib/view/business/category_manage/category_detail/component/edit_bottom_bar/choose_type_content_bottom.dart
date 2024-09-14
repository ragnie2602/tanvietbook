import 'package:flutter/material.dart';
import '../../../../../../data/constants.dart';
import '../../../../../../shared/widgets/primary_button.dart';
import '../../../../../../shared/widgets/share_popup/primary_bottom_sheet.dart';
import '../../bloc/category_call_action_bloc/category_call_action_bloc.dart';
import 'add_edit_category_action_call.dart';
import 'add_edit_category_link.dart';

import '../../bloc/category_button_bloc/category_button_bloc.dart';
import '../../bloc/category_content_bloc/category_content_bloc.dart';
import '../../bloc/category_detail_bloc.dart';
import '../../bloc/category_images_bloc/category_images_bloc.dart';
import '../../bloc/category_link_bloc/category_link_bloc.dart';
import 'add_edit_category_button.dart';
import 'add_edit_category_content.dart';
import 'add_edit_category_images.dart';

class ChooseTypeContentBottom extends StatelessWidget {
  final CategoryDetailBloc categoryDetailBloc;
  final int position;
  const ChooseTypeContentBottom(
      {Key? key, required this.categoryDetailBloc, required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryBottomSheet(
      title: 'Thêm thành phần nội dung danh mục',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          shrinkWrap: true,
          itemCount: CategoryContentType.list.length,
          itemBuilder: (context, index) => PrimaryButton(
              context: context,
              onPressed: () {
                // log("$categoryId  $index");
                // categoryDetailBloc.add(CategoryDetailCreateLandingPageItemEvent(
                //     landingPageType: index, categoryId: categoryId));

                switch (index) {
                  case 0:
                    Navigator.pop(context);
                    showBottomSheet(
                      context: context,
                      builder: (context) => AddEditCategoryImages(
                        position: position,
                        categoryDetailBloc: categoryDetailBloc,
                        viewType: LandingPageViewType.add,
                        categoryImagesBloc: CategoryImagesBloc(),
                      ),
                    );
                    break;
                  case 1:
                    Navigator.pop(context);
                    showBottomSheet(
                      context: context,
                      builder: (context) => AddEditCategoryContent(
                        position: position,
                        categoryDetailBloc: categoryDetailBloc,
                        viewType: LandingPageViewType.add,
                        categoryContentBloc: CategoryContentBloc(),
                      ),
                    );
                    break;
                  case 2:
                    Navigator.pop(context);
                    showBottomSheet(
                      context: context,
                      builder: (context) => AddEditCategoryLink(
                        position: position,
                        categoryDetailBloc: categoryDetailBloc,
                        viewType: LandingPageViewType.add,
                        categoryLinkBloc: CategoryLinkBloc(),
                      ),
                    );
                    break;
                  case 3:
                    Navigator.pop(context);
                    showBottomSheet(
                      context: context,
                      builder: (context) => AddEditCategoryActionCall(
                        position: position,
                        categoryDetailBloc: categoryDetailBloc,
                        viewType: LandingPageViewType.add,
                        categoryCallActionBloc: CategoryCallActionBloc(),
                      ),
                    );
                    break;
                  case 4:
                    Navigator.pop(context);
                    showBottomSheet(
                        context: context,
                        builder: (context) => AddEditCategoryButton(
                            position: position,
                            categoryDetailBloc: categoryDetailBloc,
                            viewType: LandingPageViewType.add,
                            categoryButtonBloc: CategoryButtonBloc()));
                    break;
                }
              },
              label: 'Thêm ${CategoryContentType.list[index].toLowerCase()}'),
        ),
      ),
    );
  }
}
