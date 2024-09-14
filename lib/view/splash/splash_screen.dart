import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';

import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/repository/local/local_data_access.dart';
import '../../data/resources/resources.dart';
import '../../di/di.dart';
import '../home_page/home_screen.dart';
import '../login_screens/login_screen.dart';
import '../user_profile/user_profile.dart';
import 'bloc/authentication_bloc.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String appLinkUsernameReceived =
        (ModalRoute.of(context)?.settings.arguments as SplashScreenArgs).appLinkUsernameReceived;
    final Upgrader upGrader = Upgrader(
      debugDisplayAlways: false,
      durationUntilAlertAgain: const Duration(days: 1),
      showLater: false,
      debugLogging: true,
      canDismissDialog: true,
      messages: UpgraderMessages(
          code: 'Đã có phiên bản mới của True Connect. Vui lòng cập nhật để sử dụng các tính năng mới nhất.'),
    );

    return BlocProvider(
      create: (_) =>
          AuthenticationBloc(localDataAccess: getIt.get<LocalDataAccess>())..add(AuthenticationInitialEvent()),
      child: UpgradeAlert(
        upgrader: upGrader,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationInitSuccessState) {
              Timer(const Duration(seconds: 1), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            appLinkUsernameReceived: appLinkUsernameReceived,
                          )),
                );
              });
            } else if (state is AuthenticationInitErrorState) {
              // (duration)
              Future.delayed(const Duration(seconds: 1), () {
                // if app is not opened by appLinking
                if (appLinkUsernameReceived.isEmpty) {
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfile(
                                memberUserName: appLinkUsernameReceived,
                                viewType: ViewType.viewMember,
                              )),
                      (route) => false);
                }
              });
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Image.asset(Assets.imLogoTanvietbookFull),
              ),
            ),
          ),
        ),
      ),
    );
    // backgroundColor: bgColor,
  }
}
