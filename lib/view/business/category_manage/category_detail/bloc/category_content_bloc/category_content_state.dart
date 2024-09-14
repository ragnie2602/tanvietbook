part of 'category_content_bloc.dart';

@immutable
abstract class CategoryContentState {}

class CategoryContentInitial extends CategoryContentState {
  final LandingPageContentResponse valueContent;

  CategoryContentInitial({required this.valueContent});
}

class CategoryContentLoading extends CategoryContentState {}
