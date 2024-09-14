// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/config.dart';
import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/resources/resources.dart';
import '../../model/member/member_detail_info.dart';
import '../../shared/bloc/sso/sso_cubit.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/bouncing.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/dialog_helper.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_shimmer.dart';
import '../affiliate/cubit/affiliate_cubit.dart';
import '../customer/cubit/customer_cubit.dart';
import '../login_screens/bloc/login_bloc.dart';
import '../notifications/notifications_manage/bloc/noti_bloc.dart';
import '../user_profile/bloc/user_info_bloc.dart';
import 'bloc/settings_bloc.dart';
import 'bloc/settings_event.dart';
import 'bloc/settings_state.dart';
import 'component/affiliate_register.dart';
import 'component/header.dart';

class GeneralSettingPage extends StatelessWidget with WidgetsBindingObserver {
  final SettingsBloc _settingsBloc = SettingsBloc();
  final LoginBloc _loginBloc = LoginBloc();
  final SsoCubit _ssoCubit = SsoCubit()..getUserSSOInfo();
  final AffiliateCubit affiliateCubit = AffiliateCubit()
    ..getAffiliateRegisterInfo();
  final CustomerCubit customerCubit = CustomerCubit();
  GeneralSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    MemberInfo? memberInfo = context.read<UserInfoBloc>().memberInfo;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _loginBloc,
        ),
        BlocProvider(
          create: (context) => _settingsBloc,
        ),
        BlocProvider(
          create: (context) => _ssoCubit,
        ),
        BlocProvider(
          create: (context) => affiliateCubit,
        ),
        BlocProvider(create: (context) => customerCubit)
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F4F4),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              affiliateCubit.getAffiliateRegisterInfo(force: true);
              _ssoCubit.getUserSSOInfo();
            },
            backgroundColor: AppColor.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Thông tin tài khoản',
                        style: AppTextTheme.textPrimaryBoldMedium
                            .copyWith(color: AppColor.primaryColor)),
                    const SizedBox(height: 20),
                    InfoHeader(memberInfo ?? MemberInfo()),
                    const SizedBox(height: 20),
                    BlocBuilder<SsoCubit, SsoState>(
                      buildWhen: (previous, current) =>
                          current is SsoGetUserInfoSuccess ||
                          current is SsoGetUserInfoFailed,
                      builder: (context, state) {
                        return state.maybeWhen(getUserInfoSuccessState: (user) {
                          if (!(user.emailConfirmed ?? false)) {
                            return PrimaryContainer(
                              backgroundImage: const AssetImage(
                                  Assets.imEmailVerifyBackground),
                              padding: const EdgeInsets.all(16),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: 'Xác thực tài khoản để '),
                                        TextSpan(
                                            text: AppConfig.appName,
                                            style: AppTextTheme.bodyStrong
                                                .copyWith(
                                                    color: AppColor
                                                        .secondaryColor)),
                                        const TextSpan(
                                            text: '\ncó thể bảo vệ bạn'),
                                      ],
                                      style: AppTextTheme.bodyMedium,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      PrimaryButton(
                                          backgroundColor: AppColor.blue02,
                                          context: context,
                                          onPressed: _onEmailConfirmPressed,
                                          label: 'Bắt đầu xác thực'),
                                    ],
                                  )
                                ],
                              ),
                            );
                          } else {
                            return PrimaryContainer(
                              backgroundColor: AppColor.white,
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  SvgPicture.asset(Assets.icEmail,
                                      color: AppColor.primaryColor),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text('Email'),
                                  Expanded(
                                      child: Text(
                                    user.email ?? '',
                                    textAlign: TextAlign.end,
                                    style: AppTextTheme.bodyDescription
                                        .copyWith(
                                            overflow: TextOverflow.ellipsis),
                                  )),
                                  const SizedBox(width: 4),
                                  SvgPicture.asset(Assets.iconAccountConfirmed,
                                      color: AppColor.primaryColor)
                                ],
                              ),
                            );
                          }
                        }, orElse: () {
                          return const PrimaryShimmer();
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const AffiliateRegister(),
                    const SizedBox(height: 50),
                    BlocBuilder<CustomerCubit, CustomerState>(
                        builder: (context, state) {
                      return Column(children: [
                        Bouncing(
                            child: GestureDetector(
                                onTap: () => state
                                            is CustomerCheckRoleSuccess &&
                                        (state.role == UserRole.collaborator ||
                                            state.role == UserRole.sale)
                                    ? _onEventListPressed.call(context)
                                    : _onAgencyCartPressed.call(context),
                                child: PrimaryContainer(
                                    padding: const EdgeInsets.all(16),
                                    backgroundColor: AppColor.white,
                                    child: Row(children: [
                                      SvgPicture.asset(Assets.icCart,
                                          color: AppColor.primaryColor),
                                      const SizedBox(width: 8),
                                      Text(
                                          state is CustomerCheckRoleSuccess &&
                                                  (state.role ==
                                                          UserRole
                                                              .collaborator ||
                                                      state.role ==
                                                          UserRole.sale)
                                              ? 'Danh sách sự kiện'
                                              : 'Giỏ hàng',
                                          style: AppTextTheme.bodyStrong)
                                    ])))),
                        const SizedBox(height: 10),
                        Bouncing(
                            child: GestureDetector(
                                onTap: () => state
                                            is CustomerCheckRoleSuccess &&
                                        (state.role == UserRole.collaborator ||
                                            state.role == UserRole.sale)
                                    ? Navigator.pushNamed(
                                        context, AppRoute.appointment,
                                        arguments: AppointmentDetailArgs(
                                            DateTime.now()))
                                    : _onAgencyOrderPressed.call(context),
                                child: PrimaryContainer(
                                    padding: const EdgeInsets.all(16),
                                    backgroundColor: AppColor.white,
                                    child: Row(children: [
                                      const Icon(Icons.article_outlined,
                                          color: AppColor.primaryColor),
                                      const SizedBox(width: 8),
                                      Text(
                                          state is CustomerCheckRoleSuccess &&
                                                  (state.role ==
                                                          UserRole
                                                              .collaborator ||
                                                      state.role ==
                                                          UserRole.sale)
                                              ? 'Danh sách lịch hẹn'
                                              : 'Đơn hàng',
                                          style: AppTextTheme.bodyStrong)
                                    ])))),
                        const SizedBox(height: 10)
                      ]);
                    }),
                    Bouncing(
                      child: GestureDetector(
                        onTap: () => _onAgencyCartPressed.call(context),
                        child: PrimaryContainer(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: AppColor.white,
                          child: Row(
                            children: [
                              SvgPicture.asset(Assets.icCart,
                                  color: AppColor.primaryColor),
                              const SizedBox(width: 8),
                              const Text(
                                'Giỏ hàng',
                                style: AppTextTheme.bodyStrong,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Bouncing(
                      child: GestureDetector(
                        onTap: () => _onAgencyOrderPressed.call(context),
                        child: const PrimaryContainer(
                          padding: EdgeInsets.all(16),
                          backgroundColor: AppColor.white,
                          child: Row(
                            children: [
                              Icon(
                                Icons.article_outlined,
                                color: AppColor.primaryColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Đơn hàng',
                                style: AppTextTheme.bodyStrong,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Bouncing(
                      child: GestureDetector(
                        onTap: () => _onUserManualPressed.call(context),
                        child: PrimaryContainer(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: AppColor.white,
                          child: Row(
                            children: [
                              SvgPicture.asset(Assets.icSolution,
                                  color: AppColor.primaryColor),
                              const SizedBox(width: 8),
                              const Text(
                                'Hướng dẫn sử dụng',
                                style: AppTextTheme.bodyStrong,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Bouncing(
                      child: GestureDetector(
                        onTap: () => _onResetPasswordPressed.call(context),
                        child: const PrimaryContainer(
                          padding: EdgeInsets.all(16),
                          backgroundColor: AppColor.white,
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock_reset_rounded,
                                color: AppColor.primaryColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Đổi mật khẩu',
                                style: AppTextTheme.bodyStrong,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MultiBlocListener(
                      listeners: [
                        BlocListener<SettingsBloc, SettingsState>(
                          listener: (context, state) {
                            if (state is SettingLogoutSuccessState) {
                              Navigator.popAndPushNamed(
                                  context, AppRoute.login);

                              context.read<ManageNotiBloc>()
                                ..add(NotificationDisposeEvent())
                                ..isFirstTimeGetCurrentInfo = true;
                            }
                          },
                        ),
                        BlocListener<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is LoginRequestDeletionSuccessState) {
                              context.pop();

                              Navigator.popAndPushNamed(
                                  context, AppRoute.login);
                            }
                            if (state is LoginRequestDeletionFailedState) {
                              context.pop();
                            }
                          },
                        ),
                      ],
                      child: const SizedBox(),
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      indent: 100,
                      endIndent: 100,
                      color: AppColor.gray09,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        PrimaryButton(
                            context: context,
                            backgroundColor: AppColor.secondaryColor,
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) => getAlertDialog(
                                  context: context,
                                  title: 'Xác nhận Xoá tài khoản',
                                  message:
                                      'Bạn có chắc chắ muốn xóa tài khoản này?\nHành động có thể được hoàn tác nếu bạn liên hệ với đội ngũ CSKH trong vòng 30 ngày. Sau 30 ngày, tất cả dữ liệu của bạn sẽ bị xóa vĩnh viễn và không thể phục hồi.',
                                  onPositivePressed: () {
                                    _loginBloc
                                        .add(LoginRequestAccoutDeletionEvent());
                                    context.showAppDialog(getLoadingDialog());
                                  },
                                ),
                              );
                            },
                            label: "Yêu cầu xoá tài khoản"),
                        const SizedBox(height: 16),
                        PrimaryButton(
                            context: context,
                            backgroundColor: AppColor.white,
                            borderColor: AppColor.primaryColor,
                            textStyle: AppTextTheme.textButtonPrimary
                                .copyWith(color: AppColor.primaryColor),
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) => getAlertDialog(
                                  context: context,
                                  title: 'Đăng xuất',
                                  message:
                                      'Bạn có chắc chắn muốn đăng xuất khỏi tài khoản này?',
                                  onPositivePressed: () {
                                    _settingsBloc.add(SettingsLogOutEvent());
                                  },
                                ),
                              );
                            },
                            label: "Đăng xuất"),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onUserManualPressed(BuildContext context) {
    Utils.launchUri('https://hdsd.trueconnect.vn/hdsd', UriType.website);
  }

  void _onEventListPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.eventList);
  }

  void _onAgencyCartPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.agencyCartPage);
  }

  void _onAgencyOrderPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.agencyOrderListPage);
  }

  void _onResetPasswordPressed(BuildContext context) {
    Utils.launchUri(
        '${SSOConfig.issuer}/Manage/ChangePassword', UriType.website);
  }

  void _onEmailConfirmPressed() async {
    final result = await Utils.launchUri(
        '${SSOConfig.issuer}/Manage/VerifyEmail', UriType.website);
    if (result) {
      _ssoCubit.getUserSSOInfo();
    }
  }
}
