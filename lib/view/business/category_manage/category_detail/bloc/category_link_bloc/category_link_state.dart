part of 'category_link_bloc.dart';

@immutable
abstract class CategoryLinkState {}

class CategoryLinkInitial extends CategoryLinkState {
  final LandingPageLinkResponse currentLink;

  CategoryLinkInitial({required this.currentLink});
}

class CategoryLinkLoading extends CategoryLinkState {}
