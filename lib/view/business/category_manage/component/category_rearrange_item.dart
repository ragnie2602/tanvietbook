import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../data/resources/themes.dart';

import '../../../../data/resources/colors.dart';
import '../../../../model/business/category/business_category_response.dart';

class CategoryRearrangeItem extends StatelessWidget {
  final BusinessCategoryResponse category;
  final Function onUp;
  final Function onDown;
  final int index;
  const CategoryRearrangeItem(
      {Key? key,
      required this.category,
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
                    Text(category.categoryName ?? 'Tên danh mục'),
                    const SizedBox(height: 10),
                    Text('Loại: ${category.type ?? 'Loại danh mục'}',
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
