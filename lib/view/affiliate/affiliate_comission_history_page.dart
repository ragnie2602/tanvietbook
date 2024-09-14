import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/resources/resources.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/container_shimmer.dart';
import '../../shared/widgets/no_data.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_shimmer.dart';
import '../agency_page/cubit/agency_cubit.dart';
import '../base/base_page_sate.dart';
import 'components/comission_tree.dart';
import 'cubit/affiliate_cubit.dart';

class AffiliateComissionHistoryPage extends StatefulWidget {
  const AffiliateComissionHistoryPage({super.key});

  @override
  State<AffiliateComissionHistoryPage> createState() =>
      _AffiliateComissionHistoryPageState();
}

class _AffiliateComissionHistoryPageState
    extends BasePageState<AffiliateComissionHistoryPage, AffiliateCubit> {
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
    final args = context.arguments as AffiliateComissionHistoryPageArgs;
    setCubit = args.affiliateCubit;
    agencyCubit = context.read();
    _checkUserRole();
    cubit.getComissionTree();
  }

  @override
  void dispose() {
    super.dispose();
    // cubit.resetState();
  }

  late final AgencyCubit agencyCubit;

  @override
  Widget buildPage(BuildContext context) {
    return BlocProvider.value(
      value: agencyCubit,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryContainer(
              backgroundImage: const AssetImage(Assets.imBgComission),
              child: Column(
                children: [
                  BlocBuilder<AffiliateCubit, AffiliateState>(
                    buildWhen: (previous, current) =>
                        current is AffiliateGetComissionInfoSuccess,
                    builder: (context, state) {
                      return state.maybeWhen(
                          getComissionInfoSuccess: (agencyComissionInfo) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 48,
                            ),
                            PrimaryContainer(
                              child: Column(
                                children: [
                                  Text(
                                    'Thông tin doanh số',
                                    style: AppTextTheme.bodyStrong
                                        .copyWith(color: AppColor.primaryColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ComissionInfoItem(
                                          label:
                                              'Tổng doanh số cá nhân đã nhận',
                                          revenue: agencyComissionInfo
                                                  .personalSaleReceived ??
                                              0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: ComissionInfoItem(
                                          label: 'Doanh số kỳ này',
                                          revenue: agencyComissionInfo
                                                  .personalSaleDuration ??
                                              0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ComissionInfoItem(
                                          label: 'Doanh số chờ duyệt',
                                          revenue: agencyComissionInfo
                                                  .personalSalePending ??
                                              0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: ComissionInfoItem(
                                          label: 'Doanh số bị huỷ',
                                          revenue: agencyComissionInfo
                                                  .personalSaleRejected ??
                                              0,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            PrimaryContainer(
                              child: Column(
                                children: [
                                  Text(
                                    'Thông tin hoa hồng',
                                    style: AppTextTheme.bodyStrong
                                        .copyWith(color: AppColor.primaryColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ComissionInfoItem(
                                          label: 'Tổng hoa hồng',
                                          revenue: agencyComissionInfo
                                                  .commissionReceived ??
                                              0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: ComissionInfoItem(
                                          label: 'Hoa hồng kỳ này',
                                          revenue: agencyComissionInfo
                                                  .commissionDuration ??
                                              0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ComissionInfoItem(
                                          label: 'Hoa hồng chờ duyệt',
                                          revenue: agencyComissionInfo
                                                  .commissionPending ??
                                              0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: ComissionInfoItem(
                                          label: 'Hoa hồng bị huỷ',
                                          revenue: agencyComissionInfo
                                                  .commissionRejected ??
                                              0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  PrimaryButton(
                                    context: context,
                                    onPressed: _onComissionHistoryButtonPressed,
                                    label: 'Lịch sử hoa hồng',
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        );
                      }, orElse: () {
                        return const SizedBox();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AffiliateCubit, AffiliateState>(
                    buildWhen: (previous, current) =>
                        current is AffiliateGetKPIInfoSuccess,
                    builder: (context, state) {
                      return state.maybeWhen(getKPInInfoSuccess: (kpis) {
                        return PrimaryContainer(
                          child: Column(
                            children: [
                              Text(
                                'Thông tin KPI',
                                style: AppTextTheme.bodyStrong
                                    .copyWith(color: AppColor.primaryColor),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              kpis.isEmpty
                                  ? const NoData()
                                  : GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 16,
                                              crossAxisSpacing: 16),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: kpis.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final item = kpis[index];
                                        return ComissionInfoItem(
                                          label: item.name ?? '',
                                          revenue:
                                              item.reality?.toDouble() ?? 0,
                                          target: item.target?.toDouble() ?? 0,
                                          rate:
                                              item.completionRate?.toDouble() ??
                                                  0,
                                          isKPI: true,
                                        );
                                      },
                                    ),
                            ],
                          ),
                        );
                      }, orElse: () {
                        return const SizedBox();
                      });
                    },
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Danh sách các CTV giới thiệu',
                    style: AppTextTheme.titleMedium,
                  ),
                ),
                BlocBuilder<AffiliateCubit, AffiliateState>(
                  buildWhen: (previous, current) =>
                      current is AffiliateGetComissionTreeSuccess,
                  builder: (context, state) {
                    return state.maybeWhen(
                        getComissionTreeSuccess: (agencyComissionTree) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ComissionTree(
                          agencyComissionTree: agencyComissionTree,
                        ),
                      );
                    }, orElse: () {
                      return const _ComissionTreeLoadingShimmer();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 156,
            ),
          ],
        ),
      ),
    );
  }

  _onComissionHistoryButtonPressed() {
    Navigator.of(context).pushNamed(
      AppRoute.affiliateComissionHistoryListPage,
      arguments: AffiliateComissionHistoryListPageArgs(
        affiliateCubit: cubit,
      ),
    );
  }

  void _checkUserRole() async {
    if (agencyCubit.userRole.isEmpty) {
      await agencyCubit.getUserRole();
    }
    log('user role: ${agencyCubit.userRole}');
    if (agencyCubit.userRole.contains(UserRole.collaborator)) {
      await cubit.getComissionInfo();
    }
    if (agencyCubit.userRole.contains(UserRole.sale)) {
      await cubit.getKPIInfo();
    }
  }
}

class _ComiisionInfoLoadingShimmer extends StatelessWidget {
  const _ComiisionInfoLoadingShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: PrimaryShimmer(
                  child: ContainerShimmer(
                    height: 100,
                    borderRadius: 8,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: PrimaryShimmer(
                  child: ContainerShimmer(
                    height: 100,
                    borderRadius: 8,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: PrimaryShimmer(
                  child: ContainerShimmer(
                    height: 100,
                    borderRadius: 8,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: PrimaryShimmer(
                  child: ContainerShimmer(
                    height: 100,
                    borderRadius: 8,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ComissionTreeLoadingShimmer extends StatelessWidget {
  const _ComissionTreeLoadingShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          PrimaryShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContainerShimmer(
                  height: 40,
                  width: double.infinity,
                  borderRadius: 8,
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: ContainerShimmer(
                    height: 40,
                    width: double.infinity,
                    borderRadius: 8,
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: ContainerShimmer(
                    height: 40,
                    width: double.infinity,
                    borderRadius: 8,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          PrimaryShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContainerShimmer(
                  height: 40,
                  width: double.infinity,
                  borderRadius: 8,
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: ContainerShimmer(
                    height: 40,
                    width: double.infinity,
                    borderRadius: 8,
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: ContainerShimmer(
                    height: 40,
                    width: double.infinity,
                    borderRadius: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ComissionInfoItem extends StatelessWidget {
  final String label;
  final num revenue;
  final double? target;
  final double? rate;
  final bool isKPI;
  const ComissionInfoItem({
    super.key,
    required this.label,
    required this.revenue,
    this.isKPI = false,
    this.target,
    this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      borderColor: AppColor.neutral5,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
            isKPI
                ? '${Utils.formatMoney(revenue.toDouble())} / ${Utils.formatMoney(target ?? 0)}'
                : Utils.formatMoney(revenue.toDouble()),
            style: AppTextTheme.bodyStrong.copyWith(color: AppColor.errorColor),
            textAlign: TextAlign.center,
          ),
          if (isKPI)
            Text(
              isKPI ? '($rate%)' : Utils.formatMoney(revenue.toDouble()),
              style:
                  AppTextTheme.bodyStrong.copyWith(color: AppColor.errorColor),
            ),
        ],
      ),
    );
  }
}
