import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../data/resources/resources.dart';
import '../../../../model/notification/notification_detail_response.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/container/primary_container.dart';
import '../../../../shared/widgets/image/primary_circle_image.dart';
import '../../../../shared/widgets/list_view/primary_paged_list_view.dart';
import '../../../../shared/widgets/primary_divider.dart';
import '../../../../shared/widgets/quill/primary_editor.dart';
import '../../../user_profile/bloc/user_info_bloc.dart';
import '../bloc/noti_bloc.dart';
import '../notification_detail_page.dart';

class NotificationListView extends StatefulWidget {
  final ManageNotiBloc bloc;
  final String? categoryId;
  const NotificationListView({
    super.key,
    required this.bloc,
    this.categoryId,
  });

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView>
    with AutomaticKeepAliveClientMixin {
  late final PagingController<int, NotificationDetailResponse>
      _pagingController;

  @override
  void initState() {
    super.initState();
    // widget.bloc.add(NotificationGetAllEvent(
    //   categoryId: widget.categoryId,
    // ));
    _pagingController = PagingController(firstPageKey: 0)
      ..addPageRequestListener((pageKey) {
        widget.bloc.add(NotificationGetAllEvent(
          categoryId: widget.categoryId,
          pageNum: pageKey,
          pageSize: 20,
        ));
      });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<ManageNotiBloc, ManageNotiState>(
        listenWhen: (previous, current) =>
            current is NotificationGetAllSuccessState &&
                current.categoryId == widget.categoryId ||
            current
                is NotificationReceiveNewMessageSuccessState, // avoid listening from other tab
        listener: (context, state) {
          if (state is NotificationGetAllSuccessState) {
            if (state.notifications.length < 20) {
              _pagingController.appendLastPage(state.notifications);
            } else {
              _pagingController.appendPage(
                  state.notifications, _pagingController.nextPageKey! + 1);
            }
          }
          if (state is NotificationReceiveNewMessageSuccessState) {
            _pagingController.refresh();
            widget.bloc.add(NotificationGetNotSeenCountEvent(
                typeId: widget.categoryId == 'all' ? null : widget.categoryId));
          }
        },
        child: PrimaryPagedListView<NotificationDetailResponse>(
          itemBuilder: (context, item, index) => InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                NotificationDetailPage.routeName,
                arguments: NotificationDetailPageArgs(
                  notificationDetailResponse: item,
                ),
              );
              if (!(item.isSeen ?? true)) {
                widget.bloc
                    .add(NotificationUpdateSeenNotificationEvent(id: item.id!));
                setState(() {
                  item.isSeen = true;
                });
              }
            },
            child: Column(
              children: [
                PrimaryContainer(
                  borderRadius: BorderRadius.zero,
                  backgroundColor: (item.isSeen ?? true)
                      ? null
                      : AppColor.primaryColor.withOpacity(.2),
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Row(
                    children: [
                      PrimaryCircleImage(
                        imageUrl:
                            context.read<UserInfoBloc>().memberInfo?.avatar ??
                                '',
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (item.title ?? '').contains('"ops":') &&
                                    (item.title ?? '').contains('[') &&
                                    (item.title ?? '').contains('{')
                                ? PrimaryEditor(
                                    controller: QuillController.basic()
                                      ..document =
                                          Utils.parseQuillDocument(item.title),
                                    readOnly: true,
                                    limitCharactor: 100,
                                  )
                                : HtmlWidget(
                                    item.title ?? '',
                                    // customWidgetBuilder: (element) {
                                    //   return const InlineCustomWidget(
                                    //       child: CircleAvatar(),
                                    //       );
                                    // },
                                    textStyle:
                                        AppTextTheme.titleMedium.copyWith(),
                                  ),
                            // const SizedBox(height: 8),
                            (item.body ?? '').contains('"ops":') &&
                                    (item.body ?? '').contains('[') &&
                                    (item.body ?? '').contains('{')
                                ? ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxHeight: 100),
                                    child: PrimaryEditor(
                                      controller: QuillController.basic()
                                        ..document =
                                            Utils.parseQuillDocument(item.body),
                                      readOnly: true,
                                      limitCharactor: 70,
                                    ),
                                  )
                                : HtmlWidget(
                                    '<div style="max-lines:2; text-overflow: ellipsis"> ${item.body ?? ''} </div>',
                                    textStyle:
                                        AppTextTheme.bodyRegular.copyWith(),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (item.isSeen ?? true) const PrimaryDivider(),
              ],
            ),
          ),
          pagingController: _pagingController,
          onRefresh: () {
            // _pagingController.refresh();
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
