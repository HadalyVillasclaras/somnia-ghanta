import 'package:flutter/material.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key, required this.courseId}) : super(key: key);
  final int courseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavigationTop(),
      extendBodyBehindAppBar: true,
      body: CourseScenario(
        courseId: courseId,
      ),
    );
  }
}

