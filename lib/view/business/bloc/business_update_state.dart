part of 'business_update_bloc.dart';

@immutable
abstract class BusinessUpdateState {}

class BusinessUpdateInitial extends BusinessUpdateState {}

class BusinessUpdateInfoSuccessState extends BusinessUpdateState {
  final BusinessDetailResponse businessDetailResponse;

  BusinessUpdateInfoSuccessState({required this.businessDetailResponse});
}

class BusinessUpdateInfoFailedState extends BusinessUpdateState {}

class BusinessUpdateProductSuccessState extends BusinessUpdateState {
  final ProductDetailResponse productDetailResponse;

  BusinessUpdateProductSuccessState({required this.productDetailResponse});
}

class BusinessUpdateProductFailedState extends BusinessUpdateState {}

class BusinessCreateProductSuccessState extends BusinessUpdateState {
  final ProductDetailResponse productDetailResponse;

  BusinessCreateProductSuccessState({required this.productDetailResponse});
}

class BusinessCreateProductFailedState extends BusinessUpdateState {}
