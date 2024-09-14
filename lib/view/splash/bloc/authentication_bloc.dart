import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/local/local_data_access.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LocalDataAccess localDataAccess;

  AuthenticationBloc({required this.localDataAccess})
      : super(AuthenticationInitial()) {
    on<AuthenticationInitialEvent>(_onInitial);
  }

  FutureOr<void> _onInitial(
      AuthenticationInitialEvent event, Emitter<AuthenticationState> emit) {
    final accessToken = localDataAccess.getAccessToken();
    log('accessToken: $accessToken + ${accessToken.isEmpty}');
    if (accessToken.isEmpty) {
      emit(AuthenticationInitErrorState());
    } else {
      emit(AuthenticationInitSuccessState());
    }
  }
}
