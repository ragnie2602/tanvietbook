part of 'add_category_content_bloc.dart';

@immutable
abstract class AddCategoryContentEvent {}

class AddCategoryContentInitEvent implements AddCategoryContentEvent {
  final String? subTabId;

  AddCategoryContentInitEvent({required this.subTabId});
}
