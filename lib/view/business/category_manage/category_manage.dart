import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/routes.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/strings.dart';
import '../../../data/resources/themes.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/button/app_button.dart';
import '../../../shared/widgets/dialog_helper.dart';
import '../../../shared/widgets/loading.dart';
import '../../../shared/widgets/primary_app_bar.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/text_field/search_with_filter.dart';
import 'bloc/category_manage_bloc/category_manage_bloc.dart';
import 'component/add_category_dialog.dart';
import 'component/category_item.dart';

class CategoryManage extends StatelessWidget {
  CategoryManage({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();
  final CategoryManageBloc categoryBloc = CategoryManageBloc();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as CategoryManageArgs;
    categoryBloc.currentSubTabId = args.subTabId;

    final ScrollController scrollController = ScrollController();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.gray10,
      appBar: PrimaryAppBar(
        title: 'Quản lí danh mục',
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryButton(
                    backgroundColor: Colors.white,
                    textStyle: AppTextTheme.textButtonPrimary
                        .copyWith(color: AppColor.primaryColor),
                    borderColor: AppColor.primaryColor,
                    context: context,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.categoryRearrange,
                        arguments: CategoryRearrangeArgs(
                          categoryManageBloc: categoryBloc,
                          categoryList: categoryBloc.categoryList,
                        ),
                      );
                    },
                    label: 'Sắp xếp vị trí',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FabAnimationButton(
        scrollController: scrollController,
        children: [
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddCategoryDialog(
                  categoryManageBloc: categoryBloc,
                ),
              );
            },
            backgroundColor: AppColor.primaryColor,
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocProvider<CategoryManageBloc>(
        create: (context) => categoryBloc..add(CategoryManageGetAllEvent()),
        child: BlocConsumer<CategoryManageBloc, CategoryManageState>(
          listener: (context, state) {
            if (state is CategoryManageCreateSuccessState) {
              toastSuccess('Tạo danh mục thành công!');
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
            if (state is CategoryManageCreateFailedState) {
              toastWarning(AlertText.updateFailed);
            }
            if (state is CategoryManageDeleteSuccessState) {
              Navigator.of(context).pop();
              toastSuccess('Xoá danh mục thành công!');
            }
            if (state is CategoryManageDeleteFailedState) {
              Navigator.of(context).pop();
              toastWarning(AlertText.deleteFailed);
            }
          },
          buildWhen: (pre, current) =>
              current is CategoryManageGetAllSuccessState,
          builder: (context, state) {
            if (state is CategoryManageGetAllSuccessState) {
              return NestedScrollView(
                controller: scrollController,
                physics: const PageScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  const SliverAppBar(
                    // expandedHeight: 120,
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    // pinned: true,
                    floating: true,
                    snap: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: TextFieldSearchWithFilter(),
                    ),
                  )
                ],
                body: ListView.builder(
                    itemCount: state.categoryList.length + 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == state.categoryList.length) {
                        return const SizedBox(
                          height: 70,
                        );
                      } else {
                        return CategoryItem(
                          key: ValueKey(state.categoryList[index].id),
                          data: state.categoryList[index],
                          onDeletePressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => getLoadingDialog(),
                                barrierDismissible: false);
                            categoryBloc.add(
                              CategoryManageDeleteEvent(
                                  cid: state.categoryList[index].id!,
                                  index: index),
                            );
                          },
                        );
                      }
                    }),
              );
            } else {
              return const Center(
                child: Loading(),
              );
            }
          },
        ),
      ),
    );
  }
}
