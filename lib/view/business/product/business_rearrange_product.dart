import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../shared/widgets/primary_app_bar.dart';
import '../../../shared/widgets/primary_button.dart';
import '../bloc/business_bloc.dart';

import '../../../config/routes.dart';
import '../../../model/business/product/product_detail_response.dart';
import 'component/product_rearrange_item.dart';

class BusinessProductRearrange extends StatefulWidget {
  const BusinessProductRearrange({Key? key}) : super(key: key);

  @override
  State<BusinessProductRearrange> createState() =>
      _BusinessProductRearrangeState();
}

class _BusinessProductRearrangeState extends State<BusinessProductRearrange> {
  List<ProductDetailResponse> productList = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as BusinessProductRearrangeArgs;
    productList = args.businessBloc.productList;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const PrimaryAppBar(title: 'Sắp xếp vị trí bài đăng'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColor.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: const Row(
              children: [
                Text('Thông tin bài đăng',
                    style: AppTextTheme.textPrimaryWhite),
                Spacer(),
                Text('Di chuyển', style: AppTextTheme.textPrimaryWhite)
              ],
            ),
          ),
          Expanded(
            child: ReorderableListView.builder(
              itemBuilder: (context, index) => ProductRearrangeItem(
                product: productList[index],
                key: Key(index.toString()),
                index: index,
                onUp: (index) {
                  if (index == 0) return;
                  setState(() {
                    var item = productList.removeAt(index);
                    productList.insert(index - 1, item);
                  });
                },
                onDown: (index) {
                  if (index == productList.length - 1) return;
                  setState(() {
                    var item = productList.removeAt(index);
                    productList.insert(index + 1, item);
                  });
                },
              ),
              itemCount: productList.length,
              onReorder: (int oldIndex, int newIndex) {
                setState(
                  () {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    log("o: $oldIndex, n: $newIndex");
                    var item = productList.removeAt(oldIndex);
                    productList.insert(newIndex, item);
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
                  args.businessBloc.add(
                    BusinessChangePositionProductEvent(
                      // categoryId: args.categoryId,
                      pidList: productList.map((e) => e.id ?? '').toList(),
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
