import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../di/di.dart';
import '../../../model/business/detail/business_detail_response.dart';
import '../../../shared/utils/view_utils.dart';

import '../../../data/repository/remote/repository.dart';
import '../../../model/api/base_response.dart';
import '../../../model/business/product/product_detail_response.dart';

part 'business_update_event.dart';

part 'business_update_state.dart';

class BusinessUpdateBloc
    extends Bloc<BusinessUpdateEvent, BusinessUpdateState> {
  final AppRepository appRepository = getIt.get<AppRepository>();

  BusinessDetailResponse businessDetailResponse =
      const BusinessDetailResponse();

  late ProductDetailResponse productDetailResponse;

  BusinessUpdateBloc() : super(BusinessUpdateInitial()) {
    on<BusinessUpdateInfoEvent>(_onUpdateInfo);
    on<BusinessUpdateProductEvent>(_onUpdateProduct);
    on<BusinessCreateNewProductEvent>(_onCreateNewProduct);
  }

  FutureOr<void> _onUpdateInfo(
      BusinessUpdateInfoEvent event, Emitter<BusinessUpdateState> emit) async {
    final request = BusinessDetailUpdateRequest(
      id: businessDetailResponse.id,
      memberId: businessDetailResponse.memberId,
      websiteName: businessDetailResponse.websiteName,
      logo: businessDetailResponse.logo,
      email: businessDetailResponse.email,
      emailEnable: businessDetailResponse.emailEnable,
      phoneNumber: businessDetailResponse.phoneNumber,
      phoneNumberEnable: businessDetailResponse.phoneNumberEnable,
      messenger: businessDetailResponse.messenger,
      messengerEnable: businessDetailResponse.messengerEnable,
      zalo: businessDetailResponse.zalo,
      zaloEnable: businessDetailResponse.zaloEnable,
      description: businessDetailResponse.description,
      banners: event.bannersImagePath,
    );

    final response = await appRepository.updateBusinessDetail(
        businessDetailUpdateRequest: request);
    if (response.status == ResponseStatus.success) {
      emit(BusinessUpdateInfoSuccessState(
          businessDetailResponse: response.data!));
    } else {
      emit(BusinessUpdateInfoFailedState());
    }
  }

  FutureOr<void> _onUpdateProduct(BusinessUpdateProductEvent event,
      Emitter<BusinessUpdateState> emit) async {
    final response = await appRepository.updateBusinessProduct(
        productDetailResponse: productDetailResponse);
    if (response.status == ResponseStatus.success) {
      toastSuccess('Cập nhật thông tin bài đăng thành công');
      emit(BusinessUpdateProductSuccessState(
          productDetailResponse: response.data!));
    } else {
      toastSuccess('Cập nhật thông tin bài đăng thất bại');
      emit(BusinessUpdateProductFailedState());
    }
  }

  FutureOr<void> _onCreateNewProduct(BusinessCreateNewProductEvent event,
      Emitter<BusinessUpdateState> emit) async {
    final response = await appRepository.createBusinessProduct(
        productDetailResponse: productDetailResponse);
    if (response.status == ResponseStatus.success) {
      toastSuccess("Tạo bài đăng mới thành công");
      emit(BusinessCreateProductSuccessState(
          productDetailResponse: response.data!));
    } else {
      toastWarning("Tạo bài đăng mới thất bại");
      emit(BusinessCreateProductFailedState());
    }
  }
}
