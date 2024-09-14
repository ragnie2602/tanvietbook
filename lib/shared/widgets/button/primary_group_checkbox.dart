import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../container/primary_gesture_detector.dart';

class PrimaryGroupCheckbox extends StatefulWidget {
  final Axis? direction;
  final List<String> items;
  final List<bool> initialValue;
  final bool? checkOnlyOne;

  final Function(List<bool> result) onChanged;

  const PrimaryGroupCheckbox(
      {Key? key,
      this.direction,
      required this.items,
      this.checkOnlyOne = false,
      required this.onChanged,
      required this.initialValue})
      : super(key: key);

  @override
  State<PrimaryGroupCheckbox> createState() => _PrimaryGroupCheckboxState();
}

class _PrimaryGroupCheckboxState extends State<PrimaryGroupCheckbox> {
  final List<bool> checkValue = [];

  @override
  void initState() {
    checkValue.addAll(widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: widget.direction ?? Axis.horizontal,
      spacing: 16,
      children: checkValue
          .asMap()
          .entries
          .map(
            (e) => PrimaryGestureDetector(
              splashColor: null,
              onTap: () {
                setState(() {
                  final newVal = !checkValue[e.key];
                  if (widget.checkOnlyOne!) {
                    for (int i = 0; i < checkValue.length; i++) {
                      checkValue[i] = i == e.key ? newVal : false;
                    }
                  } else {
                    checkValue[e.key] = newVal;
                  }

                  widget.onChanged.call(checkValue);
                });
              },
              child: Wrap(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: checkValue[e.key],
                        // activeColor: AppColor.primaryColor,
                        side: const BorderSide(
                            color: AppColor.neutral5, width: 1.5),
                        onChanged: (changedValue) {
                          // widget.onTap();
                          setState(() {
                            final newVal = !checkValue[e.key];
                            if (widget.checkOnlyOne!) {
                              for (int i = 0; i < checkValue.length; i++) {
                                checkValue[i] = i == e.key ? newVal : false;
                              }
                            } else {
                              checkValue[e.key] = newVal;
                            }
                            widget.onChanged.call(checkValue);
                          });
                        },
                      ),
                      Text(
                        widget.items[e.key],
                        style: AppTextTheme.textPrimary,
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
