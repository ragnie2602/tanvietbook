import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../data/repository/remote/category_repository.dart';
import '../../../../../di/di.dart';
import '../../../../../model/api/base_response.dart';
import '../../../../../model/business/category/business_category_response.dart';

import '../../../../../data/constants.dart';

part 'category_manage_event.dart';

part 'category_manage_state.dart';

class CategoryManageBloc
    extends Bloc<CategoryManageEvent, CategoryManageState> {
  CategoryRepository categoryRepository = getIt.get<CategoryRepository>();
  String currentSubTabId = '';
  final List<BusinessCategoryResponse> categoryList = [];

  CategoryManageBloc() : super(CategoryManageInitial()) {
    on<CategoryManageGetAllEvent>(_onGetAll);
    on<CategoryManageGetAllByTypeEvent>(_onGetAllByType);
    on<CategoryManageRearrangeEvent>((event, emit) {});
    on<CategoryManageDeleteEvent>(_onDelete);
    on<CategoryManageCreateEvent>(_onCreate);
    on<CategoryManageUpdateEvent>((event, emit) {});
    on<CategoryManageSearchEvent>((event, emit) {});
    on<CategoryManageSwapEvent>(_onSwap);
  }

  FutureOr<void> _onGetAll(CategoryManageGetAllEvent event,
      Emitter<CategoryManageState> emit) async {
    final response = await categoryRepository.getAllBusinessCategory(
        subTabId: currentSubTabId);
    if (response.status == ResponseStatus.success) {
      categoryList.clear();
      categoryList.addAll((response.data?.data ?? []).toList());
      emit(CategoryManageGetAllSuccessState(categoryList: categoryList));
    }
  }

  FutureOr<void> _onGetAllByType(CategoryManageGetAllByTypeEvent event,
      Emitter<CategoryManageState> emit) async {
    final response = await categoryRepository.getAllBusinessCategoryByType(
        page: 1,
        pageSize: 999999,
        type: CategoryType.post,
        subTabId: currentSubTabId);
    if (response.status == ResponseStatus.success) {
      categoryList.clear();
      categoryList.addAll((response.data?.data ?? []).reversed.toList());
      emit(CategoryManageGetAllSuccessState(categoryList: categoryList));
    }
  }

  FutureOr<void> _onCreate(CategoryManageCreateEvent event,
      Emitter<CategoryManageState> emit) async {
    final response = await categoryRepository.createCategory(
        category: event.categoryResponse);
    if (response.status == ResponseStatus.success) {
      emit(CategoryManageCreateSuccessState(
          businessCategoryResponse: response.data!));
      categoryList.insert(0, response.data!);
      emit(CategoryManageGetAllSuccessState(categoryList: categoryList));
    } else {
      emit(CategoryManageCreateFailedState());
    }
  }

  FutureOr<void> _onDelete(CategoryManageDeleteEvent event,
      Emitter<CategoryManageState> emit) async {
    final response = await categoryRepository.deleteCategory(event.cid);
    if (response.status == ResponseStatus.success) {
      emit(CategoryManageDeleteSuccessState());
      categoryList.removeAt(event.index);
      emit(CategoryManageGetAllSuccessState(categoryList: categoryList));
    } else {
      emit(CategoryManageDeleteFailedState());
    }
  }

  FutureOr<void> _onSwap(
      CategoryManageSwapEvent event, Emitter<CategoryManageState> emit) async {
    final ResponseWrapper response =
        await categoryRepository.swapCategory(event.listCategoryId);
    if (response.status == ResponseStatus.success) {
      await _onGetAll(CategoryManageGetAllEvent(), emit);
    }
  }
}
