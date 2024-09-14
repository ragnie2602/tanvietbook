import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/config.dart';
import '../../data/constants.dart';
import '../../data/resources/resources.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/view_utils.dart';
import '../../shared/widgets/dialog_helper.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/secondary_text_field.dart';
import '../home_page/home_screen.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool _obscureText = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late BuildContext dialogContext;

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc()..add(LoginInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => _loginBloc,
      child: Scaffold(
        backgroundColor: const Color(0xFFfeeb9b),
        body: SafeArea(
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  // listen state
                  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TranslationAnimatedWidget(
                    enabled: true,
                    duration: const Duration(milliseconds: 1000),
                    values: const [
                      Offset(0, -100), // disabled value value
                      Offset(0, 0), //intermediate value
                      Offset(0, 0) //enabled value
                    ],
                    curve: Curves.slowMiddle,
                    child: OpacityAnimatedWidget.tween(
                      opacityEnabled: 1,
                      opacityDisabled: 0,
                      duration: const Duration(milliseconds: 1200),
                      child: Image.asset(Assets.imLogoTanvietbookFull),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginFieldRequiredState) {
                        toastWarning(
                            'Tên đăng nhập và mật khẩu không được bỏ trống');
                      }
                      if (state is LoginLoadingState) {
                        showDialog(
                          context: context,
                          builder: (context) => getLoadingDialog(),
                          barrierDismissible: false,
                        );
                      }
                      if (state is LoginSuccessState) {
                        WidgetsBinding.instance
                            .addPostFrameCallback(((timeStamp) {
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            // UserProfile(viewType: ViewType.viewOwn)),
                            //HomeScreen
                            (route) => false,
                          );
                        }));
                      }
                      if (state is LoginFailedState) {
                        Navigator.of(context, rootNavigator: true).pop();
                        toastWarning(state.message!);
                      }
                      if (state is LoginGetLocalInfoState) {
                        usernameController.text = state.username;
                        passwordController.text = state.password;
                        _rememberMe = state.accountRemember;
                      }

                      if (state is LoginBySSOSuccessState) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomeScreen()), //HomeScreen
                          (route) => false,
                        );
                      }
                      if (state is LoginBySSOErrorState) {
                        toastWarning(
                            'Đăng nhập không thành công. Vui lòng thử lại.\n${state.message}');
                      }
                    },
                    child: const SizedBox(
                      height: 16,
                    ),
                  ),
                  OpacityAnimatedWidget.tween(
                    opacityEnabled: 1,
                    opacityDisabled: 0,
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                          color: AppColor.titleColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Tài khoản', style: AppTextTheme.titleMedium),
                  SecondaryTextField(
                    controller: usernameController,
                    textInputAction: TextInputAction.next,
                    fillColor: Colors.transparent,
                    maxLength: 100,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Mật khẩu', style: AppTextTheme.titleMedium),
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (pre, current) =>
                        current is LoginShowPasswordState,
                    builder: (context, state) {
                      return SecondaryTextField(
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        fillColor: Colors.transparent,
                        maxLength: 100,
                        maxLines: 1,
                        obscureText: _obscureText,
                        onSubmitted: (value) {
                          _loginBloc.add(LoginRequestEvent(
                              username: usernameController.text,
                              password: passwordController.text,
                              rememberMe: _rememberMe));
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            _obscureText = !_obscureText;
                            _loginBloc.add(
                              LoginShowPasswordEvent(
                                  showPassword: _obscureText),
                            );
                          },
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColor.black,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BlocBuilder<LoginBloc, LoginState>(
                          buildWhen: (pre, current) =>
                              current is LoginRememberState,
                          builder: (context, state) {
                            return (state is LoginRememberState)
                                ? CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    dense: false,
                                    value: state.remember,
                                    checkColor: AppColor.white,
                                    activeColor: AppColor.primaryColor,
                                    onChanged: (value) {
                                      _rememberMe = value!;
                                      _loginBloc.add(
                                          LoginRememberEvent(!state.remember));
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: Colors.red,
                                    title: const Text(
                                      'Nhớ tài khoản',
                                      style: AppTextTheme.textPrimary,
                                    ))
                                : Container();
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Utils.launchUri(
                                '${SSOConfig.issuer}/Account/ForgotPassword',
                                UriType.website);
                          },
                          child: Text('Quên mật khẩu?',
                              style: AppTextTheme.bodyStrong
                                  .copyWith(color: AppColor.primaryColor)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                    context: context,
                    onPressed: () {
                      _loginBloc.add(LoginRequestEvent(
                          username: usernameController.text,
                          password: passwordController.text,
                          rememberMe: _rememberMe));
                    },
                    label: "Đăng Nhập",
                  ),
                  // BlocListener<LoginBloc, LoginState>(
                  //   listener: (context, state) {
                  //     if (state is LoginFieldRequiredState) {
                  //       toastWarning(
                  //           'Tên đăng nhập và mật khẩu không được bỏ trống');
                  //     }
                  //     if (state is LoginLoadingState) {
                  //       showDialog(
                  //         context: context,
                  //         builder: (context) => getLoadingDialog(),
                  //         barrierDismissible: false,
                  //       );
                  //     }
                  //     if (state is LoginSuccessState) {
                  //       WidgetsBinding.instance
                  //           .addPostFrameCallback(((timeStamp) {
                  //         Navigator.of(context, rootNavigator: true).pop();
                  //         Navigator.pushAndRemoveUntil(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => const HomeScreen()),
                  //           // UserProfile(viewType: ViewType.viewOwn)),
                  //           //HomeScreen
                  //           (route) => false,
                  //         );
                  //         // context.read<ManageNotiBloc>()
                  //         // .add(NotificationRegisterFCMTokenEvent())
                  //         // ;
                  //       }));
                  //     }
                  //     if (state is LoginFailedState) {
                  //       Navigator.of(context, rootNavigator: true).pop();
                  //       toastWarning(state.message!);
                  //     }
                  //     if (state is LoginGetLocalInfoState) {
                  //       usernameController.text = state.username;
                  //       passwordController.text = state.password;
                  //       _rememberMe = state.accountRemember;
                  //     }
                  //     if (state is LoginFailedState) {
                  //       Navigator.of(context, rootNavigator: true).pop();
                  //       toastWarning(state.message!);
                  //     }
                  //     if (state is LoginBySSOSuccessState) {
                  //       Navigator.pushAndRemoveUntil(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const HomeScreen()),
                  //         //HomeScreen
                  //         (route) => false,
                  //       );
                  //     }
                  //     if (state is LoginBySSOErrorState) {
                  //       toastWarning(
                  //           'Đăng nhập không thành công. Vui lòng thử lại.\n${state.message}');
                  //     }
                  //   },
                  //   child: const SizedBox(
                  //     height: 16,
                  //   ),
                  // ),
                  // BlocBuilder<LoginBloc, LoginState>(
                  //   buildWhen: (pre, current) =>
                  //       current is LoginBySSOLoadingState ||
                  //       current is LoginBySSOSuccessState ||
                  //       current is LoginBySSOErrorState,
                  //   builder: (context, state) {
                  //     if (state is LoginBySSOLoadingState) {
                  //       return PrimaryButton(
                  //           context: context,
                  //           isLoading: true,
                  //           // backgroundColor: AppColor.secondaryColor,
                  //           onPressed: () => null,
                  //           label: '');
                  //     } else {
                  //       return PrimaryButton(
                  //           context: context,
                  //           // backgroundColor: AppColor.secondaryColor,
                  //           onPressed: () {
                  //             _loginBloc.add(LoginBySSORequestEvent());
                  //           },
                  //           backgroundColor: AppColor.primaryColor,
                  //           label: "Đăng Nhập Với True Connect");
                  //     }
                  //   },
                  // ),

                  // Center(
                  //   child: RichText(
                  //       text: TextSpan(
                  //           text: "Chưa có tài khoản? ",
                  //           style: AppTextTheme.textPrimary,
                  //           children: [
                  //         TextSpan(
                  //             text: "Tạo tài khoản",
                  //             style: AppTextTheme.textPrimaryColor.copyWith(
                  //                 fontSize: 16, fontWeight: FontWeight.w700),
                  //             recognizer: TapGestureRecognizer()
                  //               ..onTap = () {
                  //                 // Navigator.push(
                  //                 //     context,
                  //                 //     MaterialPageRoute(
                  //                 //         builder: (context) =>
                  //                 //             CreateNewAccount())
                  //                 // );
                  //                 Utils.launchUri(
                  //                     SSOConfig.register, UriType.website);
                  //                 // showDialog(
                  //                 //   context: context,
                  //                 //   builder: (context) => getLoadingDialog(),
                  //                 //   barrierDismissible: false,
                  //                 // );
                  //               })
                  //       ])),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
