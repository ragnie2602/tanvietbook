part of 'category_content_bloc.dart';

@immutable
abstract class CategoryContentEvent {}

class CategoryContentInitEvent extends CategoryContentEvent {
  final String landingId;

  CategoryContentInitEvent({required this.landingId});
}

class CategoryContentUpdateEvent extends CategoryContentEvent {
  final String value;
  final String contentId;

  CategoryContentUpdateEvent({required this.contentId, required this.value});
}
