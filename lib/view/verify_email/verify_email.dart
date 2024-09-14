import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/di.dart';

import '../../config/config.dart';
import '../../data/repository/remote/repository.dart';
import '../../shared/utils/view_utils.dart';
import 'bloc/count_down_bloc/count_down_bloc.dart';
import 'bloc/count_down_bloc/count_down_state.dart';
import 'bloc/count_down_bloc/cout_down_event.dart';
import 'bloc/count_down_bloc/ticker.dart';
import 'bloc/otp_bloc/otp_bloc.dart';

class VerifyEmail extends StatelessWidget {
  final String username;
  final String value;

  const VerifyEmail({Key? key, required this.username, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OtpBloc>(
            create: (_) => OtpBloc(userRepository: getIt.get<UserRepository>())
              ..add(OtpEventSend(username: username, value: value))),
        BlocProvider<CountDownBloc>(
            create: (_) => CountDownBloc(ticker: const Ticker()))
      ],
      child: OtpScreenUI(
        username: username,
        value: value,
      ),
    );
  }
}

class OtpScreenUI extends StatelessWidget {
  final String username;
  final String value;

  OtpScreenUI({Key? key, required this.username, required this.value})
      : super(key: key);
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (context.select((OtpBloc bloc) => bloc.state) is OtpStateSendSuccess) {
      if (context.select((CountDownBloc bloc) => bloc.state)
              is CountDownStateInit ||
          context.select((CountDownBloc bloc) => bloc.state)
              is CountDownStateExpired) {
        context
            .read<CountDownBloc>()
            .add(const CountDownEventStart(duration: 120));
      } else if (context.select((CountDownBloc bloc) => bloc.state)
          is CountDownStateComplete) {
        context.read<OtpBloc>().add(OtpEventExpired());
        context.read<CountDownBloc>().add(CountDownEventExpired());
      }
    }

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
        elevation: 0,
        backgroundColor: bgColor,
        title: const Text(
          'Xác thực email',
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const Text(
                'Xác Thực Mã OTP',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Mã xác thực được gửi qua email của bạn:',
                style: TextStyle(color: textColor, fontSize: 14),
              ),
              Text(
                value,
                style: const TextStyle(color: primaryColor, fontSize: 14),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _textFieldOTP(
                      first: true,
                      last: false,
                      context: context,
                      controller: controller1),
                  _textFieldOTP(
                      first: false,
                      last: false,
                      context: context,
                      controller: controller2),
                  _textFieldOTP(
                      first: false,
                      last: false,
                      context: context,
                      controller: controller3),
                  _textFieldOTP(
                      first: false,
                      last: false,
                      context: context,
                      controller: controller4),
                  _textFieldOTP(
                      first: false,
                      last: false,
                      context: context,
                      controller: controller5),
                  _textFieldOTP(
                      first: false,
                      last: true,
                      context: context,
                      controller: controller6),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  context
                      .select((CountDownBloc bloc) => bloc.state.duration)
                      .toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primaryColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Bạn chưa nhận được mã?',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
                  ),
                  BlocBuilder<OtpBloc, OtpState>(builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        context.read<OtpBloc>().add(
                            OtpEventSend(username: username, value: value));
                        // context
                        //     .read<CountDownBloc>()
                        //     .add(const CountDownEventInit(duration: 120));
                      },
                      child: const Text(
                        'Gửi lại OTP',
                      ),
                    );
                  })
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              BlocListener<OtpBloc, OtpState>(
                  listener: (context, state) {
                    if (state is OtpStateCheckedSuccess) {
                      toastSuccess('Xác thực email thành công.');
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    } else {
                      toastWarning('Xác thực email thất bại.');
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final String otp = controller1.text +
                            controller2.text +
                            controller3.text +
                            controller4.text +
                            controller5.text +
                            controller6.text;
                        context
                            .read<OtpBloc>()
                            .add(OtpEventCheck(username: username, key: otp));
                      },
                      child: const Text(
                        'Xác Thực OTP',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP(
      {required bool first,
      required bool last,
      required BuildContext context,
      required TextEditingController controller}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 9,
      child: AspectRatio(
        aspectRatio: 1,
        child: TextFormField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2 /*, color: Colors.black12*/),
                borderRadius: BorderRadius.circular(0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: primaryColor),
                borderRadius: BorderRadius.circular(0)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: secondaryColor),
                borderRadius: BorderRadius.circular(0)),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
