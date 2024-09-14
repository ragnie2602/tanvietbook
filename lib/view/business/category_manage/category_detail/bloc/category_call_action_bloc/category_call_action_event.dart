part of 'category_call_action_bloc.dart';

@immutable
abstract class CategoryCallActionEvent {}

class CategoryCallActionInitEvent extends CategoryCallActionEvent {
  final String landingId;

  CategoryCallActionInitEvent({required this.landingId});
}

class CategoryCallActionUpdateEvent extends CategoryCallActionEvent {
  final String title;
  final String actionInfor;

  CategoryCallActionUpdateEvent(
      {required this.title, required this.actionInfor});
}

class CategoryCallActionGetActionEvent extends CategoryCallActionEvent {
  final String actionId;

  CategoryCallActionGetActionEvent({required this.actionId});
}

class CategoryCallActionCreateActionEvent extends CategoryCallActionEvent {}

class CategoryCallActionGetAllEvent extends CategoryCallActionEvent {}
