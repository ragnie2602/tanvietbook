import 'package:flutter/material.dart';

import '../../../data/resources/resources.dart';
import '../../../shared/widgets/container/primary_container.dart';
import '../../../shared/widgets/image/primary_svg_picture.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/secondary_text_field.dart';

class VoucherBlock extends StatefulWidget {
  final Function(String code) onApplied;

  const VoucherBlock({super.key, required this.onApplied});

  @override
  State<VoucherBlock> createState() => _VoucherBlockState();
}

class _VoucherBlockState extends State<VoucherBlock> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              PrimarySvgPicture(
                Assets.icVoucher,
                height: 24,
                color: AppColor.secondaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Mã giảm giá',
                style: AppTextTheme.bodyStrong,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: SecondaryTextField(
                  controller: controller,
                  maxLines: 1,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4)),
                  isDense: true,
                ),
              ),
              PrimaryButton(
                context: context,
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    widget.onApplied.call(controller.text.trim());
                  }
                },
                label: 'Áp dụng',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.5, horizontal: 16),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
