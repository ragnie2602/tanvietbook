import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/repository/remote/repository.dart';
import '../../../di/di.dart';
import '../../../model/api/base_response.dart';
import '../../../model/member/user_settings_response/user_settings_response.dart';

part 'sso_state.dart';
part 'sso_cubit.freezed.dart';

class SsoCubit extends Cubit<SsoState> {
  SsoCubit() : super(const SsoState.initial());
  final OpenIDRepository _openIDRepository = getIt.get();

  UserSettingsResponse? user;

  getUserSSOInfo() async {
    final response = await _openIDRepository.getCurrentMemberSettingInfo();
    if (response.status == ResponseStatus.success) {
      user = response.data;
      emit(SsoState.getUserInfoSuccessState(user!));
    } else {
      emit(SsoState.getUserInfoFailedState());
    }
  }
}
