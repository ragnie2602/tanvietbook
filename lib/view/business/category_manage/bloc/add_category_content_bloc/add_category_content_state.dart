part of 'add_category_content_bloc.dart';

@immutable
abstract class AddCategoryContentState {}

class AddCategoryContentInitial extends AddCategoryContentState {
  final List<CategoryListItem> listCategory;

  AddCategoryContentInitial({required this.listCategory});
}

class AddCategoryContentLoading extends AddCategoryContentState {}
