import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart';
import '../../../model/notification/notification_category_response.dart';
import '../../../shared/widgets/loading.dart';
import '../../../shared/widgets/tab/primary_notification_tab_bar.dart';
import 'bloc/noti_bloc.dart';
import 'component/notification_list_view.dart';
import 'notification_detail_page.dart';

class NotificationsManage extends StatefulWidget {
  const NotificationsManage({Key? key}) : super(key: key);

  @override
  State<NotificationsManage> createState() => _NotificationsManageState();
}

class _NotificationsManageState extends State<NotificationsManage> {
  late ManageNotiBloc manageNotiBloc;

  @override
  void initState() {
    manageNotiBloc = context.read<ManageNotiBloc>()
      ..add(NotificationGetAllCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      body: BlocConsumer<ManageNotiBloc, ManageNotiState>(
        listenWhen: (previous, current) =>
            current is NotificationGetAllCategoriesSuccessState,
        listener: (context, state) {
          if (state is NotificationGetAllCategoriesSuccessState) {
            // manageNotiBloc.add(NotificationGetAllEvent());
          }
        },
        buildWhen: (previous, current) =>
            current is NotificationGetAllCategoriesSuccessState,
        builder: (context, state) {
          if (state is NotificationGetAllCategoriesSuccessState) {
            final notificationCategoriesTabNames = [
              'Tất cả',
              ...state.notificationCategories.map((e) => e.name ?? '').toList()
            ];
            return Navigator(
              // key: navigationKey,
              initialRoute: '/',
              onGenerateRoute: (settings) {
                if (settings.name == '/') {
                  return MaterialPageRoute(
                    builder: (context) => NotificationListPage(
                      notificationCategoriesTabNames:
                          notificationCategoriesTabNames,
                      notificationCategories: state.notificationCategories,
                      manageNotiBloc: manageNotiBloc,
                    ),
                  );
                }
                if (settings.name == NotificationDetailPage.routeName) {
                  return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return NotificationDetailPage(
                      notificationDetailResponse:
                          (settings.arguments as NotificationDetailPageArgs)
                              .notificationDetailResponse,
                    );
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, .0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    final tween = Tween(begin: begin, end: end);
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    );
                    return SlideTransition(
                      position: tween.animate(curvedAnimation),
                      child: child,
                    );
                  });
                }
                return null;
              },
            );
          } else {
            return const Loading();
          }
        },
      ),
      // body: SafeArea(
      //   child: DefaultTabController(
      //     length: 2,
      //     child: Column(
      //       children: [
      //         const TabBar(
      //             indicatorColor: Colors.red,
      //             labelColor: Colors.red,
      //             unselectedLabelColor: Colors.black45,
      //             tabs: [
      //               Padding(
      //                 padding: EdgeInsets.all(16),
      //                 child: Text(
      //                   "Cá nhân",
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w600, fontSize: 16),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: EdgeInsets.all(16),
      //                 child: Text("Hệ thống",
      //                     style: TextStyle(
      //                         fontWeight: FontWeight.w600, fontSize: 16)),
      //               )
      //             ]),
      //         Expanded(
      //             child: TabBarView(children: [
      //           ListView.builder(
      //               shrinkWrap: true,
      //               itemCount: state.listNotificationsIndividual.length,
      //               itemBuilder: (context, index) => ItemSystemNoti(
      //                   state.listNotificationsIndividual[index])),
      //           ListView.builder(
      //               shrinkWrap: true,
      //               itemCount: state.listNotificationsSystem.length,
      //               itemBuilder: (context, index) => ItemSystemNoti(
      //                   state.listNotificationsSystem[index])),
      //         ]))
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class NotificationListPage extends StatelessWidget {
  final List<String> notificationCategoriesTabNames;
  final List<NotificationCategoryResponse> notificationCategories;
  final ManageNotiBloc manageNotiBloc;
  const NotificationListPage({
    super.key,
    required this.notificationCategoriesTabNames,
    required this.notificationCategories,
    required this.manageNotiBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageNotiBloc, ManageNotiState>(
      listenWhen: (previous, current) =>
          current is NotificationReceivetUpdateSeenState,
      listener: (context, state) {
        if (state is NotificationReceivetUpdateSeenState) {
          manageNotiBloc.add(NotificationGetNotSeenCountEvent(typeId: null));
          notificationCategories.map(
            (e) {
              manageNotiBloc.add(NotificationGetNotSeenCountEvent(
                  typeId: e.id == 'all' ? null : e.id));
            },
          ).toList();
        }
      },
      child: PrimaryNotificationTabBar(
          tabs: [
            NotificationCategoryResponse(id: 'all', name: 'Tất cả'),
            ...notificationCategories
          ],
          isScrollable: true,
          children: [
            NotificationListView(
              bloc: manageNotiBloc
                ..add(NotificationGetNotSeenCountEvent(typeId: null)),
              categoryId: 'all',
            ),
            ...notificationCategories
                .map((e) => NotificationListView(
                      bloc: manageNotiBloc
                        ..add(NotificationGetNotSeenCountEvent(typeId: e.id)),
                      categoryId: e.id,
                    ))
                .toList()
          ]),
    );
  }
}
