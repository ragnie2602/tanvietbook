import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/constants.dart';
import '../../../../../../shared/bloc/get_image/get_image_bloc.dart';
import '../../../../../../shared/widgets/button/action_button_edit_category.dart';
import '../../../../../../shared/widgets/image/primary_reorder_grid_image.dart';
import '../../../../../../shared/widgets/share_popup/primary_bottom_sheet.dart';
import '../../bloc/category_detail_bloc.dart';
import '../../bloc/category_images_bloc/category_images_bloc.dart';

class AddEditCategoryImages extends StatelessWidget {
  final GetImageBloc getImageBloc = GetImageBloc();
  final CategoryImagesBloc categoryImagesBloc;
  final LandingPageViewType viewType;
  final CategoryDetailBloc? categoryDetailBloc;
  final int? position;
  AddEditCategoryImages(
      {Key? key,
      required this.categoryImagesBloc,
      required this.viewType,
      this.categoryDetailBloc,
      this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getImageBloc,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: PrimaryBottomSheet(
          title: 'Chỉnh sửa ảnh',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocListener<GetImageBloc, GetImageState>(
                listener: (context, state) {
                  if (state is GetImageGetMultiImageUrlSuccessState) {
                    if (viewType == LandingPageViewType.edit) {
                      categoryImagesBloc.add(
                        CategoryImagesUpdateEvent(
                          listImageUri: List<String>.from(
                            state.imageData
                                .where((element) =>
                                    element.type != ImageDataType.addNew)
                                .map((e) => e.data)
                                .toList(),
                          ),
                        ),
                      );
                    } else {
                      categoryDetailBloc?.add(
                        CategoryImagesAddEvent(
                          position: position!,
                          listImageUri: List<String>.from(
                            state.imageData
                                .where((element) =>
                                    element.type != ImageDataType.addNew)
                                .map((e) => e.data)
                                .toList(),
                          ),
                        ),
                      );
                    }

                    Navigator.pop(context);
                  } else if (state is GetImageGetImageUrlErrorState) {
                    Navigator.pop(context);
                  }
                },
                child: PrimaryReorderGridImage(
                  crossAxisCount: 2,
                  maxQuantity: 10,
                  getImageBloc: getImageBloc,
                  initialData: categoryImagesBloc.list
                      .map((e) => e.value ?? '')
                      .toList(),
                ),
              ),
              ActionButtonEditCategory(
                onCancel: () {},
                onSave: () {
                  getImageBloc.add(GetImageGetMultiImageUrlEvent());
                },
                popOnSave: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
