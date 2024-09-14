import 'package:flutter/material.dart';

import '../../../data/resources/resources.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/container/primary_container.dart';
import '../../../shared/widgets/primary_divider.dart';

class FolderContainerItem extends StatelessWidget {
  final Widget child;
  final Widget? header;
  final String? title;
  final void Function()? onTap;
  const FolderContainerItem({
    super.key,
    required this.child,
    this.title,
    this.header,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          PrimaryContainer(
            height: 150,
            backgroundColor: AppColor.primaryColor.withOpacity(0.5),
            // height: double.infinity,
            margin: const EdgeInsets.only(top: 20),
            borderRadius: BorderRadius.circular(10),
          ),
          CustomPaint(
            painter: FolderContainerPainter(),
            child: Container(
              // height: 200,
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      width: constraints.maxWidth * 3 / 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: onTap,
                            child: header ??
                                Text(
                                  title ?? '',
                                  style: AppTextTheme.titleMedium
                                      .copyWith(color: AppColor.primaryColor),
                                ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const PrimaryDivider(
                            color: AppColor.secondaryColor,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 100),
                      child: child),
                ],
              ),
              // backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
