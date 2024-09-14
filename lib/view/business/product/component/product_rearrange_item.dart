import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../data/resources/themes.dart';

import '../../../../data/resources/colors.dart';
import '../../../../model/business/product/product_detail_response.dart';

class ProductRearrangeItem extends StatelessWidget {
  final ProductDetailResponse product;
  final Function onUp;
  final Function onDown;
  final int index;
  const ProductRearrangeItem(
      {Key? key,
      required this.product,
      required this.onUp,
      required this.onDown,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.postName ?? 'Tên bài đăng'),
                    const SizedBox(height: 10),
                    Text('Danh mục: ${product.categoryName ?? 'Tên danh mục'}',
                        style: AppTextTheme.textDisable),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  onUp(index);
                },
                child: SvgPicture.asset("assets/icons/ic_button_up.svg"),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  onDown(index);
                },
                child: SvgPicture.asset("assets/icons/ic_button_down.svg"),
              ),
              const SizedBox(width: 10),
              ReorderableDragStartListener(
                key: const ValueKey(-2),
                index: 1,
                child: SvgPicture.asset("assets/icons/ic_button_dragable.svg"),
              ),
            ],
          ),
        ),
        const Divider(height: 0, thickness: 0.5, color: AppColor.gray06),
      ],
    );
  }
}
