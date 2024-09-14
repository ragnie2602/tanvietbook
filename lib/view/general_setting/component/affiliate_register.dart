import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes.dart';
import '../../../data/constants.dart';
import '../../../data/resources/resources.dart';
import '../../../shared/etx/view_extensions.dart';
import '../../../shared/widgets/app_richtext.dart';
import '../../../shared/widgets/container/primary_container.dart';
import '../../../shared/widgets/container_shimmer.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/primary_shimmer.dart';
import '../../affiliate/cubit/affiliate_cubit.dart';
import '../../customer/cubit/customer_cubit.dart';
import 'collaborator_state_approved.dart';
import 'collaborator_state_new.dart';
import 'collaborator_state_none.dart';
import 'collaborator_state_rejected.dart';

class AffiliateRegister extends StatefulWidget {
  const AffiliateRegister({super.key});

  @override
  State<AffiliateRegister> createState() => _AffiliateRegisterState();
}

class _AffiliateRegisterState extends State<AffiliateRegister> {
  late final CustomerCubit customerCubit;
  String agency = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    customerCubit = context.read();

    customerCubit.checkRole();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
        backgroundColor: AppColor.white,
        width: context.screenWidth,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const AppRichText(prefix: TextSpan(text: 'Đồng hành cùng ', style: AppTextTheme.bodyStrong), fontSize: 14),
          const SizedBox(height: 10),
          BlocConsumer<AffiliateCubit, AffiliateState>(
              listener: (context, state) {
                if (state is AffiliateGetCollaboratorInfoSuccess) {
                  agency = state.collaboratorResponse?.agency ?? '';
                }
              },
              buildWhen: (previous, current) =>
                  current is AffiliateGetCollaboratorInfoSuccess || current is AffiliateInitial,
              builder: (context, state) {
                return state.maybeWhen(getCollaboratorInfoSuccess: (collaboratorInfo) {
                  if (collaboratorInfo != null) {
                    // is sent request to admin
                    if (collaboratorInfo.status == CollaboratorState.stateApproved) {
                      // is queued to pending request
                      return const CollaboratorStateApproved();
                    } else if (collaboratorInfo.status == CollaboratorState.stateNew) {
                      return const CollaboratorStateNew();
                    } else if (collaboratorInfo.status == CollaboratorState.stateRejected) {
                      return CollaboratorStateRejected(
                        collaboratorResponse: collaboratorInfo,
                      );
                    } else {
                      return const CollaboratorStateNone();
                    }
                  } else {
                    // not registered yet
                    return const CollaboratorStateNone();
                  }
                }, orElse: () {
                  return const PrimaryShimmer(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ContainerShimmer(height: 20, width: 150),
                    SizedBox(height: 10),
                    ContainerShimmer(height: 20, width: 300),
                    SizedBox(height: 10),
                    ContainerShimmer(height: 20, width: 350),
                  ]));
                });
              }),
          BlocBuilder<CustomerCubit, CustomerState>(
              buildWhen: (previous, current) =>
                  current is CustomerCheckRoleSuccess ||
                  current is CustomerCheckRoleFailed ||
                  current is CustomerInitial,
              builder: (context, state) => state is CustomerCheckRoleSuccess && state.role > 1
                  ? Column(
                      children: [
                        const Divider(color: AppColor.neutral5),
                        RegiterInfoItem(
                          icon: Assets.imRegisterInfo,
                          title: 'Danh sách khách hàng',
                          detail: 'Đây là những thông tin liên quan đến danh sách khách hàng của bạn',
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AppRoute.customerChoosePage,
                              arguments: CustomerPageArgs(),
                            );
                          },
                        ),
                        const Divider(color: AppColor.neutral5),
                        RegiterInfoItem(
                          icon: Assets.imRegisterInfo,
                          title: 'Xem hành trình',
                          detail: 'Đây là những thông tin liên quan đến hành trình của bạn',
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoute.journeyPage);
                          },
                        ),
                      ],
                    )
                  : state is CustomerInitial
                      ? const PrimaryShimmer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ContainerShimmer(height: 20, width: 150),
                              SizedBox(height: 10),
                              ContainerShimmer(height: 20, width: 350),
                            ],
                          ),
                        )
                      : Container())
        ]));
  }
}

class RegiterInfoItem extends StatelessWidget {
  final String icon;
  final String title;
  final String detail;
  final Function() onPressed;
  const RegiterInfoItem(
      {super.key, required this.icon, required this.title, required this.detail, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon,
          height: 40,
          width: 40,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextTheme.subTitle1,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                detail,
                style: AppTextTheme.bodyDescription,
              )
            ],
          ),
        ),
        const SizedBox(width: 10),
        PrimaryButton(
          context: context,
          onPressed: onPressed,
          label: 'Mở',
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        )
      ],
    );
  }
}
