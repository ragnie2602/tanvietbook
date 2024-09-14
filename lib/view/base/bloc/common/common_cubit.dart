import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'common_state.dart';

class CommonCubit extends Cubit<CommonState> {
  CommonCubit() : super(CommonInitial());

  showLoading({bool dismissible = true}) {
    emit(CommonShowLoadingState(isLoading: true, isdismissible: dismissible));
  }

  hideLoading() {
    emit(CommonShowLoadingState(isLoading: false));
  }

  showToast(String message, {Widget? child}) {
    emit(CommonToastMessage(isShow: true, message: message, child: child));
  }

  hideToast() {
    emit(CommonToastMessage(isShow: false));
  }

  onBottomNavigationPressed(int index) {
    emit(CommonOnBottomNavigationPressed(index: index));
  }
}
