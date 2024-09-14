import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../loading.dart';
import '../no_data.dart';

class PrimaryPagedGridView<ItemType extends Object> extends StatelessWidget {
  final Widget Function(BuildContext context, ItemType item, int index)
      itemBuilder;
  final Widget Function(BuildContext)? firstPageProgressIndicatorBuilder;
  final PagingController<int, ItemType> pagingController;
  final Function() onRefresh;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final int crossAxisCount;

  const PrimaryPagedGridView({
    super.key,
    required this.itemBuilder,
    required this.pagingController,
    this.firstPageProgressIndicatorBuilder,
    required this.onRefresh,
    this.physics,
    this.scrollController,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        pagingController.refresh();
        onRefresh.call();
      },
      backgroundColor: AppColor.primaryBackgroundColor,

      /// int is the next page key - the key is unique for detecting the new build
      child: PagedGridView<int, ItemType>(
        pagingController: pagingController,
        scrollController: scrollController,
        physics: physics,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.7,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        builderDelegate: PagedChildBuilderDelegate<ItemType>(
          itemBuilder: itemBuilder,
          firstPageProgressIndicatorBuilder:
              firstPageProgressIndicatorBuilder ??
                  (context) {
                    return const Loading();
                  },
          newPageErrorIndicatorBuilder: (context) {
            return ErrorWidget('Error builder');
          },
          newPageProgressIndicatorBuilder: (context) {
            return const Loading();
          },
          noItemsFoundIndicatorBuilder: (context) {
            return const NoData();
          },
          firstPageErrorIndicatorBuilder: (context) {
            return ErrorWidget('Error builder');
          },
          noMoreItemsIndicatorBuilder: (context) => const Center(
              child: Padding(
            padding: EdgeInsets.only(top: 8, bottom: 100),
            child: Text(
              '--- Hết ---',
              style: AppTextTheme.bodyMedium,
            ),
          )),
        ),
      ),
    );
  }
}
