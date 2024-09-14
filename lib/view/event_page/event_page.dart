import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../data/constants.dart';
import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';
import '../../domain/entity/appointment/event_entity.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/container/primary_gesture_detector.dart';
import '../../shared/widgets/image/primary_image.dart';
import '../../shared/widgets/list_view/primary_paged_list_view.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_divider.dart';
import '../../shared/widgets/tab/primary_tab_bar.dart';
import '../agency_page/cubit/agency_cubit.dart';
import '../base/base_page_sate.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends BasePageState<EventListPage, AgencyCubit> {
  @override
  bool get useBlocProviderValue => true;

  @override
  PreferredSizeWidget? get appBar => const PrimaryAppBar(
        title: 'Danh sách sự kiện',
      );

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  Color? get backgroundColor => AppColor.white;

  @override
  void initState() {
    super.initState();
    setCubit = context.read();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return const PrimaryTabBar(tabs: [
      'Tất cả',
      'Sắp diễn ra',
      'Đã diễn ra',
    ], children: [
      _EventListWidget(
        filterType: _EventListWidget.typeAll,
      ),
      _EventListWidget(
        filterType: _EventListWidget.upcoming,
      ),
      _EventListWidget(
        filterType: _EventListWidget.happended,
      ),
    ]);
  }
}

class _EventListWidget extends StatefulWidget {
  static const int typeAll = -1;
  static const int upcoming = 0;
  static const int happended = 1;

  final int filterType;

  const _EventListWidget({
    super.key,
    required this.filterType,
  });

  @override
  State<_EventListWidget> createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<_EventListWidget> {
  @override
  void initState() {
    super.initState();
    pagingController = PagingController<int, EventEntity>(firstPageKey: 1);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pagingController.addPageRequestListener(
        (pageKey) {
          context.read<AgencyCubit>().getAllEvents(
              page: pageKey,
              pageSize: 15,
              typeCheck: widget.filterType != _EventListWidget.typeAll
                  ? widget.filterType
                  : null);
        },
      );
    });
    context.read<AgencyCubit>().getAllEvents(
          page: 1,
          pageSize: 15,
          typeCheck: widget.filterType != _EventListWidget.typeAll
              ? widget.filterType
              : null,
        );
  }

  late final PagingController<int, EventEntity> pagingController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgencyCubit, AgencyState>(
      listener: (context, state) {
        state.maybeWhen(
          getAllEventSuccess: (events) {
            if ((events?.length ?? 0) < 15) {
              pagingController.appendLastPage(events ?? []);
            } else {
              pagingController.appendPage(
                  events ?? [], pagingController.nextPageKey! + 1);
            }
          },
          orElse: () {},
        );
      },
      buildWhen: (previous, current) => current is AgencyGetAllEventSuccess,
      builder: (context, state) {
        return state.maybeWhen(getAllEventSuccess: (events) {
          return PrimaryPagedListView<EventEntity>(
            itemBuilder: (context, item, index) => PrimaryGestureDetector(
              onTap: () => _onItemTapped.call(item),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: PrimaryNetworkImage(
                            imageUrl: item.picture,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title ?? '',
                                style: AppTextTheme.bodyStrong,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Ngày diễn ra: ${Utils.formatDate(
                                  item.startDate ?? '',
                                  showTime: false,
                                )}',
                                style: AppTextTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Địa điểm: ${Utils.formatAddress(item.location, item.town, item.district, item.city)}',
                                style: AppTextTheme.bodySmall,
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  item.statusRegisterStr ?? '',
                                  style: AppTextTheme.bodyStrong.copyWith(
                                    color: item.statusRegister ==
                                            EventRegisterStatus.noResponse
                                        ? AppColor.neutral5
                                        : item.statusRegister ==
                                                EventRegisterStatus.refuse
                                            ? AppColor.errorColor
                                            : item.statusRegister ==
                                                    EventRegisterStatus.willJoin
                                                ? AppColor.successColor
                                                : AppColor.yellow01,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PrimaryDivider(thickness: 4),
                ],
              ),
            ),
            pagingController: pagingController,
            padding: const EdgeInsets.symmetric(vertical: 16),
            onRefresh: () {
              pagingController.refresh();
            },
          );
        }, orElse: () {
          return const Loading();
        });
      },
    );
  }

  void _onItemTapped(EventEntity event) {}
}
