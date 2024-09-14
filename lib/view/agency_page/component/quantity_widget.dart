import 'dart:async';

import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../shared/widgets/container/primary_container.dart';
import '../../../shared/widgets/primary_icon_button.dart';

class QuantityWidget extends StatefulWidget {
  final Function(int quantity) onValueChanged;

  /// action will be called after debounce time ends
  final Function(int quantity)? actionAfterValueChanged;
  final int? initialQuantity;
  final int debounce;

  const QuantityWidget({
    super.key,
    required this.onValueChanged,
    this.initialQuantity,
    this.debounce = 0,
    this.actionAfterValueChanged,
  });

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  late int q;
  late final TextEditingController quantityContoller;
  Timer? _debounce;

  @override
  void initState() {
    q = widget.initialQuantity ?? 1;
    quantityContoller = TextEditingController()..text = q.toString();
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onQuantityChangeChanged(int value) {
    widget.onValueChanged(q);
    if (widget.debounce != 0 && (_debounce?.isActive ?? false)) {
      _debounce?.cancel();
    }
    _debounce = Timer(Duration(milliseconds: widget.debounce), () {
      if (widget.actionAfterValueChanged != null) {
        widget.actionAfterValueChanged!(q);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      borderColor: AppColor.neutral5,
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryIconButton(
              context: context,
              onPressed: () {
                if (q > 1) {
                  setState(() => q--);
                  _onQuantityChangeChanged(q);
                  quantityContoller.text = q.toString();
                }
              },
              icon: Icons.remove,
            ),
            // const VerticalDivider(
            //   thickness: 1,
            //   color: AppColor.neutral5,
            // ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 40),
              child: IntrinsicWidth(
                child: TextFormField(
                  controller: quantityContoller,
                  textAlign: TextAlign.center,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final int valueChange = int.tryParse(value) ?? 0;
                    if (valueChange <= 0) {
                      quantityContoller.text = q.toString();
                      return;
                    }

                    q = valueChange;
                    _onQuantityChangeChanged(q);
                  },
                  style: AppTextTheme.bodyRegular,
                  decoration: const InputDecoration(
                      border: InputBorder.none, isDense: true, counterText: ''),
                ),
              ),
            ),
            // const VerticalDivider(
            //   thickness: 1,
            //   color: AppColor.neutral5,
            // ),
            PrimaryIconButton(
              context: context,
              onPressed: () {
                setState(() {
                  q++;
                });

                _onQuantityChangeChanged(q);
                quantityContoller.text = q.toString();
              },
              icon: Icons.add,
            ),
          ],
        ),
      ),
    );
  }
}
