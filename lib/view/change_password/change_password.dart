// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../config/config.dart';
import 'bloc/change_password_bloc/change_password_state.dart';
import '../home_page/home_screen.dart';

import '../../shared/widgets/back_button.dart';
import 'bloc/change_password_bloc/change_password_bloc.dart';
import 'bloc/change_password_bloc/change_password_event.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => ChangePasswordBloc(httpClient: http.Client())),
    ], child: ChangePasswordUI());
  }
}

class ChangePasswordUI extends StatelessWidget {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ChangePasswordUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        if (state is ChangePasswordStateSuccess) {
          // Navigator.pop(context);
          // currentPasswordController.clear();
          // newPasswordController.clear();
          // confirmPasswordController.clear();
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
          // // UserProfile()
          // HomePage()
          //   // CreateProduct()
          //   // const CustomQrCode()
          // ), (route) => false);
          Fluttertoast.showToast(
              msg: 'Đổi mật khẩu thành công', toastLength: Toast.LENGTH_SHORT);
          Future.delayed(Duration.zero, () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        // UserProfile()
                        HomeScreen()
                    // CreateProduct()
                    // const CustomQrCode()
                    ),
                (route) => false);
          });
        } else if (state is ChangePasswordStateFail) {
          Fluttertoast.showToast(
              msg: 'Đổi mật khẩu không thành công',
              toastLength: Toast.LENGTH_SHORT);
        }
        return Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              backgroundColor: bgColor,
              title: const Text(
                'Đổi mật khẩu',
                style: TextStyle(
                    color: textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
              leading: const BackButtonCustom(),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          createTextField(
                              'Mật khẩu cũ',
                              TextFormField(
                                controller: currentPasswordController,
                                maxLength: 32,
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 113, 118, 123),
                                        width: 1),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 150, 50),
                                        width: 1),
                                  ),
                                  suffixIcon: state
                                              is ChangePasswordStateCorrectPassword ||
                                          state
                                              is ChangePasswordStateReadyForChange
                                      ? const Icon(
                                          Icons.check_circle_outline,
                                          color: iconCheckColor,
                                        )
                                      : null,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (state
                                      is ChangePasswordStateWrongPassword) {
                                    return 'Sai mật khẩu.';
                                  }
                                  return null;
                                },
                                obscureText: state.isShow,
                                style: const TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                ),
                                onChanged: (value) {
                                  context.read<ChangePasswordBloc>().add(
                                      ChangePasswordEventCheckException(
                                          currentPassword:
                                              currentPasswordController.text,
                                          newPassword:
                                              newPasswordController.text,
                                          confirmPassword:
                                              confirmPasswordController.text));
                                },
                              )),
                          createTextField(
                              'Mật khẩu mới',
                              TextFormField(
                                controller: newPasswordController,
                                maxLength: 32,
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 113, 118, 123),
                                        width: 1),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 150, 50),
                                        width: 1),
                                  ),
                                  suffixIcon:
                                      state is ChangePasswordStateReadyForChange
                                          ? const Icon(
                                              Icons.check_circle_outline,
                                              color: iconCheckColor,
                                            )
                                          : null,
                                ),
                                obscureText: state.isShow,
                                style: const TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (state
                                          is ChangePasswordStateCorrectPassword &&
                                      currentPasswordController.text ==
                                          newPasswordController.text &&
                                      currentPasswordController
                                          .text.isNotEmpty) {
                                    return 'Trùng mật khẩu.';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  context.read<ChangePasswordBloc>().add(
                                      ChangePasswordEventCheckException(
                                          currentPassword:
                                              currentPasswordController.text,
                                          newPassword:
                                              newPasswordController.text,
                                          confirmPassword:
                                              confirmPasswordController.text));
                                },
                              )),
                          createTextField(
                              'Xác nhận mật khẩu mới',
                              TextFormField(
                                controller: confirmPasswordController,
                                maxLength: 32,
                                decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 113, 118, 123),
                                          width: 1),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 255, 150, 50),
                                          width: 1),
                                    ),
                                    suffixIcon: state
                                            is ChangePasswordStateReadyForChange
                                        ? const Icon(
                                            Icons.check_circle_outline,
                                            color: iconCheckColor,
                                          )
                                        : null),
                                obscureText: state.isShow,
                                style: const TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (newPasswordController.text !=
                                          confirmPasswordController.text &&
                                      confirmPasswordController
                                          .text.isNotEmpty) {
                                    return 'Xác nhận lại mật khẩu.';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  context.read<ChangePasswordBloc>().add(
                                      ChangePasswordEventCheckException(
                                          currentPassword:
                                              currentPasswordController.text,
                                          newPassword:
                                              newPasswordController.text,
                                          confirmPassword:
                                              confirmPasswordController.text));
                                },
                              )),
                          TextButton(
                              onPressed: () {
                                context.read<ChangePasswordBloc>().add(
                                    ChangePasswordEventShow(
                                        isShow: !state.isShow));
                              },
                              child: const Text(
                                'Hiện mật khẩu',
                                style: TextStyle(color: primaryColor),
                                textAlign: TextAlign.start,
                              )),
                          createPrimaryButton(context, () {
                            if (state is ChangePasswordStateReadyForChange) {
                              context.read<ChangePasswordBloc>().add(
                                  ChangePasswordEventChange(
                                      currentPassword:
                                          currentPasswordController.text,
                                      newPassword: newPasswordController.text));
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Mật khẩu không hợp lệ',
                                  toastLength: Toast.LENGTH_SHORT);
                            }
                          }, 'Đổi mật khẩu'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 42,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                              ),
                              child: const Text(
                                'Hủy',
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ));
      },
    );
  }
}

Widget? checkIcon(ChangePasswordState state) {
  if (state is ChangePasswordStateReadyForChange ||
      state is ChangePasswordStateCorrectPassword) {
    return const Icon(
      Icons.check_circle_outline,
      color: iconCheckColor,
    );
  } else {
    return const Icon(
      Icons.cancel_outlined,
      color: iconErrorColor,
    );
  }
}

Widget createTextField(String title, TextFormField textFormField) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(255, 113, 118, 123),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
      textFormField,
    ],
  );
}
