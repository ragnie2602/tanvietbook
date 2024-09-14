import 'dart:convert';
import 'dart:developer';

import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/config.dart';
import '../../data/constants.dart';
import '../../data/resources/resources.dart';
import '../../di/di.dart';
import '../../model/notification/notification_detail_response.dart';
import '../../model/notification/notification_detail_response_wrapper.dart';
import '../../services/notification/fcm_helper.dart';
import '../../services/notification/notification_contract.dart';
import '../../shared/widgets/app_richtext.dart';
import '../../shared/widgets/primary_shimmer.dart';
import '../agency_page/agency_page.dart';
import '../agency_page/cubit/agency_cubit.dart';
import '../contacts_page/contacts_page.dart';
import '../general_setting/general_setting.dart';
import '../notifications/notifications_manage/bloc/noti_bloc.dart';
import '../notifications/notifications_manage/notifications_manage.dart';
import '../user_profile/bloc/user_info_bloc.dart';
import '../user_profile/user_profile.dart';

class HomeScreen extends StatefulWidget {
  final String appLinkUsernameReceived;

  const HomeScreen({super.key, this.appLinkUsernameReceived = ''});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(initialPage: 0);

  final iconsList = <dynamic>[
    Assets.icHome,
    Assets.icInterest,
    FontAwesomeIcons.addressBook,
    Assets.icNotification,
    Icons.person
  ];

  final List<String> labelsList = List<String>.from(['Trang chủ', 'Danh thiếp', 'Danh bạ', 'Thông báo', 'Tài khoản']);

  @override
  void initState() {
    super.initState();
    page = [
      (_) => const AgencyPage(),
      (_) => UserProfile(
            viewType: ViewType.viewOwn,
            appLinkUsernameReceived: widget.appLinkUsernameReceived,
          ),
      (_) => const ContactsPage(),
      (_) => const NotificationsManage(),
      (_) => GeneralSettingPage(),
    ];
    final UserInfoBloc userInfoBloc = context.read();
    userInfoBloc.add(UserInfoGetPersonalInfoEvent(viewType: ViewType.viewOwn));

// _initFcm();
  }

  @override
  void dispose() {
    // _manageNotiBloc.add(NotificationDisposeEvent());
    context.read<AgencyCubit>().resetData();
    super.dispose();
  }

  late final List<Widget Function(GlobalKey<NavigatorState>)> page;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserInfoBloc, UserInfoState>(
          listenWhen: (previous, current) => current is UserInfoSuccessState,
          listener: (BuildContext context, UserInfoState state) {
// init notify service
            if (state is UserInfoSuccessState && state.viewType == ViewType.viewOwn) {
              context.read<ManageNotiBloc>().add(NotificationInitialEvent())
// ..add(NotificationRegisterFCMTokenEvent())
                  ;
            }
          },
        ),
        BlocListener<ManageNotiBloc, ManageNotiState>(
          listenWhen: (previous, current) => current is NotificationInitializeSuccessState,
          listener: (context, state) {
            if (state is NotificationInitializeSuccessState) {
              _initListener();
              context.read<ManageNotiBloc>().add(NotificationGetNotSeenCountEvent(typeId: null));
            }
          },
        ),
      ],
      child: Scaffold(
          backgroundColor: AppColor.primaryBackgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: AppConfig.agencyName == 'me'
                ? SvgPicture.asset(
                    'assets/icons/ic_logo.svg',
                    fit: BoxFit.contain,
                    height: 28,
                    width: 28,
                  )
                : null,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                  Colors.white,
                  Colors.white.withOpacity(.25),
                  AppColor.primaryColor.withOpacity(.25),
                ]),
              ),
            ),
            title: AppConfig.agencyName == 'me'
                ? const AppRichText()
                : Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Image.asset(
                      Assets.imLogoTanvietbookFull,
                      fit: BoxFit.contain,
                      height: kDefaultToolbarSize + 16,
// width: 28,
                    ),
                  ),
            titleSpacing: 0,
            elevation: 1,
            backgroundColor: AppColor.white,
            centerTitle: false,
            actions: const [
// IconButton(
//   icon: const Icon(Icons.notifications_none_outlined,
//       size: 24, color: AppColor.black),
//   onPressed: () {},
// ),
            ],
          ),
          body: BottomNavLayout(
            pages: page,
            savePageState: true,
            lazyLoadPages: true,
            extendBody: false,
            bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
              items: List.generate(
                5,
                (index) => BottomNavigationBarItem(
                  icon: index == 4
                      ? BlocBuilder<UserInfoBloc, UserInfoState>(
                          buildWhen: (previous, current) =>
                              current is UserInfoSuccessState || current is UserInfoUpdateUserAvatarUrlSuccessState,
                          builder: (context, state) {
                            if (state is UserInfoUpdateUserAvatarUrlSuccessState) {
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: AppColor.transparent,
                                      backgroundImage: NetworkImage(state.avatarUrl)));
                            } else {
                              return const PrimaryShimmer(child: CircleAvatar(radius: 10));
                            }
                          },
                        )
                      : index == 3
                          ? BlocBuilder<ManageNotiBloc, ManageNotiState>(
                              buildWhen: (previous, current) =>
                                  current is NotificationGetNotSeenCountSuccessState && current.type == 'all',
                              builder: (context, state) {
                                return Badge.count(
                                  count: state is NotificationGetNotSeenCountSuccessState ? state.count : 0,
                                  isLabelVisible:
                                      state is NotificationGetNotSeenCountSuccessState ? state.count > 0 : false,
                                  backgroundColor: AppColor.secondaryColor,
                                  textColor: AppColor.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: SvgPicture.asset(iconsList[index],
                                        height: 20,
                                        width: 20,
                                        color: index == currentIndex
                                            ? AppColor.primaryColor
                                            : AppColor.black.withOpacity(0.85)),
                                  ),
                                );
                              },
                            )
                          : iconsList[index] is String
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: SvgPicture.asset(iconsList[index],
                                      height: 20,
                                      width: 20,
                                      color: index == currentIndex
                                          ? AppColor.primaryColor
                                          : AppColor.black.withOpacity(0.85)),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Icon(
                                    iconsList[index],
                                    size: 20,
                                  ),
                                ),
                  label: labelsList[index],
                  backgroundColor: AppColor.white,
                ),
              ),
              currentIndex: currentIndex,
              showUnselectedLabels: true,
              fixedColor: AppColor.primaryColor,
              unselectedItemColor: AppColor.black.withOpacity(0.85),
              backgroundColor: AppColor.white,
              selectedLabelStyle: AppTextTheme.textPrimaryBold.copyWith(color: AppColor.primaryColor, fontSize: 10),
              unselectedLabelStyle: AppTextTheme.textPrimaryBold.copyWith(color: AppColor.gray05, fontSize: 10),
              onTap: (index) => onTap(index),
            ),
          )),
    );
  }

  void _initListener() async {
    final notificationServiceContract = getIt.get<NotificationServiceContract>();
    final connection = await notificationServiceContract.getHubConnection();
    connection.on('notify-list', (arguments) {
      final argumentDecode = jsonDecode(utf8.decode(arguments.toString().codeUnits)) as List;
      final response = NotificationDetailResponseWrapper.fromJson(argumentDecode.first as Map<String, dynamic>);
      log('notify-list:\n ${jsonEncode(response)}');

      if (response.data != null) {
        context
            .read<ManageNotiBloc>()
            .add(NotificationReceiveListEvent(notifications: response.data!, type: response.type ?? ''));
      } else {}
    });
    connection.on('notify-count', (arguments) async {
      log('notify-count: $arguments');
      context.read<ManageNotiBloc>().add(NotificationReceivetNotSeenCountEvent(
          count: (arguments?.first as Map)['count'], type: (arguments?.first as Map)['type']));
    });
    connection.on(
      'notify-seen',
      (arguments) async {
        log('notify-seen: $arguments');
        context.read<ManageNotiBloc>().add(NotificationReceivetUpdateSeenEvent());
      },
    );
    connection.on(
      'notify',
      (arguments) async {
        log('notify-new-message: $arguments');
        if (arguments == null || arguments.isEmpty) return;
        final message = NotificationDetailResponse.fromJson(arguments[0] as Map<String, dynamic>);
        context.read<ManageNotiBloc>().add(NotificationReceivetNewMessageEvent(notificationDetailResponse: message));
        context.read<ManageNotiBloc>().add(NotificationGetNotSeenCountEvent(typeId: null));
      },
    );
  }

  void _initFcm() {
    FCMHelper.instance.initialize(
      onForegroundMessage: (message) {
        context
            .read<ManageNotiBloc>()
            .add(NotificationReceivetNewMessageEvent(notificationDetailResponse: NotificationDetailResponse()));
      },
      onBackgroundMessage: (message) {
        context
            .read<ManageNotiBloc>()
            .add(NotificationReceivetNewMessageEvent(notificationDetailResponse: NotificationDetailResponse()));
      },
    );
  }
}
