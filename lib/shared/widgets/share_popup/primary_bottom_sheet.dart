import 'package:flutter/material.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';

class PrimaryBottomSheet extends StatelessWidget {
  final Widget child;
  final String title;
  const PrimaryBottomSheet({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(title, style: AppTextTheme.textPrimary),
                const Spacer(),
                IconButton(
                    hoverColor: AppColor.primaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          ),
          const Divider(height: 0, color: AppColor.gray06, thickness: 0.5),
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}
