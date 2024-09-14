import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../../../data/resources/colors.dart';
import '../../bloc/get_image/get_image_bloc.dart';
import '../container/primary_container.dart';
import '../container_shimmer.dart';
import '../primary_shimmer.dart';
import 'primary_image.dart';

class PrimaryReorderGridImage extends StatefulWidget {
  final int maxQuantity;
  final int crossAxisCount;
  final double childAspectRatio;
  final List<String> initialData;
  final GetImageBloc getImageBloc;
  final BoxFit? fit;
  final Function(List<ImageDataWrapper> imageData)? onDataChanged;

  const PrimaryReorderGridImage({
    super.key,
    this.maxQuantity = 5,
    required this.initialData,
    this.childAspectRatio = 16 / 9,
    required this.getImageBloc,
    this.crossAxisCount = 3,
    this.fit = BoxFit.contain,
    this.onDataChanged,
  });

  @override
  State<PrimaryReorderGridImage> createState() =>
      _PrimaryReorderGridImageState();
}

class _PrimaryReorderGridImageState extends State<PrimaryReorderGridImage> {
  Map<String, dynamic> updateBusinessDetail() {
    return {
      "bannerList": widget.getImageBloc.imageData,
    };
  }

  @override
  void initState() {
    super.initState();
    widget.getImageBloc.add(
      GetImageInitialEvent(
          maxQuantity: widget.maxQuantity,
          initialData: List<ImageDataWrapper>.from(widget.initialData.map(
            (e) => ImageDataWrapper(type: ImageDataType.uri, data: e),
          )).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.getImageBloc,
      child: BlocBuilder<GetImageBloc, GetImageState>(
        buildWhen: (pre, current) => current is GetImageSuccessState,
        builder: (context, state) {
          if (state is GetImageSuccessState) {
            widget.onDataChanged?.call(state.imageData);
            return ReorderableGridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onReorder: (oldIndex, newIndex) {
                  widget.getImageBloc.add(GetImageReorderEvent(
                      oldIndex: oldIndex, newIndex: newIndex));
                },
                itemCount: state.imageData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  childAspectRatio: widget.childAspectRatio,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) => state.imageData[index].type ==
                        ImageDataType.addNew
                    ? InkWell(
                        key: ValueKey(index),
                        onTap: () {
                          widget.getImageBloc.add(GetImageMultiPickerEvent(
                              maxQuantity: widget.maxQuantity));
                        },
                        child: DottedBorder(
                          color: AppColor.primaryColor,
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppColor.primaryColor,
                                ),
                                Text('Tải ảnh lên'),
                              ],
                            ),
                          ),
                        ),
                      )
                    : PrimaryContainer(
                        key: ValueKey(index),
                        padding: const EdgeInsets.all(2),
                        borderColor: AppColor.gray09,
                        backgroundColor: AppColor.white,
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: [
                            state.imageData[index].type ==
                                    ImageDataType.localPath
                                ? Image(
                                    image: FileImage(
                                        File(state.imageData[index].data)),
                                    fit: BoxFit.cover,
                                  )
                                : PrimaryNetworkImage(
                                    fit: widget.fit,
                                    imageUrl: state.imageData[index].data ?? '',
                                  ),
                            Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  widget.getImageBloc.add(
                                      GetImageRemoveSingleImageEvent(
                                          imagePathIndex: index));
                                },
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor:
                                      AppColor.primaryColor.withOpacity(0.8),
                                  child: const Icon(
                                    Icons.clear_sharp,
                                    size: 12,
                                    color: AppColor.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ));
          } else {
            return const PrimaryShimmer(
                child: ContainerShimmer(
              height: 100,
            ));
          }
        },
      ),
    );
  }
}
