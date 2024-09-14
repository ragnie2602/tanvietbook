import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../shared/widgets/primary_app_bar.dart';
import '../../../shared/widgets/primary_button.dart';

import '../../../config/routes.dart';
import '../../../model/business/category/business_category_response.dart';
import 'bloc/category_manage_bloc/category_manage_bloc.dart';
import 'component/category_rearrange_item.dart';

class CategoryRearrange extends StatefulWidget {
  const CategoryRearrange({Key? key}) : super(key: key);

  @override
  State<CategoryRearrange> createState() => _CategoryRearrangeState();
}

class _CategoryRearrangeState extends State<CategoryRearrange> {
  List<BusinessCategoryResponse> categoryList = [];

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as CategoryRearrangeArgs;
    categoryList = args.categoryList;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const PrimaryAppBar(title: 'Sắp xếp vị trí danh mục'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColor.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: const Row(
              children: [
                Text('Thông tin sản phẩm',
                    style: AppTextTheme.textPrimaryWhite),
                Spacer(),
                Text('Di chuyển', style: AppTextTheme.textPrimaryWhite)
              ],
            ),
          ),
          Expanded(
            child: ReorderableListView.builder(
              itemBuilder: (context, index) => CategoryRearrangeItem(
                category: categoryList[index],
                key: Key(index.toString()),
                index: index,
                onUp: (index) {
                  if (index == 0) return;
                  setState(() {
                    var item = categoryList.removeAt(index);
                    categoryList.insert(index - 1, item);
                  });
                },
                onDown: (index) {
                  if (index == categoryList.length - 1) return;
                  setState(() {
                    var item = categoryList.removeAt(index);
                    categoryList.insert(index + 1, item);
                  });
                },
              ),
              itemCount: categoryList.length,
              onReorder: (int oldIndex, int newIndex) {
                setState(
                  () {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    log("o: $oldIndex, n: $newIndex");
                    var item = categoryList.removeAt(oldIndex);
                    categoryList.insert(newIndex, item);
                  },
                );
              },
            ),
          ),
          const Divider(
            height: 0,
            color: AppColor.gray06,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: PrimaryButton(
                context: context,
                label: 'Lưu',
                onPressed: () {
                  args.categoryManageBloc.add(
                    CategoryManageSwapEvent(
                      listCategoryId:
                          categoryList.map((e) => e.id ?? '').toList(),
                    ),
                  );
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }
}
