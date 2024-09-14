import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../data/resources/colors.dart';

class PrimarySwitch extends StatefulWidget {
  const PrimarySwitch({
    Key? key,
    required this.onToggle,
    this.width = 50,
    this.height = 24,
    this.toggleSize = 15,
    this.initialValue = true,
    this.readOnly = false,
  }) : super(key: key);
  final double width;
  final double height;
  final double toggleSize;
  final bool initialValue;
  final bool readOnly;

  final Function(bool value) onToggle;

  @override
  State<PrimarySwitch> createState() => _PrimarySwitchState();
}

class _PrimarySwitchState extends State<PrimarySwitch> {
  late bool value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      value: value,
      // showOnOff: true,
      disabled: widget.readOnly,
      // activeText: 'Hiện',
      // inactiveText: 'Ẩn',
      valueFontSize: 8,
      activeColor: AppColor.primaryColor,
      onToggle: (value) {
        setState(() {
          this.value = value;
        });
        widget.onToggle.call(value);
      },
      width: widget.width,
      height: widget.height,
      toggleSize: widget.toggleSize,
    );
  }
}
