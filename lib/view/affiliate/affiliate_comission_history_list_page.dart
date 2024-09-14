import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../model/agency/comission/agency_comission_history_response.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/container/primary_gesture_detector.dart';
import '../../shared/widgets/list_view/primary_paged_list_view.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_divider.dart';
import '../../shared/widgets/primary_icon_button.dart';
import '../base/base_page_sate.dart';
import 'cubit/affiliate_cubit.dart';

class AffiliateComissionHistoryListPage extends StatefulWidget {
  const AffiliateComissionHistoryListPage({super.key});

  @override
  State<AffiliateComissionHistoryListPage> createState() =>
      _AffiliateComissionHistoryListPageState();
}

class _AffiliateComissionHistoryListPageState
    extends BasePageState<AffiliateComissionHistoryListPage, AffiliateCubit> {
  @override
  bool get useBlocProviderValue => true;

  @override
  PreferredSizeWidget? get appBar => const PrimaryAppBar(
        title: 'Thông tin hoa hồng',
      );

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = context.arguments as AffiliateComissionHistoryListPageArgs;
    setCubit = args.affiliateCubit;
    cubit.getComissionHistory(page: 1, pageSize: 15);
    pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener(
        (pageKey) {
          cubit.getComissionHistory(page: pageKey, pageSize: 15);
        },
      );
  }

  @override
  void dispose() {
    super.dispose();
    // cubit.resetState();
  }

  late final PagingController<int, AgencyComissionHistoryResponse>
      pagingController;

  @override
  Widget buildPage(BuildContext context) {
    return BlocConsumer<AffiliateCubit, AffiliateState>(
      listener: (context, state) {
        state.maybeWhen(
          getComissionHistorySuccess: (agencyComissionHistories) {
            if (agencyComissionHistories.length < 15) {
              pagingController.appendLastPage(agencyComissionHistories);
            } else {
              pagingController.appendPage(
                  agencyComissionHistories, pagingController.nextPageKey! + 1);
            }
          },
          orElse: () {},
        );
      },
      buildWhen: (previous, current) =>
          current is AffiliateGetComissionHistorySuccess,
      builder: (context, state) {
        return state.maybeWhen(
            getComissionHistorySuccess: (agencyComissionHistories) {
          return PrimaryPagedListView(
            itemBuilder: (context, item, index) => PrimaryContainer(
              child: PrimaryGestureDetector(
                onTap: () => _onHistoryItemTapped.call(item),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          item.name.toString(),
                          style: AppTextTheme.titleMedium,
                        )),
                        Text(
                          '+${Utils.formatMoney((item.amount ?? 0).toDouble())}',
                          style: AppTextTheme.titleMedium
                              .copyWith(color: AppColor.errorColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Người mua: ${item.purchaseName}'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.status == 'PENDING'
                                ? 'Đang chờ duyệt'
                                : item.status == 'APPROVED'
                                    ? 'Đã duyệt'
                                    : 'Bị từ chối',
                            style: AppTextTheme.bodyStrong.copyWith(
                              color: item.status == 'PENDING'
                                  ? AppColor.orange
                                  : item.status == 'APPROVED'
                                      ? AppColor.primaryColor
                                      : AppColor.errorColor,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Color(0xFF252525),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          Utils.formatDate(item.createdDate ?? '',
                              showTime: true),
                          style: AppTextTheme.bodySmall,
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    const PrimaryDivider(
                      color: AppColor.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            pagingController: pagingController,
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

  _onComissionHistoryButtonPressed() {
    Navigator.of(context).pushNamed(
      AppRoute.affiliateComissionHistoryPage,
      arguments: AffiliateComissionInfoPageArgs(
        affiliateCubit: context.read(),
      ),
    );
  }

  _onHistoryItemTapped(AgencyComissionHistoryResponse item) {
    context.showAppDialog(Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: AppColor.white,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('type: ${item.type}'),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.level == 1
                              ? 'Hoa hồng trực tiếp'
                              : item.level == 2
                                  ? 'Hoa hồng gián tiếp (F1)'
                                  : '',
                          style: AppTextTheme.bodyRegular,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '+${Utils.formatMoney((item.amount ?? 0).toDouble())}',
                          style: AppTextTheme.titleMedium
                              .copyWith(color: AppColor.errorColor),
                        ),
                      ],
                    )),
                    PrimaryIconButton(
                      context: context,
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icons.close,
                      iconColor: AppColor.errorColor,
                      backgroundColor: AppColor.white,
                      elevation: 0,
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Trạng thái',
                        style: AppTextTheme.textLowPriority),
                    Expanded(
                      child: Text(
                        item.status == 'PENDING'
                            ? 'Đang chờ duyệt'
                            : item.status == 'APPROVED'
                                ? 'Đã duyệt'
                                : 'Bị từ chối',
                        textAlign: TextAlign.end,
                        style: AppTextTheme.bodyStrong.copyWith(
                          color: item.status == 'PENDING'
                              ? AppColor.orange
                              : item.status == 'APPROVED'
                                  ? AppColor.primaryColor
                                  : AppColor.errorColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Thời gian',
                        style: AppTextTheme.textLowPriority),
                    Expanded(
                      child: Text(
                        Utils.formatDate(item.createdDate ?? '',
                            showTime: true),
                        textAlign: TextAlign.end,
                        style: AppTextTheme.bodyStrong,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const PrimaryDivider(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Mã giao dịch',
                        style: AppTextTheme.textLowPriority),
                    Expanded(
                      child: Text(
                        item.transactionId ?? '',
                        textAlign: TextAlign.end,
                        style: AppTextTheme.bodyStrong,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Người mua',
                        style: AppTextTheme.textLowPriority),
                    Expanded(
                      child: Text(
                        item.username ?? '',
                        textAlign: TextAlign.end,
                        style: AppTextTheme.bodyStrong,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Hoa hồng được hưởng',
                        style: AppTextTheme.textLowPriority),
                    Expanded(
                      child: Text(
                        '${item.rate}%',
                        textAlign: TextAlign.end,
                        style: AppTextTheme.bodyStrong,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const PrimaryDivider(),
                const SizedBox(height: 16),
                // Row(
                //   children: [
                //     const Text('Nhóm sản phẩm',
                //         style: AppTextTheme.textLowPriority),
                //     Expanded(
                //       child: Text(
                //         (item.type ?? '') == 'card'
                //             ? 'Thẻ NFC'
                //             : (item.type ?? '') == 'webmini'
                //                 ? 'Website Mini'
                //                 : (item.type ?? '') == 'upgrade request'
                //                     ? 'Nâng cấp gói'
                //                     : item.type ?? '',
                //         textAlign: TextAlign.end,
                //         style: AppTextTheme.bodyStrong,
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Tên sản phẩm',
                        style: AppTextTheme.textLowPriority),
                    Expanded(
                      child: Text(
                        item.name ?? '',
                        textAlign: TextAlign.end,
                        style: AppTextTheme.bodyStrong,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Giao dịch gốc',
                        style: AppTextTheme.textLowPriority),
                    Expanded(
                      child: Text(
                        Utils.formatMoney((item.amount ?? 0).toDouble()),
                        textAlign: TextAlign.end,
                        style: AppTextTheme.bodyStrong,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class ComissionInfoItem extends StatelessWidget {
  final String label;
  final int revenue;
  const ComissionInfoItem(
      {super.key, required this.label, required this.revenue});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      borderColor: AppColor.neutral5,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextTheme.bodyStrong,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            Utils.formatMoney(revenue.toDouble()),
            style: AppTextTheme.bodyStrong.copyWith(color: AppColor.errorColor),
          ),
        ],
      ),
    );
  }
}
