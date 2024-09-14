import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/routes.dart';
import '../../../data/constants.dart';
import '../../../shared/etx/view_extensions.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/bouncing.dart';
import '../../../shared/widgets/container/primary_container.dart';
import '../../../shared/widgets/container_shimmer.dart';
import '../../../shared/widgets/loading.dart';
import '../../../shared/widgets/primary_shimmer.dart';
import '../bloc/business_bloc.dart';
import '../category_manage/category_detail/category_content_detail.dart';
import 'component/product_category.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/resources/resources.dart';
import '../../../shared/widgets/button/app_button.dart';
import '../../../shared/widgets/carousel/primary_carousel.dart';
import '../../../shared/widgets/image/primary_image.dart';
import '../../../shared/widgets/quill/primary_editor.dart';
import '../../../shared/widgets/tab/primary_tab_bar.dart';

class BusinessDetailPage extends StatelessWidget {
  const BusinessDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as BusinessDetailPageArgs;
    final ScrollController scrollController = ScrollController();
    final BusinessBloc businessBloc = args.businessBloc;

    return BlocProvider.value(
      value: businessBloc
        ..add(BusinessGetDetailEvent())
        ..add(BusinessGetCategoryEvent()),
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        floatingActionButton: BlocBuilder<BusinessBloc, BusinessState>(
          buildWhen: (pre, state) => state is BusinessGetDetailSuccessState,
          builder: (context, state) {
            if (state is BusinessGetDetailSuccessState) {
              return FabAnimationButton(
                scrollController: scrollController,
                children: [
                  fabItem(
                      icon: Assets.icMessengerFill,
                      onPressed: () {
                        Utils.launchUri(
                            state.businessDetailResponse.messenger ?? '',
                            UriType.website);
                      }),
                  const SizedBox(height: 10),
                  fabItem(
                      icon: Assets.icZaloFill,
                      onPressed: () {
                        Utils.launchUri(
                            'https://zalo.me/${state.businessDetailResponse.zalo}',
                            UriType.website,
                            mode: LaunchMode.inAppWebView);
                      }),
                  const SizedBox(height: 10),
                  fabItem(
                      icon: Assets.icMailFill,
                      onPressed: () {
                        Utils.launchUri(
                            state.businessDetailResponse.email ?? '',
                            UriType.email);
                      }),
                  const SizedBox(height: 10),
                  fabItem(
                      icon: Assets.icPhoneFill,
                      onPressed: () {
                        Utils.launchUri(
                            state.businessDetailResponse.phoneNumber ?? '',
                            UriType.phone);
                      }),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<BusinessBloc, BusinessState>(
            buildWhen: (pre, current) =>
                current is BusinessGetDetailSuccessState,
            builder: (context, state) {
              if (state is BusinessGetDetailSuccessState) {
                return AppBar(
                  backgroundColor: AppColor.white,
                  centerTitle: false,
                  elevation: 1,
                  leading: IconButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColor.black,
                        size: 20,
                      )),
                  title: PrimaryNetworkImage(
                    width: 100,
                    height: 50,
                    fit: BoxFit.contain,
                    imageUrl: state.businessDetailResponse.logo ?? '',
                  ),
                );
              } else {
                return AppBar();
              }
            },
          ),
        ),
        body: SafeArea(
          child: ExtendedNestedScrollView(
            onlyOneScrollInBody: true,
            controller: scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                BlocBuilder<BusinessBloc, BusinessState>(
                  buildWhen: (pre, current) =>
                      current is BusinessGetDetailSuccessState,
                  builder: (context, state) {
                    if (state is BusinessGetDetailSuccessState) {
                      return SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            state.businessDetailResponse.banners != null
                                ? PrimaryCarousel(
                                    fit: BoxFit.cover,
                                    height: context.screenWidth * 9 / 16,
                                    data: state.businessDetailResponse.banners
                                        ?.map((e) => e.value ?? '')
                                        .toList())
                                : const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   state.businessDetailResponse.websiteName ?? '',
                                  //   style: AppTextTheme.textPrimaryBoldMedium,
                                  // ),
                                  // const SizedBox(height: 10),
                                  PrimaryEditor(
                                    readOnly: true,
                                    controller: QuillController(
                                      document: Utils.parseQuillDocument(state
                                          .businessDetailResponse.description),
                                      selection: const TextSelection.collapsed(
                                          offset: 0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SliverToBoxAdapter(
                          child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: PrimaryShimmer(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContainerShimmer(height: 20),
                            SizedBox(height: 10),
                            ContainerShimmer(width: 120),
                            SizedBox(height: 10),
                            ContainerShimmer(width: 220),
                            SizedBox(height: 10),
                            ContainerShimmer(width: 320),
                            SizedBox(height: 10),
                            ContainerShimmer(width: 320),
                          ],
                        )),
                      ));
                    }
                  },
                ),
              ];
            },
            body: BlocBuilder<BusinessBloc, BusinessState>(
              buildWhen: (pre, current) =>
                  current is BusinessGetCategorySuccessState,
              builder: (context, state) {
                if (state is BusinessGetCategorySuccessState) {
                  return Container(
                    color: AppColor.gray10,
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: PrimaryTabBar(
                        backgroundColor: AppColor.gray10,
                        tabs: List.from(state.categoryList
                            .map((e) => e.categoryName.toString())),
                        children: List.from(
                          state.categoryList.map(
                            (e) => e.type == CategoryType.post
                                ? ProductCategory(
                                    categoryId: e.id!,
                                    businessBloc: BusinessBloc(),
                                  )
                                : CategoryContentDetail(
                                    categoryId: e.id!,
                                    viewType: LandingPageViewType.view),
                          ),
                        )),
                  );
                } else {
                  return Container(
                      color: AppColor.white,
                      padding: const EdgeInsets.all(16.0),
                      child: const Center(child: Loading()));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget fabItem({required String icon, required Function() onPressed}) =>
    Bouncing(
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(2),
        child: PrimaryContainer(
          height: 40,
          backgroundColor: AppColor.primaryColor,
          width: 40,
          child: FittedBox(
            child: FloatingActionButton(
              mini: true,
              elevation: 0,
              backgroundColor: AppColor.primaryColor,
              isExtended: true,
              onPressed: () => onPressed.call(),
              child: SvgPicture.asset(
                icon,
                width: 25,
                height: 25,
              ),
            ),
          ),
        ),
      ),
    );
