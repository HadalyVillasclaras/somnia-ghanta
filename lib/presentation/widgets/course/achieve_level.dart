import 'package:flutter/material.dart';
import 'package:ghanta/domain/entities/subphase.dart';

class AchieveLevel extends StatelessWidget {
  const AchieveLevel({
    super.key,
    required this.subphase,
    required this.left,
    required this.top,
    required this.onTap,
  });

  final Subphase subphase;
  final double left;
  final double top;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.sizeOf(context);
    return Positioned(
      left: left,
      top: top,
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          'assets/course/flor.png',
          height: sizes.height * 0.16,
          width: sizes.height * 0.16,
        ),
      ),
    );
  }
}
