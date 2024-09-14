part of 'category_images_bloc.dart';

@immutable
abstract class CategoryImagesState {}

class CategoryImagesInitial extends CategoryImagesState {
  final List<LandingPageImageResponse> listImage;

  CategoryImagesInitial({required this.listImage});
}

class CategoryImagesLoading extends CategoryImagesState {}
