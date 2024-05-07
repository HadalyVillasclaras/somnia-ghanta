import 'package:flutter/material.dart';

class ActivityBody extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;

  const ActivityBody({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.end,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            ...children,
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.10)
          ],
        ),
      ),
    );
  }
}
