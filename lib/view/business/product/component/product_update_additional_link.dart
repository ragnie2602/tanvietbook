import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import '../../bloc/business_update_bloc.dart';

import '../../../../data/resources/resources.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/container/primary_container.dart';
import '../../../../shared/widgets/quill/primary_editor.dart';
import '../../../../shared/widgets/secondary_text_field.dart';

class ProductUpdateAdditionalLink extends StatelessWidget {
  final BusinessUpdateBloc businessUpdateBloc;
  final int index;
  final Function(Function() updateBusinessAdditionalLink) updateCallback;
  ProductUpdateAdditionalLink(
      {Key? key,
      required this.businessUpdateBloc,
      required this.index,
      required this.updateCallback})
      : super(key: key);

  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  final quillController = QuillController.basic();

  void updateBusinessAdditionalLink() {
    businessUpdateBloc.productDetailResponse = index == 0
        ? businessUpdateBloc.productDetailResponse.copyWith(
            titleLink1: _titleController.text,
            link1: _valueController.text,
            description1:
                jsonEncode(quillController.document.toDelta().toJson()),
          )
        : businessUpdateBloc.productDetailResponse.copyWith(
            titleLink2: _titleController.text,
            link2: _valueController.text,
            description2:
                jsonEncode(quillController.document.toDelta().toJson()),
          );
  }

  @override
  Widget build(BuildContext context) {
    updateCallback.call(updateBusinessAdditionalLink);
    _titleController.text = index == 0
        ? (businessUpdateBloc.productDetailResponse.titleLink1 ?? '')
        : (businessUpdateBloc.productDetailResponse.titleLink2 ?? '');
    _valueController.text = index == 0
        ? (businessUpdateBloc.productDetailResponse.link1 ?? '')
        : (businessUpdateBloc.productDetailResponse.link2 ?? '');
    quillController.document = Utils.parseQuillDocument(index == 0
        ? businessUpdateBloc.productDetailResponse.description1
        : businessUpdateBloc.productDetailResponse.description2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.link),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Liên kết bổ sung',
                style: AppTextTheme.textPrimaryBold,
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        SecondaryTextField(
          controller: _titleController,
          label: 'Tiêu đề liên kết',
          labelStyle: AppTextTheme.textPrimaryBold,
          hintText: 'Nhập tiêu đề liên kết',
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 20),
        SecondaryTextField(
          controller: _valueController,
          label: 'Liên kết',
          hintText: 'Nhập liên kết',
          labelStyle: AppTextTheme.textPrimaryBold,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 20),
        const Text(
          'Mô tả chi tiết',
          style: AppTextTheme.textPrimaryBold,
        ),
        const SizedBox(height: 10),
        PrimaryContainer(
          padding: const EdgeInsets.all(8),
          borderColor: AppColor.gray04,
          child: PrimaryEditor(
            controller: quillController,
          ),
        ),
      ],
    );
  }
}
