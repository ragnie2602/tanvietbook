import 'package:flutter/material.dart';

import '../container/primary_gesture_detector.dart';

class PrimaryGroupRadioButton extends StatefulWidget {
  final Axis? direction;
  final List<Widget> items;
  final List<bool> initialValue;
  final bool? checkOnlyOne;
  final CrossAxisAlignment crossAxisAlignment;

  final Function(List<bool> result) onChanged;

  const PrimaryGroupRadioButton(
      {Key? key,
      this.direction,
      required this.items,
      this.checkOnlyOne = true,
      required this.onChanged,
      required this.initialValue,
      this.crossAxisAlignment = CrossAxisAlignment.center})
      : super(key: key);

  @override
  State<PrimaryGroupRadioButton> createState() =>
      _PrimaryGroupRadioButtonState();
}

class _PrimaryGroupRadioButtonState extends State<PrimaryGroupRadioButton> {
  final List<bool> checkValue = [];
  bool groupValue = true;
  int currentIndex = 0;

  @override
  void initState() {
    checkValue.addAll(widget.initialValue);
    currentIndex = checkValue.indexWhere((element) => element == true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // direction: widget.direction ?? Axis.vertical,
      // spacing: 0,
      children: checkValue
          .asMap()
          .entries
          .map(
            (e) => PrimaryGestureDetector(
              splashColor: null,
              onTap: () {
                if (currentIndex == e.key) return;
                currentIndex = e.key;
                setState(() {
                  final newVal = !checkValue[e.key];
                  for (int i = 0; i < checkValue.length; i++) {
                    checkValue[i] = i == e.key ? newVal : false;
                  }
                  groupValue = newVal;
                  widget.onChanged.call(checkValue);
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: widget.crossAxisAlignment,
                children: [
                  Radio(
                    groupValue: groupValue,
                    value: checkValue[e.key],
                    // activeColor: AppColor.primaryColor,
                    onChanged: (changedValue) {
                      // widget.onTap();
                      setState(() {
                        final newVal = !checkValue[e.key];
                        for (int i = 0; i < checkValue.length; i++) {
                          checkValue[i] = i == e.key ? newVal : false;
                        }
                        groupValue = newVal;
                        widget.onChanged.call(checkValue);
                      });
                    },
                  ),
                  Expanded(child: widget.items[e.key]),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
