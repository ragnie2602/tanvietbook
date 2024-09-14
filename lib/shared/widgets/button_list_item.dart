import 'package:flutter/material.dart';
import '../../config/config.dart';

class ButtonListItem extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Function onPress;
  final Color? background;

  const ButtonListItem({
    super.key,
    required this.title,
    required this.onPress,
    this.trailing,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 20, right: 12),
        color: background ?? bgItemColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 18, color: textColor),
            ),
            Expanded(child: Container()),
            trailing ??
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: iconColor,
                ),
          ],
        ),
      ),
      onTap: () {
        onPress();
      },
    );
  }
}
