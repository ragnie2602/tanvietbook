import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../data/resources/resources.dart';

class PrimaryEditor extends StatelessWidget {
  final QuillController controller;
  final bool readOnly;
  final bool autoFocus;
  final int? limitCharactor;

  const PrimaryEditor({
    Key? key,
    required this.controller,
    this.autoFocus = false,
    this.readOnly = false,
    this.limitCharactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (limitCharactor != null) {
      final documentLength = controller.document.length;
      if (documentLength > limitCharactor!) {
        final replaceLength = documentLength - limitCharactor!;
        controller.replaceText(
          limitCharactor! - 1,
          replaceLength,
          '',
          TextSelection.collapsed(offset: documentLength - 1),
        );
        controller.document.insert(limitCharactor! - 1, "...");
      }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      // alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: QuillEditor.basic(
            configurations: QuillEditorConfigurations(
              controller: controller,
              readOnly: readOnly,
              scrollable: false,
              enableInteractiveSelection: !readOnly,
              autoFocus: autoFocus,
              padding: EdgeInsets.only(bottom: readOnly ? 10 : 60),
              customStyles: DefaultStyles(
                sizeLarge: AppTextTheme.bodyRegular,
                sizeHuge: AppTextTheme.titleMedium,
                sizeSmall: AppTextTheme.bodyDescription,
              ),
            ),
            scrollController: ScrollController(),
            focusNode: FocusNode(),
          ),
        ),
        if (!readOnly)
          Column(
            children: [
              const Divider(
                thickness: 1,
                color: AppColor.neutral5,
              ),
              QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  controller: controller,
                  multiRowsDisplay: false,
                  color: AppColor.primaryBackgroundColor,
                  buttonOptions: const QuillSimpleToolbarButtonOptions(
                    base: QuillToolbarBaseButtonOptions(
                      iconTheme: QuillIconTheme(
                          // iconUnselectedFillColor: Colors.white,
                          // iconUnselectedColor: Colors.black
                          ),
                    ),
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }

  // void _onDocumentChange(DocChange event) {
  //   final documentLength = controller.document.length;
  //   log('documentLength: $documentLength');
  //   if (documentLength > limit) {
  //     final latestIndex = limit - 1;
  //     controller.replaceText(
  //       latestIndex,
  //       documentLength - limit,
  //       '',
  //       TextSelection.collapsed(offset: latestIndex),
  //     );
  //   }
  // }
}
