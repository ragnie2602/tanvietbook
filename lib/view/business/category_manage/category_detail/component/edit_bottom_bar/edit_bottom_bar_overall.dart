import 'package:flutter/material.dart';
import '../../../../../../data/constants.dart';
import '../../../../../../data/resources/colors.dart';
import '../../../../../../shared/widgets/dialog_helper.dart';
import '../../../../../../shared/widgets/share_popup/content_edit_item.dart';
import '../../bloc/category_button_bloc/category_button_bloc.dart';
import '../../bloc/category_detail_bloc.dart';
import '../../bloc/category_link_bloc/category_link_bloc.dart';
import 'add_edit_category_action_call.dart';
import 'add_edit_category_link.dart';

import '../../bloc/category_call_action_bloc/category_call_action_bloc.dart';
import '../../bloc/category_content_bloc/category_content_bloc.dart';
import '../../bloc/category_images_bloc/category_images_bloc.dart';
import 'add_edit_category_button.dart';
import 'add_edit_category_content.dart';
import 'add_edit_category_images.dart';
import 'change_position_bottom_bar.dart';
import 'edit_function_category_button.dart';

class EditBottomBar extends StatefulWidget {
  final CategoryDetailBloc categoryDetailBloc;
  final String type;
  final dynamic itemBloc;
  final String landingId;

  const EditBottomBar({
    Key? key,
    required this.categoryDetailBloc,
    required this.type,
    required this.landingId,
    this.itemBloc,
  }) : super(key: key);

  @override
  State<EditBottomBar> createState() => _EditBottomBarState();
}

class _EditBottomBarState extends State<EditBottomBar> {
  List<ContentEditItem> items = [];

  @override
  void initState() {
    items.addAll([
      ContentEditItems.changePosition
        ..onTap = () {
          Navigator.pop(context);
          showBottomSheet(
            context: context,
            builder: (context) =>
                ChangePositionBottomBar(bloc: widget.categoryDetailBloc),
          );
        },
      ContentEditItems.delete
        ..onTap = () {
          showDialog(
            context: context,
            builder: (context) => getAlertDialog(
              context: context,
              title: 'Xóa thành phần landingpage',
              message:
                  'Nếu bạn xóa thì thành phần này sẽ biến mất. Bạn có chắc chắn muốn xóa?',
              onPositivePressed: () {
                widget.categoryDetailBloc.add(
                  CategoryDetailDeleteEvent(landingId: widget.landingId),
                );
              },
            ),
          );
        },
    ]);
    switch (widget.type) {
      case CategoryContentType.content:
        items.addAll([
          ContentEditItems.edit
            ..onTap = () {
              Navigator.pop(context);
              showBottomSheet(
                context: context,
                builder: (context) => AddEditCategoryContent(
                  viewType: LandingPageViewType.edit,
                  categoryContentBloc: widget.itemBloc as CategoryContentBloc,
                ),
              );
            },
          // ContentEditItems.align,
          // ContentEditItems.changeBackgroundImage,
        ]);
        break;
      case CategoryContentType.images:
        items.addAll([
          ContentEditItems.addPicture..onTap = () {},
          ContentEditItems.edit
            ..onTap = () async {
              Navigator.pop(context);
              showBottomSheet(
                context: context,
                builder: (context) => AddEditCategoryImages(
                  viewType: LandingPageViewType.edit,
                  categoryImagesBloc: widget.itemBloc as CategoryImagesBloc,
                ),
              );
            },
        ]);
        break;
      case CategoryContentType.link:
        items.addAll([
          ContentEditItems.edit
            ..onTap = () {
              Navigator.pop(context);
              showBottomSheet(
                context: context,
                builder: (context) => AddEditCategoryLink(
                  viewType: LandingPageViewType.edit,
                  categoryLinkBloc: widget.itemBloc as CategoryLinkBloc,
                ),
              );
            },
        ]);
        break;
      case CategoryContentType.callAction:
        items.addAll([
          ContentEditItems.edit
            ..onTap = () async {
              Navigator.pop(context);
              showBottomSheet(
                context: context,
                builder: (context) => AddEditCategoryActionCall(
                  viewType: LandingPageViewType.edit,
                  categoryCallActionBloc:
                      widget.itemBloc as CategoryCallActionBloc,
                ),
              );
            },
          // ContentEditItems.changeBackgroundImage,
        ]);
        break;
      case CategoryContentType.button:
        items.addAll([
          ContentEditItems.edit
            ..onTap = () {
              Navigator.pop(context);
              showBottomSheet(
                context: context,
                builder: (context) => AddEditCategoryButton(
                  viewType: LandingPageViewType.edit,
                  categoryButtonBloc: widget.itemBloc as CategoryButtonBloc,
                ),
              );
            },
          ContentEditItems.function
            ..onTap = () {
              Navigator.pop(context);
              showBottomSheet(
                context: context,
                builder: (context) => EditFunctionCategoryButton(
                  categoryButtonBloc: widget.itemBloc as CategoryButtonBloc,
                ),
              );
            },
        ]);
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(color: AppColor.gray06, height: 0),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              ...ContentEditItems(items: items)
                  .items
                  .map((item) => ContentEditItems.buildItem(item))
            ],
          ),
        )
      ],
    );
  }
}
