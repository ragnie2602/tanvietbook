import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/resources/resources.dart';
import '../../domain/entity/agency_order_detail/agency_order_detail.dart';
import '../../domain/entity/agency_order_detail/product_order_entity.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/image/primary_image.dart';
import '../../shared/widgets/image/primary_svg_picture.dart';
import '../../shared/widgets/list_view/primary_paged_list_view.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../base/base_page_sate.dart';
import 'component/agency_product_container.dart';
import 'component/order_status_text.dart';
import 'cubit/agency_cubit.dart';

class AgencyOrderListPage extends StatefulWidget {
  const AgencyOrderListPage({super.key});

  @override
  State<AgencyOrderListPage> createState() => _AgencyOrderListPageState();
}

class _AgencyOrderListPageState extends BasePageState<AgencyOrderListPage, AgencyCubit> {
  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  PreferredSizeWidget? get appBar => PrimaryAppBar(
        title: 'Đơn hàng',
        actions: [
          TextButton(
              onPressed: () {
                _menuKey.currentState!.showButtonMenu();
              },
              child: filterPopup),
        ],
      );

  late final PopupMenuButton filterPopup;
  late final List<String>? filters;
  int? status;

  @override
  void initState() {
    super.initState();
    cubit.getAllOrders(page: 1, status: status);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (context.arguments == null) {
      filters = null;
    } else {
      filters = (context.arguments as AgencyOrderListPageArgs).orders;
    }

    print(filters);

    _pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener((pageKey) {
        cubit.getAllOrders(page: pageKey, status: status);
      });
    filterPopup = PopupMenuButton(
      key: _menuKey,
      itemBuilder: (_) => const <PopupMenuItem<int>>[
        PopupMenuItem<int>(value: 1, child: Text(OrderStatusStr.pending)),
        PopupMenuItem<int>(value: 2, child: Text(OrderStatusStr.packaging)),
        PopupMenuItem<int>(value: 3, child: Text(OrderStatusStr.delivering)),
        PopupMenuItem<int>(value: 4, child: Text(OrderStatusStr.delivered)),
        PopupMenuItem<int>(value: 5, child: Text(OrderStatusStr.canceled)),
        PopupMenuItem<int>(value: 6, child: Text(OrderStatusStr.refunded)),
        PopupMenuItem<int>(value: -1, child: Text('Tất cả')),
      ],
      onSelected: (value) {
        if (value == -1) {
          status = null;
        } else {
          status = value;
        }
        cubit.resetState();
        _pagingController.refresh();
      },
      child: const PrimarySvgPicture(
        Assets.icFilter,
        color: AppColor.primaryColor,
      ),
    );
  }

  final GlobalKey<PopupMenuButtonState> _menuKey = GlobalKey();
  late final PagingController<int, AgencyOrderDetail> _pagingController;

  @override
  Widget buildPage(BuildContext context) {
    return BlocConsumer<AgencyCubit, AgencyState>(
      listener: (context, state) {
        state.maybeWhen(
          getAllOrderSuccess: (orders) {
            if (orders.length < 10) {
              _pagingController.appendLastPage(orders);
            } else {
              _pagingController.appendPage(orders, (_pagingController.nextPageKey!) + 1);
            }
          },
          updateOrderDetailSuccess: (agencyOrderDetail) {
            _pagingController.itemList?.firstWhere((element) => element.id == agencyOrderDetail.id).status =
                agencyOrderDetail.status;
            _pagingController.itemList?.firstWhere((element) => element.id == agencyOrderDetail.id).statusStr =
                agencyOrderDetail.statusStr;
            _pagingController.notifyListeners();
          },
          orElse: () {},
        );
      },
      buildWhen: (previous, current) => current is AgencyGetAllOrderSuccess,
      builder: (context, state) {
        return state.maybeWhen(getAllOrderSuccess: (orders) {
          if (filters == null) {
            return PrimaryPagedListView<AgencyOrderDetail>(
              itemBuilder: (context, item, index) {
                return AgencyOrderItem(
                  item: item.products!.first,
                  status: item.status ?? 1,
                  statusStr: item.statusStr ?? '',
                  showTotalPayment: true,
                  payment: item.payment,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.agencyGetOrderDetailPage,
                      arguments: AgencyGetOrderDetailPageAgrs(agencyCubit: cubit, orderId: item.id ?? ''),
                    );
                  },
                );
              },
              pagingController: _pagingController,
              onRefresh: () {
                cubit.resetState();
                _pagingController.refresh();
              },
            );
          } else {
            return PrimaryPagedListView<AgencyOrderDetail>(
              itemBuilder: (context, item, index) {
                return filters!.contains(item.id)
                    ? AgencyOrderItem(
                        item: item.products!.first,
                        status: item.status ?? 1,
                        statusStr: item.statusStr ?? '',
                        showTotalPayment: true,
                        payment: item.payment,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.agencyGetOrderDetailPage,
                            arguments: AgencyGetOrderDetailPageAgrs(agencyCubit: cubit, orderId: item.id ?? ''),
                          );
                        },
                      )
                    : Container();
              },
              pagingController: _pagingController,
              onRefresh: () {
                cubit.resetState();
                _pagingController.refresh();
              },
            );
          }
        }, orElse: () {
          return const Loading();
        });
      },
    );
  }
}

class AgencyOrderItem extends StatelessWidget {
  final ProductOrderEntity item;
  final int status;
  final String statusStr;
  final Function()? onTap;
  final bool? showTotalPayment;
  final int? payment;
  const AgencyOrderItem({
    super.key,
    required this.item,
    this.onTap,
    required this.status,
    required this.statusStr,
    this.showTotalPayment,
    this.payment,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: PrimaryContainer(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: PrimaryNetworkImage(
                imageUrl: item.productPropertyImage ?? '',
                height: 80,
                width: 80,
                // fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName ?? '',
                    style: AppTextTheme.bodyStrong,
                  ),

                  // const SizedBox(height: 10),
                  // PrimaryContainer(
                  //   backgroundColor:
                  //       AppColor.primaryBackgroundContainer,
                  //   borderColor: AppColor.transparent,
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       PrimaryNetworkImage(
                  //         imageUrl: item.image ?? '',
                  //         height: 20,
                  //         width: 40,
                  //       ),
                  //       const SizedBox(width: 10),
                  //       Text(
                  //         item.productPropertyName ?? '',
                  //         style: AppTextTheme.bodyMedium,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  Text('Số lượng: ${item.amount}'),

                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ProductPriceItem(
                        showOrginalPrice: false,
                        salePrice: showTotalPayment == true ? payment : item.productPropertySalePrice?.toInt(),
                      ),
                      const Spacer(),
                      OrderStatusTextWidget(
                        status: status,
                        statusStr: statusStr,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
