import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../shared/widgets/image/primary_image.dart';
import '../../bloc/business_update_bloc.dart';

import '../../../../data/constants.dart';
import '../../../../data/resources/colors.dart';
import '../../../../data/resources/themes.dart';
import '../../../../model/business/detail/business_detail_response.dart';
import '../../../../shared/bloc/get_image/get_image_bloc.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/bouncing.dart';
import '../../../../shared/widgets/container/primary_container.dart';
import '../../../../shared/widgets/quill/primary_editor.dart';
import '../../../../shared/widgets/secondary_text_field.dart';

// ignore: must_be_immutable
class BusinessUpdateGeneral extends StatelessWidget {
  final String defaultName;
  final BusinessDetailResponse businessDetail;
  final BusinessUpdateBloc businessUpdateBloc;
  final GetImageBloc getImageBloc;
  final Function(Function() updateBusinessDetail) businessUpdateCallBack;

  BusinessUpdateGeneral({
    Key? key,
    required this.businessDetail,
    required this.defaultName,
    required this.businessUpdateCallBack,
    required this.businessUpdateBloc,
    required this.getImageBloc,
  }) : super(key: key);

  final _nameFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  late QuillController controller;
  late String logoPath = '';

  void updateBusinessDetail() {
    businessUpdateBloc.businessDetailResponse =
        businessUpdateBloc.businessDetailResponse.copyWith(
      websiteName: nameController.text,
      description: jsonEncode(controller.document.toDelta().toJson()),
    );
  }

  @override
  Widget build(BuildContext context) {
    businessUpdateCallBack.call(updateBusinessDetail);

    controller = QuillController(
        document: Utils.parseQuillDocument(businessDetail.description),
        selection: const TextSelection.collapsed(offset: 0));
    // controller = HtmlEditorController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Logo của $defaultName',
                    style: AppTextTheme.textPrimaryBoldMedium,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/ic_exclamation.svg'),
                      const SizedBox(width: 4),
                      const Expanded(
                        child: Text(
                          'Thêm ảnh logo sẽ giúp Khách hàng dễ dàng nhận diện thương hiệu',
                          style: AppTextTheme.textPrimary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            Stack(
              children: [
                BlocBuilder<GetImageBloc, GetImageState>(
                    buildWhen: (pre, current) =>
                        current is GetImagePickImageSuccessState,
                    builder: (context, state) {
                      if (state is GetImagePickImageSuccessState) {
                        logoPath = state.imagePath;
                        getImageBloc.currentImagePathList.clear();
                        getImageBloc.currentImagePathList.add(logoPath);
                        return Image(
                            image: FileImage(File(state.imagePath)),
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100);
                      } else {
                        return PrimaryNetworkImage(
                            imageUrl: businessDetail.logo ?? '',
                            height: 100,
                            fit: BoxFit.contain,
                            width: 100);
                      }
                    }),
                InkWell(
                  onTap: () async {
                    // controller.clearFocus();
                    // var txt = await controller.getText();
                    // log(txt);
                    getImageBloc.add(GetImagePickerEvent(
                        shouldCrop: true, type: ImageType.square));
                  },
                  child: Bouncing(
                    child: SizedBox(
                      height: 100,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 100,
                          height: 50,
                          color: AppColor.black.withOpacity(0.4),
                          child: Center(
                            child:
                                SvgPicture.asset('assets/icons/ic_camera.svg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        SecondaryTextField(
          controller: nameController..text = businessDetail.websiteName ?? '',
          label: 'Tên $defaultName',
          isRequired: true,
          hintText: 'Nhập tên $defaultName',
          validator: Utils.textEmptyValidator,
          maxLines: 3,
          counterText: null,
          maxLength: 100,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.sentences,
          formKey: _nameFormKey,
        ),
        const SizedBox(height: 20),
        const Text('Thông tin nổi bật',
            style: AppTextTheme.textPrimaryBoldMedium),
        const SizedBox(height: 10),
        PrimaryContainer(
          borderColor: AppColor.gray09,
          child: PrimaryEditor(
            controller: controller,
          ),
        ),
      ],
    );
  }
}
