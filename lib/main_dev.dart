import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uni_links/uni_links.dart';

import 'config/config.dart';
import 'config/routes.dart';
import 'data/constants.dart';
import 'data/resources/colors.dart';
import 'data/resources/themes.dart';
import 'di/di.dart';
import 'shared/utils/view_utils.dart';
import 'view/agency_page/cubit/agency_cubit.dart';
import 'view/agency_page/cubit/cart_cubit.dart';
import 'view/notifications/notifications_manage/bloc/noti_bloc.dart';
import 'view/user_profile/bloc/user_info_bloc.dart';
import 'view/user_profile/user_profile.dart';

String appLinkUsernameReceived = '';
late StreamSubscription sub;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  appLinkUsernameReceived = await initUniLinks();
  await dotenv.load(fileName: Environment(flavor: AppFlavor.dev).fileName);
  await configureInjection();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

Future<String> initUniLinks() async {
  String appLinkUsernameReceived = '';
  try {
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      appLinkUsernameReceived =
          initialLink.substring(initialLink.lastIndexOf('/') + 1);
      return appLinkUsernameReceived;
    }
    // ignore: empty_catches
  } on PlatformException {}

  // listen app link
  sub = linkStream.listen((event) {
    String? username = event?.substring(event.lastIndexOf('/') + 1);
    Navigator.push(
      ViewUtils.getRootNavigatorKey().currentContext!,
      MaterialPageRoute(
        builder: (_) => UserProfile(
          viewType: ViewType.viewMember,
          appLinkUsernameReceived: username ?? '',
          memberUserName: username,
        ),
      ),
    );
  });

  return appLinkUsernameReceived;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ManageNotiBloc _manageNotiBloc = ManageNotiBloc();

  @override
  void dispose() {
    super.dispose();
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserInfoBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => AgencyCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => _manageNotiBloc,
        ),
      ],
      child: GestureDetector(
        onTap: () {
          ViewUtils.unFocusView();
        },
        child: MaterialApp(
          navigatorKey: ViewUtils.getRootNavigatorKey(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          initialRoute: AppRoute.splash,
          onGenerateRoute: (settings) => AppRoute.onGenerateRoute(settings),
          onGenerateInitialRoutes: (value) {
            return [
              AppRoute.onGenerateRoute(RouteSettings(
                  name: value,
                  arguments: SplashScreenArgs(
                      appLinkUsernameReceived: appLinkUsernameReceived)))!,
            ];
          },
          routes: AppRoute.generateRoute(),
          // builder: (context, child) {
          //   return
          // },
          supportedLocales: const [Locale('vi')],
          title: AppConfig.appName,
          themeMode: ThemeMode.light,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: AppColor.primaryColor,
                  secondary: AppColor.secondaryColor,
                  background: AppColor.primaryBackgroundColor),
              primarySwatch: Colors.teal,
              canvasColor: Colors.grey,
              dividerColor: bgColor,
              fontFamily: AppConfig.fontFamily,
              primaryTextTheme:
                  const TextTheme(bodyMedium: AppTextTheme.bodyMedium),
              primaryColor: primaryColor),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
