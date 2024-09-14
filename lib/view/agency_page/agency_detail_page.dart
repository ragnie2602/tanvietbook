import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../domain/entity/agency/agency_detail.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/widgets/back_button.dart';
import '../../shared/widgets/carousel/primary_carousel.dart';
import '../base/base_page_sate.dart';
import 'agency_all_product_page.dart';
import 'agency_category_page.dart';
import 'agency_info_page.dart';
import 'cubit/agency_cubit.dart';

class AgencyDetailPage extends StatefulWidget {
  const AgencyDetailPage({super.key});

  @override
  State<AgencyDetailPage> createState() => _AgencyDetailPageState();
}

class _AgencyDetailPageState
    extends BasePageState<AgencyDetailPage, AgencyCubit>
    with SingleTickerProviderStateMixin {
  // @override
  // bool get useBlocProviderValue => true;
  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = context.arguments as AgencyDetailPageAgrs;
    agencyDetail = args.agencyDetail;
    cubit.agencyDetail = args.agencyDetail;
    // setCubit = args.agencyCubit;
    scrollController = ScrollController();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  late final AgencyDetailPageAgrs args;
  late final AgencyDetail agencyDetail;
  late final ScrollController scrollController;
  late final TabController _tabController;

  @override
  Widget buildPage(BuildContext context) {
    return ExtendedNestedScrollView(
      controller: scrollController,
      physics: const NeverScrollableScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            floating: true,
            pinned: true,
            elevation: 1,
            backgroundColor: AppColor.transparent,
            toolbarHeight: context.screenWidth * 9 / 16,
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: PrimaryCarousel(
                data: agencyDetail.background ?? [],
                showIndicator: false,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                height: kToolbarHeight,
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    const BackButtonCustom(),
                    Expanded(
                      child: TabBar(
                        isScrollable: false,
                        unselectedLabelColor: AppColor.black,
                        labelPadding: const EdgeInsets.all(8),
                        labelColor: AppColor.primaryColor,
                        labelStyle: AppTextTheme.bodyStrong,
                        indicatorColor: AppColor.primaryColor,
                        // overlayColor: const MaterialStatePropertyAll(AppColor.red),

                        // onTap: onTap,
                        // tabs: tabs
                        //     .map((tabTitle) => Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Text(tabTitle)))
                        //     .toList(),

                        controller: _tabController,

                        tabs: const [
                          Text(
                            'Cửa hàng',
                          ),
                          Text(
                            'Danh mục',
                          ),
                          Text('Thông tin'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          AgencyAllProduct(
            agencyCubit: cubit,
            scrollController: scrollController,
          ),
          const AgencyCategoryPage(),
          AgencyInfoPage(
            agencyDetail: agencyDetail,
          ),
        ],
      ),
    );
  }
}
