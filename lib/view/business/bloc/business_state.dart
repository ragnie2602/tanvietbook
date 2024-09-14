part of 'business_bloc.dart';

abstract class BusinessState {}

class BusinessInitial extends BusinessState {}

class BusinessGetOverallSuccessState extends BusinessState {
  final BusinessOverallResponse webMiniOverallResponse;

  BusinessGetOverallSuccessState({required this.webMiniOverallResponse});
}

class BusinessGetOverallFailedState extends BusinessState {}

class BusinessGetAllSuccessState extends BusinessState {
  final List<BusinessGetAllResponse> businessList;

  BusinessGetAllSuccessState({required this.businessList});
}

class BusinessGetAllSuccessFailedState extends BusinessState {}

class BusinessGetSubTabSuccessState extends BusinessState {
  final List<BusinessSubTabResponse> subTabList;

  BusinessGetSubTabSuccessState({required this.subTabList});
}

class BusinessGetCategorySuccessState extends BusinessState {
  final List<BusinessCategoryResponse> categoryList;

  BusinessGetCategorySuccessState({required this.categoryList});
}

class BusinessGetDetailSuccessState extends BusinessState {
  final BusinessDetailResponse businessDetailResponse;

  BusinessGetDetailSuccessState({required this.businessDetailResponse});
}

class BusinessGetDetailFailedState extends BusinessState {}

class BusinessGetAllProductSuccessState extends BusinessState {
  final List<ProductDetailResponse> productList;
  final String? categoryId;

  BusinessGetAllProductSuccessState(
      {this.categoryId, required this.productList});
}

class BusinessGetAllProductFailedState extends BusinessState {}

class BusinessGetProductDetailSuccessState extends BusinessState {
  final ProductDetailResponse productDetailResponse;

  BusinessGetProductDetailSuccessState({required this.productDetailResponse});
}

class BusinessGetProductDetailFailedState extends BusinessState {}

class BusinessDeleteProductDetailSuccessState extends BusinessState {}

class BusinessDeleteProductDetailFailedState extends BusinessState {}

class BusinessFilterDataChangedState extends BusinessState {}
