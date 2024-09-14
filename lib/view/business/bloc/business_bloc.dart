import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../di/di.dart';
import '../../../model/api/base_response.dart';
import '../../../model/business/category/business_category_response.dart';
import '../../../model/business/product/product_detail_response.dart';
import '../../../model/business/sub_tab/business_sub_tab_response.dart';

import '../../../data/constants.dart';
import '../../../data/repository/remote/repository.dart';
import '../../../model/business/business_get_all_response/business_get_all_response.dart';
import '../../../model/business/detail/business_detail_response.dart';
import '../../../model/business/overall/business_overall_response.dart';

part 'business_event.dart';

part 'business_state.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  final AppRepository appRepository = getIt.get<AppRepository>();
  final CategoryRepository _categoryRepository =
      getIt.get<CategoryRepository>();

  String currentSelectedBusinessId = '';
  String currentBusinessSubTabId = '';
  String? currentUsername;
  final List<BusinessGetAllResponse> businessList = [];
  final List<ProductDetailResponse> productList = [];
  late BusinessOverallResponse businessOverallResponse;
  late BusinessManageFilterData businessManageFilterData;

  BusinessBloc() : super(BusinessInitial()) {
    on<BusinessInitialEvent>(_onInitial);
    on<BusinessGetAllEvent>(_onGetAllBusiness);
    on<BusinessGetOverallEvent>(_onGetOverall);
    on<BusinessRebuildEvent>(_onRebuildOverall);
    on<BusinessGetSubTabEvent>(_onGetSubTab);
    on<BusinessGetDetailEvent>(_onGetDetail);
    on<BusinessGetCategoryEvent>(_onGetCategory);

    on<BusinessGetAllProductEvent>(_onGetAllProduct);
    on<BusinessChangePositionProductEvent>(_onChangePositionProduct);
    on<BusinessAddNewProductEvent>(_onAddNewProduct);
    on<BusinessDeleteProductDetailEvent>(_onDeleteProduct);
    on<BusinessGetProductDetailEvent>(_onGetProductDetail);
    on<BusinessFilterDataChanged>(_onBusinessFilterDataChanged);
  }

  FutureOr<void> _onInitial(
      BusinessEvent event, Emitter<BusinessState> emit) async {
    emit(BusinessInitial());
  }

  FutureOr<void> _onGetAllBusiness(
      BusinessGetAllEvent event, Emitter<BusinessState> emit) async {
    final response = await appRepository.getAllBusiness();
    if (response.status == ResponseStatus.success) {
      businessList.addAll(response.data ?? []);
      emit(BusinessGetAllSuccessState(businessList: response.data ?? []));
    } else {
      emit(BusinessGetAllSuccessFailedState());
    }
  }

  FutureOr<void> _onGetOverall(
      BusinessGetOverallEvent event, Emitter<BusinessState> emit) async {
    final response =
        await appRepository.getBusinessOverall(bid: currentSelectedBusinessId);
    if (response.status == ResponseStatus.success) {
      businessOverallResponse = response.data!;
      emit(BusinessGetOverallSuccessState(
          webMiniOverallResponse: businessOverallResponse));
    } else {}
  }

  FutureOr<void> _onRebuildOverall(
      BusinessRebuildEvent event, Emitter<BusinessState> emit) {
    emit(BusinessGetOverallSuccessState(
        webMiniOverallResponse: businessOverallResponse));
  }

  FutureOr<void> _onGetDetail(
      BusinessGetDetailEvent event, Emitter<BusinessState> emit) async {
    final response =
        await appRepository.getBusinessDetail(bid: currentSelectedBusinessId);
    if (response.status == ResponseStatus.success) {
      emit(BusinessGetDetailSuccessState(
          businessDetailResponse: response.data!));
    } else {}
  }

  FutureOr<void> _onGetCategory(
      BusinessGetCategoryEvent event, Emitter<BusinessState> emit) async {
    final ResponseWrapper<BusinessCategoryGetAllResponse> response;

    if (event.type == CategoryType.all) {
      response = await _categoryRepository.getAllBusinessCategory(
          subTabId: event.subTabId ?? currentBusinessSubTabId,
          username: event.username);
    } else {
      response = await _categoryRepository.getAllBusinessCategoryByType(
          subTabId: event.subTabId ?? currentBusinessSubTabId,
          username: event.username,
          type: event.type,
          page: 1,
          pageSize: 999);
    }
    if (response.status == ResponseStatus.success) {
      emit(BusinessGetCategorySuccessState(
          categoryList: response.data?.data ?? []));
    } else {}
  }

  FutureOr<void> _onGetSubTab(
      BusinessGetSubTabEvent event, Emitter<BusinessState> emit) async {
    final response = await appRepository.getBusinessSubTab(
        bid: currentSelectedBusinessId, username: event.username);
    if (response.status == ResponseStatus.success) {
      currentBusinessSubTabId =
          response.data!.isNotEmpty ? response.data![0].id ?? '' : '';
      emit(BusinessGetSubTabSuccessState(subTabList: response.data ?? []));
    } else {}
  }

  FutureOr<void> _onGetAllProduct(
      BusinessGetAllProductEvent event, Emitter<BusinessState> emit) async {
    final response = await appRepository.getAllBusinessProduct(
      categoryId: event.categoryId,
      subTabId: currentBusinessSubTabId,
      keyword: event.keyword,
      pageNum: event.pageNum,
      pageSize: event.pageSize,
      username: event.username,
    );
    if (response.status == ResponseStatus.success) {
      productList.clear();
      productList.addAll(response.data?.data ?? []);
      emit(BusinessGetAllProductSuccessState(
          productList: productList, categoryId: event.categoryId));
    } else {
      emit(BusinessGetAllProductFailedState());
    }
  }

  FutureOr<void> _onGetProductDetail(
      BusinessGetProductDetailEvent event, Emitter<BusinessState> emit) async {
    final response = await appRepository.getBusinessProductDetail(
      postId: event.pid,
      username: currentUsername,
    );
    if (response.status == ResponseStatus.success) {
      emit(BusinessGetProductDetailSuccessState(
          productDetailResponse: response.data!));
    } else {
      emit(BusinessGetAllProductFailedState());
    }
  }

  FutureOr<void> _onDeleteProduct(BusinessDeleteProductDetailEvent event,
      Emitter<BusinessState> emit) async {
    final response = await appRepository.deleteBusinessProduct(pid: event.pid);
    if (response.status == ResponseStatus.success) {
      productList.removeAt(event.index);
      emit(BusinessDeleteProductDetailSuccessState());
      emit(BusinessGetAllProductSuccessState(
          productList: productList, categoryId: ''));
    } else {
      emit(BusinessDeleteProductDetailFailedState());
    }
  }

  FutureOr<void> _onAddNewProduct(
      BusinessAddNewProductEvent event, Emitter<BusinessState> emit) {
    productList.insert(productList.length, event.productDetailResponse);
    emit(BusinessGetAllProductSuccessState(
        productList: productList, categoryId: ''));
  }

  FutureOr<void> _onChangePositionProduct(
      BusinessChangePositionProductEvent event,
      Emitter<BusinessState> emit) async {
    ResponseWrapper response =
        await appRepository.changeBusinessProductPosition(
            categoryId: event.categoryId, pidList: event.pidList);
    if (response.status == ResponseStatus.success) {
      _onGetAllProduct(
          BusinessGetAllProductEvent(
              pageNum: 1, pageSize: 100, categoryId: event.categoryId),
          emit);
    }
  }

  FutureOr<void> _onBusinessFilterDataChanged(
      BusinessFilterDataChanged event, Emitter<BusinessState> emit) {
    emit(BusinessFilterDataChangedState());
  }
}

class BusinessManageFilterData {
  final String subTabId;
  bool isSoldOut;
  bool isHidden;
  List<String>? currentCategoryId;
  List<String>? currentCategoryName;
  double? rangeFrom;
  double? rangeTo;

  BusinessManageFilterData({
    required this.subTabId,
    this.isSoldOut = false,
    this.isHidden = false,
    this.currentCategoryId,
    this.currentCategoryName,
    this.rangeFrom,
    this.rangeTo,
  });

  BusinessManageFilterData copyWith({
    String? subTabId,
    bool? isSoldOut,
    bool? isHidden,
    List<String>? currentCategoryId,
    List<String>? currentCategoryName,
    double? rangeFrom,
    double? rangeTo,
  }) {
    return BusinessManageFilterData(
      subTabId: subTabId ?? this.subTabId,
      isSoldOut: isSoldOut ?? this.isSoldOut,
      isHidden: isHidden ?? this.isHidden,
      currentCategoryId: currentCategoryId ?? this.currentCategoryId,
      currentCategoryName: currentCategoryName ?? this.currentCategoryName,
      rangeFrom: rangeFrom ?? this.rangeFrom,
      rangeTo: rangeTo ?? this.rangeTo,
    );
  }
}
