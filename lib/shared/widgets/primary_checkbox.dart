import 'package:flutter/material.dart';
import '../../data/resources/themes.dart';

class PrimaryCheckBox extends StatefulWidget {
  final Function() onTap;
  final bool value;
  const PrimaryCheckBox({required this.onTap, required this.value, Key? key})
      : super(key: key);

  @override
  State<PrimaryCheckBox> createState() => _PrimaryCheckBoxState();
}

class _PrimaryCheckBoxState extends State<PrimaryCheckBox> {
  late bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
        setState(() {
          value = !value;
        });
      },
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (changedValue) {
              widget.onTap();
              setState(() {
                value = !value;
              });
            },
          ),
          const Text(
            'Đặt làm mặc định',
            style: AppTextTheme.textPrimary,
          )
        ],
      ),
    );
  }
}
