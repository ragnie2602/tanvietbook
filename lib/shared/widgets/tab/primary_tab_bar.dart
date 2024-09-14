import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';

class PrimaryTabBar extends StatelessWidget {
  final List<String> tabs;
  final List<Widget> children;
  final Color backgroundColor;
  final Function(int)? onTap;
  final bool isScrollable;

  const PrimaryTabBar(
      {super.key,
      required this.tabs,
      required this.children,
      this.onTap,
      this.backgroundColor = AppColor.white,
      this.isScrollable = true});

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
                  .map((tabTitle) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Text(tabTitle)))
                  .toList(),
            ),
            body: TabBarView(children: children),
          ),
        ));
  }
}
