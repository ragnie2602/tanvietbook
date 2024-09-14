import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../domain/entity/agency_category/agency_category.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/widgets/image/primary_image.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/primary_divider.dart';
import '../base/base_page_sate.dart';
import 'agency_all_product_page.dart';
import 'cubit/agency_cubit.dart';

class AgencyCategoryPage extends StatefulWidget {
  const AgencyCategoryPage({super.key});

  @override
  State<AgencyCategoryPage> createState() => _AgencyCategoryPageState();
}

class _AgencyCategoryPageState
    extends BasePageState<AgencyCategoryPage, AgencyCubit>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get useBlocProviderValue => true;

  @override
  Color? get backgroundColor => AppColor.white;

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setCubit = context.read<AgencyCubit>();
    cubit.getAllCategories();
  }

  final GlobalKey navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<AgencyCubit, AgencyState>(
      buildWhen: (previous, current) {
        return current is AgencyGetAllAgencyCategorySuccess;
      },
      builder: (parrentContext, state) {
        return state.maybeWhen(
          getAllCategorySuccess: (categories) {
            return Navigator(
              key: navigationKey,
              initialRoute: '/',
              onGenerateRoute: (settings) {
                if (settings.name == '/') {
                  return MaterialPageRoute(
                    builder: (context) =>
                        AgencyCategoryList(categories: categories),
                  );
                }
                if (settings.name == '/detail') {
                  return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return AgencyAllProduct(
                      agencyCubit: cubit,
                      showAppBar: true,
                      parrentContext: parrentContext,
                      agencyCategory:
                          (settings.arguments as AgencyGetAllProductPageAgrs?)
                              ?.agencyCategory,
                    );
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, .0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    final tween = Tween(begin: begin, end: end);
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    );

                    return SlideTransition(
                      position: tween.animate(curvedAnimation),
                      child: child,
                    );
                  });
                }
                return null;
              },
            );
          },
          orElse: () {
            return const Loading();
          },
        );
      },
    );
  }
}

class AgencyCategoryList extends StatelessWidget {
  final List<AgencyCategory> categories;
  const AgencyCategoryList({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: AppColor.white,
      child: ListView.separated(
        itemCount: categories.length,
        controller: ScrollController(),
        // shrinkWrap: true,
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/detail',
                  arguments:
                      AgencyGetAllProductPageAgrs(agencyCategory: category));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  PrimaryNetworkImage(
                    imageUrl:
                        (category.image != null && category.image!.isNotEmpty)
                            ? category.image?.first
                            : '',
                    width: context.screenWidth / 6,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Text(
                      '${category.name} (${category.quantity})',
                      style: AppTextTheme.bodyMedium,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_right_rounded)
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
          child: PrimaryDivider(),
        ),
      ),
    );
  }
}
