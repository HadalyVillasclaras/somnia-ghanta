import 'package:flutter/material.dart';

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
        style: !isSmall
            ? Theme.of(context).textTheme.titleLarge
            : Theme.of(context).textTheme.titleSmall);
  }
}
