import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/widgets/loading.dart';
import '../../../shared/widgets/primary_app_bar.dart';
import '../category_manage/category_detail/bloc/category_call_action_bloc/category_call_action_bloc.dart';

import '../../../data/resources/resources.dart';
import '../../../shared/widgets/text_field/search_with_filter.dart';
import 'component/concern_item.dart';

class CustomerInterested extends StatefulWidget {
  const CustomerInterested({Key? key}) : super(key: key);

  @override
  State<CustomerInterested> createState() => _CustomerInterestedState();
}

class _CustomerInterestedState extends State<CustomerInterested> {
  final CategoryCallActionBloc callActionBloc = CategoryCallActionBloc();
  final scrollController = ScrollController();
  void _onFilterPressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => callActionBloc..add(CategoryCallActionGetAllEvent()),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: const PrimaryAppBar(
          title: 'Khách hàng quan tâm',
        ),
        body: SafeArea(
          child: NestedScrollView(
            physics: const PageScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                const SliverAppBar(
                  expandedHeight: 120,
                  flexibleSpace: FlexibleSpaceBar(
                    background: TextFieldSearchWithFilter(
                      filterWidget: Scaffold(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  // pinned: true,
                  floating: true,
                  snap: true,
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child:
                  BlocConsumer<CategoryCallActionBloc, CategoryCallActionState>(
                listener: (context, state) {
                  if (state is CategoryCallActionCreateSuccessState) {}
                },
                buildWhen: (pre, current) =>
                    current is CategoryCallActionGetAllSuccessState,
                builder: (context, state) {
                  if (state is CategoryCallActionGetAllSuccessState) {
                    return state.concernList.isNotEmpty
                        ? ListView.separated(
                            itemCount: state.concernList.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ConcernItem(
                                callActionBloc: callActionBloc,
                                concernResponse: state.concernList[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                          )
                        : Center(
                            child: SvgPicture.asset(Assets.icNoData),
                          );
                  } else {
                    return const Center(
                      child: Loading(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
