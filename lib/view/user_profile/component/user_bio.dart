import 'package:flutter/material.dart';
import '../../../data/resources/themes.dart';

import '../../../shared/utils/utils.dart';

class UserBio extends StatelessWidget {
  final String? bio;
  final bool bioHidden;

  const UserBio({super.key, this.bio, this.bioHidden = false});

  @override
  Widget build(BuildContext context) {
    return bio != null && bio!.isNotEmpty
        ? Text(
            Utils.convertHtmlToText(bio!),
            textAlign: TextAlign.center,
            maxLines: 5,
            style: bioHidden
                ? AppTextTheme.textLowPriority.copyWith(
                    overflow: TextOverflow.ellipsis,
                    fontStyle: FontStyle.italic)
                : AppTextTheme.bodyStrong,
          )
        : Container();
  }
}
