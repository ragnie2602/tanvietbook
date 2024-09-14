part of 'category_link_bloc.dart';

@immutable
abstract class CategoryLinkEvent {}

class CategoryLinkInitEvent extends CategoryLinkEvent {
  final String landingId;

  CategoryLinkInitEvent({required this.landingId});
}

class CategoryLinkUpdateEvent extends CategoryLinkEvent {
  final String title;
  final String link;

  CategoryLinkUpdateEvent({required this.title, required this.link});
}
