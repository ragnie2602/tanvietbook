import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../../../../../../data/constants.dart';
import '../../../../../../data/resources/colors.dart';
import '../../../../../../shared/utils/utils.dart';
import '../../../../../../shared/widgets/button/action_button_edit_category.dart';
import '../../../../../../shared/widgets/container/primary_container.dart';
import '../../../../../../shared/widgets/quill/primary_editor.dart';
import '../../../../../../shared/widgets/share_popup/primary_bottom_sheet.dart';
import '../../bloc/category_content_bloc/category_content_bloc.dart';
import '../../bloc/category_detail_bloc.dart';

class AddEditCategoryContent extends StatelessWidget {
  final quill.QuillController controller = quill.QuillController.basic();
  final CategoryContentBloc categoryContentBloc;
  final LandingPageViewType viewType;
  final CategoryDetailBloc? categoryDetailBloc;
  final int? position;

  AddEditCategoryContent(
      {Key? key,
      required this.categoryContentBloc,
      required this.viewType,
      this.categoryDetailBloc,
      this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PrimaryBottomSheet(
        title: 'Chỉnh sửa nội dung',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: PrimaryContainer(
                  borderColor: AppColor.white,
                  child: PrimaryEditor(
                    controller: controller
                      ..document = Utils.parseQuillDocument(
                          categoryContentBloc.currentValue.value),
                  ),
                ),
              ),
            ),
            ActionButtonEditCategory(
              onCancel: () {},
              onSave: () {
                if (viewType == LandingPageViewType.edit) {
                  categoryContentBloc.add(
                    CategoryContentUpdateEvent(
                      contentId: categoryContentBloc.currentValue.id ?? '',
                      value: jsonEncode(controller.document.toDelta().toJson()),
                    ),
                  );
                } else {
                  categoryDetailBloc?.add(
                    CategoryContentAddEvent(
                      position: position!,
                      value: jsonEncode(controller.document.toDelta().toJson()),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
