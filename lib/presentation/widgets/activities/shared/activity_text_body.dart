import 'package:flutter/material.dart';
import 'package:ghanta/config/constants/colors_theme.dart';

class ActivityTextBody extends StatelessWidget {
  const ActivityTextBody(
    this.text, {
    super.key,
    this.isSmall = false,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final bool isSmall;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: !isSmall
            ? Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorsTheme.primaryColorBlue)
            : Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorsTheme.primaryColorBlue));
  }
}
