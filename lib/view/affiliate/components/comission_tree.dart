import 'package:flutter/material.dart';

import '../../../data/resources/resources.dart';
import '../../../model/agency/comission/agency_comission_tree_response.dart';
import '../../../shared/utils/utils.dart';
import '../../user_profile/component/container_block.dart';

class ComissionTree extends StatelessWidget {
  final AgencyComissionTree agencyComissionTree;
  const ComissionTree({super.key, required this.agencyComissionTree});

  @override
  Widget build(BuildContext context) {
    return UserContainerBlock(
      title: agencyComissionTree.fullname ?? '',
      subTitle: Utils.formatMoney(
          (agencyComissionTree.totalPersonalSale ?? 0).toDouble()),
      borderColor: AppColor.transparent,
      backgroundColor: AppColor.primaryColor,
      icon: null,
      showAction: false,
      showAddButton: false,
      showConfigItemButton: false,
      titleStyle: AppTextTheme.bodyStrong.copyWith(color: AppColor.white),
      subTitleStyle: AppTextTheme.bodyStrong.copyWith(color: AppColor.white),
      showEditButton: false,
      showSwitchButton: false,
      child: agencyComissionTree.level1 != null &&
              agencyComissionTree.level1!.isNotEmpty
          ? ListView.builder(
              itemCount: agencyComissionTree.level1!.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return UserContainerBlock(
                  title:
                      '${agencyComissionTree.level1![index].fullname ?? ''} (${agencyComissionTree.level1![index].username ?? ''})',
                  subTitle: Utils.formatMoney(
                      (agencyComissionTree.level1![index].totalPersonalSale ??
                              0)
                          .toDouble()),
                  subTitleStyle: AppTextTheme.bodyStrong
                      .copyWith(color: AppColor.errorColor),
                  icon: null,
                  backgroundColor: AppColor.secondaryColor.withOpacity(0.1),
                  contentPadding: EdgeInsets.zero,
                  borderColor: AppColor.primaryColor,
                  initialExpanded: false,
                  showAction: false,
                  showAddButton: false,
                  showConfigItemButton: false,
                  showEditButton: false,
                  showSwitchButton: false,
                  isExpandable: agencyComissionTree.level1![index].level2 !=
                          null &&
                      (agencyComissionTree.level1![index].level2!.isNotEmpty),
                  child: agencyComissionTree.level1![index].level2 != null &&
                          agencyComissionTree.level1![index].level2!.isNotEmpty
                      ? ListView.builder(
                          itemCount:
                              agencyComissionTree.level1![index].level2!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, indexLv2) {
                            return UserContainerBlock(
                                initialExpanded: false,
                                isExpandable: false,
                                backgroundColor:
                                    const Color.fromARGB(255, 200, 250, 239),
                                title:
                                    '${agencyComissionTree.level1![index].level2![indexLv2].fullname ?? ''} (${agencyComissionTree.level1![index].level2![indexLv2].username ?? ''})',
                                subTitle: Utils.formatMoney((agencyComissionTree
                                            .level1![index]
                                            .level2![indexLv2]
                                            .totalPersonalSale ??
                                        0)
                                    .toDouble()),
                                icon: null,
                                showAction: false,
                                showAddButton: false,
                                showConfigItemButton: false,
                                subTitleStyle: AppTextTheme.bodyStrong
                                    .copyWith(color: AppColor.errorColor),
                                showEditButton: false,
                                showSwitchButton: false,
                                contentPadding: EdgeInsets.zero,
                                child: const SizedBox());
                          },
                        )
                      : const SizedBox(),
                );
              },
            )
          : const SizedBox(),
    )
        // ExpandableNotifier(
        //     initialExpanded: true,
        //     child: ScrollOnExpand(
        //       child: ExpandablePanel(
        //         header: PrimaryContainer(
        //           padding: const EdgeInsets.symmetric(vertical: 16),
        //           borderRadius: const BorderRadius.only(
        //               topLeft: Radius.circular(10),
        //               topRight: Radius.circular(10)),
        //           backgroundColor: AppColor.primaryColor,
        //           child: Text(agencyComissionTree.level1!.first.fullname ?? ''),
        //         ),
        //         collapsed: const SizedBox(),
        //         expanded: const CircleAvatar(),
        //       ),
        //     ),
        //   )
        ;
  }
}
