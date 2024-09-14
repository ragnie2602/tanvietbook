import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquee/marquee.dart';
import '../../../../data/constants.dart';
import '../../../../data/resources/resources.dart';
import '../../../../shared/etx/view_extensions.dart';
import '../../../../shared/widgets/container/primary_container.dart';
import '../../../../shared/widgets/container/primary_gesture_detector.dart';
import '../../../../shared/widgets/image/primary_image.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/primary_divider.dart';
import '../../category_manage/component/add_category_content_bottom.dart';
import 'post_overall.dart';

import '../../../../config/routes.dart';
import '../../../../shared/widgets/container_shimmer.dart';
import '../../../../shared/widgets/primary_shimmer.dart';
import '../../bloc/business_bloc.dart';

class WebMiniOverall extends StatelessWidget {
  final BusinessBloc businessBloc;

  const WebMiniOverall({Key? key, required this.businessBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BusinessBloc, BusinessState>(
      listener: (context, state) {
        if (state is BusinessGetAllSuccessState) {
          if (state.businessList.isNotEmpty) {
            businessBloc.currentSelectedBusinessId =
                state.businessList.first.id ?? '';
            businessBloc.add(BusinessGetSubTabEvent());
          }
        }
        if (state is BusinessGetSubTabSuccessState) {
          businessBloc.add(BusinessGetOverallEvent());
        }
      },
      buildWhen: (pre, current) => current is BusinessGetOverallSuccessState,
      builder: (context, state) {
        if (state is BusinessGetAllSuccessState && state.businessList.isEmpty) {
          return Center(child: SvgPicture.asset(Assets.icNoData));
        }

        if (state is BusinessGetOverallSuccessState) {
          final webMiniGeneral = state.webMiniOverallResponse;
          final postGeneral = state.webMiniOverallResponse.postGeneral;
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 30,
                      child: Marquee(
                        blankSpace: 100,
                        text: webMiniGeneral.websiteName ?? "",
                        style: AppTextTheme.textPrimaryBoldMedium,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // PrimaryIconButton(
                  //   context: context,
                  //   icon: "assets/icons/ic_revert.svg",
                  //   backgroundColor: AppColor.primaryColor,
                  //   iconColor: Colors.white,
                  //   onPressed: () {
                  //     showModalBottomSheet(
                  //       isScrollControlled: true,
                  //       context: context,
                  //       builder: (context) => FractionallySizedBox(
                  //           heightFactor: 0.85,
                  //           child: WebMiniConfig(
                  //             businessBloc: businessBloc,
                  //           )),
                  //     );
                  //   },
                  // )
                ],
              ),
              const SizedBox(height: 20),
              PrimaryContainer(
                padding: const EdgeInsets.all(10),
                borderColor: AppColor.gray09,
                backgroundColor: AppColor.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lượt truy cập ${webMiniGeneral.defaultName}',
                      style: AppTextTheme.textPrimaryBoldMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/icons/ic_fund_view.svg'),
                                const SizedBox(width: 12),
                                Text(
                                  (webMiniGeneral.accessCount ?? 0).toString(),
                                  style: AppTextTheme.text70024,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Text(
                                  'So với ${webMiniGeneral.growthType}',
                                  style: AppTextTheme.textPrimary,
                                ),
                                const SizedBox(width: 8),
                                webMiniGeneral.growthChange == 1
                                    ? const Icon(Icons.arrow_drop_up,
                                        color: AppColor.primaryColor)
                                    : const Icon(
                                        Icons.arrow_drop_down,
                                        color: AppColor.errorColor,
                                      ),
                                const SizedBox(width: 0),
                                Text(
                                  webMiniGeneral.growthRate.toString(),
                                  style: AppTextTheme.textPrimary.copyWith(
                                    color: webMiniGeneral.growthChange == 1
                                        ? AppColor.primaryColor
                                        : AppColor.errorColor,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        PrimaryNetworkImage(
                          imageUrl: webMiniGeneral.logo ?? '',
                          height: 60,
                          width: 80,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.gray09, width: 1),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tăng hiệu quả của ${webMiniGeneral.defaultName}',
                                style: AppTextTheme.textPrimaryBoldMedium,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Hãy xây dựng ${webMiniGeneral.defaultName} của bạn trở lên chuyên nghiệp hơn',
                                style: AppTextTheme.textPrimary,
                              ),
                              const SizedBox(height: 10),
                              PrimaryButton(
                                  context: context,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoute.businessDetail,
                                      arguments: BusinessDetailPageArgs(
                                          businessBloc: businessBloc,
                                          viewType: ViewType.viewMember),
                                    );
                                  },
                                  label: 'Xem ${webMiniGeneral.defaultName}'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset('assets/icons/ic_seo.svg'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const PrimaryDivider(),
                    PrimaryGestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoute.businessUpdateInfo,
                            arguments: BusinessUpdateInfoArgs(
                              businessBloc: businessBloc,
                              defaultName: webMiniGeneral.defaultName ?? '',
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Thông tin ${webMiniGeneral.defaultName}',
                                    style: AppTextTheme.textButtonPrimary
                                        .copyWith(color: AppColor.primaryColor),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Logo, Tên Website, Banner, Số điện thoại và Email...',
                                    style: AppTextTheme.textPrimarySmall,
                                  )
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward)
                          ],
                        ),
                      ),
                    ),
                    const PrimaryDivider(),
                    PrimaryGestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoute.businessCategory,
                            arguments: CategoryManageArgs(
                                subTabId:
                                    businessBloc.currentBusinessSubTabId));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Danh mục Website Mini',
                                    style: AppTextTheme.textButtonPrimary
                                        .copyWith(color: AppColor.primaryColor),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Quản lí danh mục của Website Mini của bạn',
                                    style: AppTextTheme.textPrimarySmall,
                                  )
                                ],
                              ),
                            ),
                            CircleAvatar(
                                backgroundColor: const Color(
                                  0XFFE6FFFE,
                                ),
                                child: Text(
                                    style: AppTextTheme.textPrimary.copyWith(
                                      fontSize: 12,
                                      color: const Color(0xFF064639),
                                    ),
                                    webMiniGeneral.catalogCount.toString())),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(Icons.arrow_forward)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              PrimaryContainer(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                borderColor: AppColor.primaryColor,
                backgroundColor: const Color(0xFFE8FDF9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tạo mới Landing Page của bạn',
                      style: AppTextTheme.textPrimaryBoldMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Xây dựng một ${webMiniGeneral.defaultName} chuyên nghiệp và hiệu quả hơn với những nội dung thật ý nghĩa và giao diện thật sinh động!',
                      style: AppTextTheme.textPrimary,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      context: context,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => FractionallySizedBox(
                            heightFactor: 0.8,
                            child: AddCategoryContent(
                                subTabId: businessBloc.currentBusinessSubTabId),
                          ),
                        );
                      },
                      label: 'Thêm mới Landing Page',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              PostOverall(
                postGeneral: postGeneral,
                subTabId: businessBloc.currentBusinessSubTabId,
              )
            ],
          );
        } else {
          return const WebMiniOverallShimmer();
        }
      },
    );
  }
}

class WebMiniOverallShimmer extends StatelessWidget {
  const WebMiniOverallShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryShimmer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerShimmer(
          width: context.screenWidth * 0.5,
        ),
        const SizedBox(height: 20),
        const PrimaryContainer(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerShimmer(),
              SizedBox(height: 12),
              ContainerShimmer(
                height: 60,
                width: double.infinity,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const PrimaryContainer(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerShimmer(),
              SizedBox(height: 12),
              ContainerShimmer(
                height: 60,
                width: double.infinity,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(height: 20),
        ContainerShimmer(
          width: context.screenWidth * 0.6,
        ),
        const SizedBox(height: 20),
        const PrimaryContainer(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerShimmer(),
              SizedBox(height: 12),
              ContainerShimmer(
                height: 60,
                width: double.infinity,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const PrimaryContainer(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerShimmer(),
              SizedBox(height: 12),
              ContainerShimmer(
                height: 60,
                width: double.infinity,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ));
  }
}
