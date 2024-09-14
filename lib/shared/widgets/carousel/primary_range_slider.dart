import 'package:flutter/material.dart';
import '../../../data/resources/resources.dart';
import '../../utils/utils.dart';

class PrimaryRangeSlider extends StatefulWidget {
  final double from;
  final double to;
  final Function(double from, double to) onChanged;

  const PrimaryRangeSlider(
      {super.key, this.from = 0, this.to = 0, required this.onChanged});

  @override
  State<PrimaryRangeSlider> createState() => _PrimaryRangeSliderState();
}

class _PrimaryRangeSliderState extends State<PrimaryRangeSlider> {
  late RangeValues _currentRangeValues;
  @override
  void initState() {
    _currentRangeValues = RangeValues(widget.from, widget.to);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giá: ${Utils.formatMoney(_currentRangeValues.start)} - ${Utils.formatMoney(_currentRangeValues.end)}',
          style: AppTextTheme.textPrimary,
        ),
        RangeSlider(
          values: _currentRangeValues,
          max: 10000000,
          divisions: 50,
          labels: RangeLabels(
            Utils.formatMoney(_currentRangeValues.start),
            Utils.formatMoney(_currentRangeValues.end),
          ),
          activeColor: AppColor.secondaryColor,
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
            widget.onChanged
                .call(_currentRangeValues.start, _currentRangeValues.end);
          },
        ),
      ],
    );
  }
}
