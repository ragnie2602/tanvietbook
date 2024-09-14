import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../model/notification/notification_category_response.dart';
import '../../../view/notifications/notifications_manage/bloc/noti_bloc.dart';

class PrimaryNotificationTabBar extends StatelessWidget {
  final List<NotificationCategoryResponse> tabs;
  final List<Widget> children;
  final Color backgroundColor;
  final Function(int)? onTap;
  final bool isScrollable;

  const PrimaryNotificationTabBar({
    super.key,
    required this.tabs,
    required this.children,
    this.onTap,
    this.backgroundColor = AppColor.white,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: TabBar(
              isScrollable: isScrollable,
              unselectedLabelColor: AppColor.black,
              labelPadding: const EdgeInsets.all(3),
              labelColor: AppColor.primaryColor,
              labelStyle: AppTextTheme.bodyStrong,
              indicatorColor: AppColor.primaryColor,
              onTap: onTap,
              tabAlignment: TabAlignment.center,
              tabs: tabs
                  .map((tab) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: BlocBuilder<ManageNotiBloc, ManageNotiState>(
                        buildWhen: (previous, current) =>
                            current
                                is NotificationGetNotSeenCountSuccessState &&
                            current.type == tab.id,
                        builder: (context, state) {
                          return Row(
                            children: [
                              Text('${tab.name ?? ''} '),
                              if (state
                                      is NotificationGetNotSeenCountSuccessState &&
                                  state.count > 0)
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: AppColor.secondaryColor,
                                  child: Text(
                                    state.count.toString(),
                                    style: AppTextTheme.bodyStrong.copyWith(
                                        fontSize: 10, color: AppColor.white),
                                  ),
                                )
                            ],
                          );
                        },
                      )))
                  .toList(),
            ),
            body: TabBarView(children: children),
          ),
        ));
  }
}
