part of 'category_manage_bloc.dart';

@immutable
abstract class CategoryManageState {}

class CategoryManageInitial extends CategoryManageState {}

class CategoryManageGetAllSuccessState extends CategoryManageState {
  final List<BusinessCategoryResponse> categoryList;

  CategoryManageGetAllSuccessState({required this.categoryList});
}

class CategoryManageGetAllErrorState extends CategoryManageState {}

class CategoryManageCreateSuccessState extends CategoryManageState {
  final BusinessCategoryResponse businessCategoryResponse;

  CategoryManageCreateSuccessState({required this.businessCategoryResponse});
}

class CategoryManageCreateFailedState extends CategoryManageState {}

class CategoryManageDeleteSuccessState extends CategoryManageState {}

class CategoryManageDeleteFailedState extends CategoryManageState {}

class CategoryManageSwapSuccessState extends CategoryManageState {}
