part of 'category_images_bloc.dart';

@immutable
abstract class CategoryImagesEvent {}

class CategoryImagesInitEvent extends CategoryImagesEvent {
  final String landingId;

  CategoryImagesInitEvent({required this.landingId});
}

class CategoryImagesDeleteEvent extends CategoryImagesEvent {
  final String imageId;

  CategoryImagesDeleteEvent({required this.imageId});
}

class CategoryImagesUpdateEvent extends CategoryImagesEvent {
  final List<String> listImageUri;

  CategoryImagesUpdateEvent({required this.listImageUri});
}
