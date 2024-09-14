import 'package:flutter/material.dart';

import '../../../../../data/constants.dart';
import '../../../../../data/resources/themes.dart';
import '../../../../../shared/widgets/primary_switch.dart';
import '../bloc/category_call_action_bloc/category_call_action_bloc.dart';

class CallActionItem extends StatefulWidget {
  final int index;
  final CategoryCallActionBloc categoryCallActionBloc;
  const CallActionItem(
      {Key? key, required this.index, required this.categoryCallActionBloc})
      : super(key: key);

  @override
  State<CallActionItem> createState() => _CallActionItemState();
}

class _CallActionItemState extends State<CallActionItem> {
  bool currentValue = false;

  @override
  void initState() {
    currentValue = widget.categoryCallActionBloc.showList[widget.index];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
            child: Text(
          LandingPageCallActionOptions.list[widget.index],
          style: AppTextTheme.textPrimary,
        )),
        PrimarySwitch(
          initialValue: currentValue,
          onToggle: (value) {
            setState(() {
              widget.categoryCallActionBloc.showList[widget.index] = value;
              currentValue = value;
            });
          },
        ),
      ],
    );
  }
}
