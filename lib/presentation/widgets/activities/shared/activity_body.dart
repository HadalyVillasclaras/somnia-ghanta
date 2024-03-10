import 'package:flutter/material.dart';

class ActivityBody extends StatelessWidget {
  const ActivityBody({
    super.key,
    required this.child,
    this.isSpacerNeeded = true,
  });

  final Widget child;
  final bool isSpacerNeeded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isSpacerNeeded)
            const Spacer(),
            child,
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.18,
            )
          ],
        ),
      ),
    );
  }
}