part of 'get_image_bloc.dart';

abstract class GetImageEvent {}

class AddImageEvent extends GetImageEvent {
  final File image;
  final int imgType;

  AddImageEvent({required this.image, required this.imgType});
}

class GetImageInitialEvent extends GetImageEvent {
  final List<ImageDataWrapper> initialData;
  final int? maxQuantity;

  GetImageInitialEvent({required this.initialData, this.maxQuantity = 5});
}

class RemoveImageEvent extends GetImageEvent {
  final int index;
  final int imgType;

  RemoveImageEvent({required this.index, required this.imgType});
}

class GetImageReorderEvent extends GetImageEvent {
  final int oldIndex;
  final int newIndex;

  GetImageReorderEvent({required this.oldIndex, required this.newIndex});
}

class GetImageRemoveSingleImageEvent extends GetImageEvent {
  final int imagePathIndex;

  GetImageRemoveSingleImageEvent({required this.imagePathIndex});
}

class GetImageCameraEvent extends GetImageEvent {}

class GetImagePickerEvent extends GetImageEvent {
  final bool shouldCrop;
  final ImageType type;

  GetImagePickerEvent({
    this.shouldCrop = false,
    this.type = ImageType.none,
  });
}

class GetImageMultiPickerEvent extends GetImageEvent {
  final int? maxQuantity;

  GetImageMultiPickerEvent({this.maxQuantity = 99999999});
}

class GetImageUploadImageEvent extends GetImageEvent {}

class GetImageGetImageUrlEvent extends GetImageEvent {
  final String imagePath;
  final ImageType imageType;

  GetImageGetImageUrlEvent({
    required this.imagePath,
    required this.imageType,
  });
}

class GetImageGetMultiImageUrlEvent extends GetImageEvent {}

class ChangeImageTypeEvent extends GetImageEvent {
  final int imgType;

  ChangeImageTypeEvent({required this.imgType});
}
