part of 'category_button_bloc.dart';

@immutable
abstract class CategoryButtonEvent {}

class CategoryButtonInitEvent extends CategoryButtonEvent {
  final String landingId;

  CategoryButtonInitEvent({required this.landingId});
}

class CategoryButtonUpdateEvent extends CategoryButtonEvent {}
