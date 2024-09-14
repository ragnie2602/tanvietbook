import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_divider.dart';
import '../base/base_page_sate.dart';
import 'cubit/affiliate_cubit.dart';

class AffiliateComissionInfoPage extends StatefulWidget {
  const AffiliateComissionInfoPage({super.key});

  @override
  State<AffiliateComissionInfoPage> createState() =>
      _AffiliateComissionInfoPageState();
}

class _AffiliateComissionInfoPageState
    extends BasePageState<AffiliateComissionInfoPage, AffiliateCubit> {
  @override
  bool get useBlocProviderValue => true;

  @override
  PreferredSizeWidget? get appBar => const PrimaryAppBar(
        title: 'Thông tin cộng tác viên',
      );

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = context.arguments as AffiliateComissionInfoPageArgs;
    setCubit = args.affiliateCubit;
    cubit.getComissionTree(isOwn: true);
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<AffiliateCubit, AffiliateState>(
      buildWhen: (previous, current) =>
          current is AffiliateGetComissionTreeSuccess,
      builder: (context, state) {
        return state.maybeWhen(getComissionTreeSuccess: (agencyComissionTree) {
          return Stack(
            children: [
              Image.asset(
                Assets.imEmailVerifyBackground,
                width: context.screenWidth,
                height: context.screenWidth * 9 / 16,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                margin:
                    EdgeInsets.only(top: context.screenWidth * 9 / 16 * 3 / 4),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PrimaryContainer(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Tên tài khoản',
                                      style: AppTextTheme.bodyStrong,
                                    )),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${agencyComissionTree.fullname} (${agencyComissionTree.username ?? ''})',
                                    style: AppTextTheme.bodyStrong,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Loại CTV',
                                      style: AppTextTheme.bodyStrong,
                                    )),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    agencyComissionTree.type ?? '',
                                    style: AppTextTheme.bodyStrong,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Người giới thiệu',
                                      style: AppTextTheme.bodyStrong,
                                    )),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${agencyComissionTree.referralFullname} (${agencyComissionTree.referralCode ?? ''})',
                                    style: AppTextTheme.bodyStrong,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const PrimaryDivider(),
                            const SizedBox(height: 16),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Số người dùng bạn giới thiệu (F1)',
                                          textAlign: TextAlign.center,
                                          style: AppTextTheme.bodyStrong,
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(agencyComissionTree.quantityLv1
                                            .toString()),
                                      ],
                                    ),
                                  ),
                                  const VerticalDivider(
                                    thickness: 0.5,
                                    color: AppColor.gray09,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Số người dùng được giới thiệu bởi F1',
                                          textAlign: TextAlign.center,
                                          style: AppTextTheme.bodyStrong,
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(agencyComissionTree.quantityLv2
                                            .toString()),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }, orElse: () {
          return const Loading();
        });
      },
    );
  }
}
