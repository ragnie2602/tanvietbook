part of 'category_manage_bloc.dart';

@immutable
abstract class CategoryManageEvent {}

class CategoryManageInitEvent implements CategoryManageEvent {}

class CategoryManageGetAllEvent implements CategoryManageEvent {}

class CategoryManageGetAllByTypeEvent implements CategoryManageEvent {
  final String? username;
  final String type;

  CategoryManageGetAllByTypeEvent(
      {this.username, this.type = CategoryType.all});
}

class CategoryManageRearrangeEvent implements CategoryManageEvent {}

class CategoryManageDeleteEvent implements CategoryManageEvent {
  final String cid;
  final int index;

  CategoryManageDeleteEvent({required this.cid, required this.index});
}

class CategoryManageCreateEvent implements CategoryManageEvent {
  final BusinessCategoryResponse categoryResponse;

  CategoryManageCreateEvent({required this.categoryResponse});
}

class CategoryManageUpdateEvent implements CategoryManageEvent {}

class CategoryManageSearchEvent implements CategoryManageEvent {}

class CategoryManageSwapEvent implements CategoryManageEvent {
  final List<String> listCategoryId;

  CategoryManageSwapEvent({required this.listCategoryId});
}
