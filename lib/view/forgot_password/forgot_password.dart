import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/di.dart';
import 'bloc/forgot_password_event.dart';
import 'bloc/forgot_password_state.dart';
import 'bloc/forgot_pasword_bloc.dart';
import 'otp_screen/otp_screen.dart';

import '../../config/config.dart';
import '../../data/repository/remote/user_repository.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ForgotPasswordBloc(userRepository: getIt.get<UserRepository>()),
      child: ForgotPasswordUI(),
    );
  }
}

class ForgotPasswordUI extends StatelessWidget {
  ForgotPasswordUI({Key? key}) : super(key: key);
  final TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.2),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: primaryColor,
                  size: 20,
                ))),
        actions: const [
          SizedBox(
            width: 10,
          )
        ],
        elevation: 0,
        backgroundColor: bgColor,
        title: const Center(
          child: Text(
            'Quên mật khẩu',
            style: TextStyle(
              fontSize: 18,
              color: textColor,
            ),
          ),
        ),
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const Text(
                'Nhập username của bạn',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    hintText: 'Username'),
              ),
              const SizedBox(
                height: 40,
              ),
              BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                builder: (context, state) => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ForgotPasswordBloc>().add(
                          ForgotPasswordEventGetMethod(
                              username: userNameController.text));
                    },
                    child: const Text(
                      'Gửi',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              if (context.select((ForgotPasswordBloc bloc) => bloc.state)
                  is ForgotPasswordStateSuccess)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: const TextSpan(
                            text: 'Chúng tôi sẽ gửi mã OTP vào ',
                            style: TextStyle(color: textColor, fontSize: 14),
                            children: [
                          TextSpan(
                            text: 'Email',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          TextSpan(
                              text: ' của bạn là:',
                              style: TextStyle(color: textColor, fontSize: 14)),
                        ])),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            context
                                .select((ForgotPasswordBloc bloc) =>
                                    (bloc.state as ForgotPasswordStateSuccess)
                                        .forgotPasswordMethod
                                        .first
                                        .value)
                                .toString(),
                            style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                          builder: (context, state) => OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OtpScreen(
                                          username: userNameController.text,
                                          method: (state
                                                  as ForgotPasswordStateSuccess)
                                              .forgotPasswordMethod
                                              .first)));
                            },
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: primaryColor)),
                            child: const Text(
                              'Gửi Xác Thực',
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
