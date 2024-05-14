import 'package:flutter/material.dart';

class FadeInAnimation extends StatefulWidget {
  final Widget child;

  const FadeInAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  FadeInAnimationState createState() => FadeInAnimationState();
}

class FadeInAnimationState extends State<FadeInAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityAnimation,
      child: widget.child,
    );
  }
}