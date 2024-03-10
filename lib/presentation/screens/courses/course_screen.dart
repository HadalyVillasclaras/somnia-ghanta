import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/domain/entities/phase.dart';
import 'package:ghanta/presentation/providers/courses_provider.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:go_router/go_router.dart';

class CourseScreen extends ConsumerWidget {
  const CourseScreen({Key? key, required this.courseId}) : super(key: key);

  final int courseId;

  @override
  Widget build(BuildContext context, ref) {
    print('course');
    final Course course = ref.watch(coursesProvider).firstWhere(
          (Course course) => course.id == courseId,
        );

    final sizes = MediaQuery.of(context).size;
    final List<Phase> phases = course.phases ?? [];
    print('Phase');

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Image.asset(
          'assets/images/logo_negativo.png',
          height: sizes.width * 0.20,
          fit: BoxFit.scaleDown,
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              context.push('/home/1');
            },
            icon: const Icon(
              Icons.calendar_today_outlined,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              //Profile
              context.push('/home/3');
            },
            icon: const Icon(
              Icons.account_circle_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: CourseScenario(
        phases: phases,
        courseId: courseId,
      ),
        // body: Container(
        //   color: Colors.black,
        // )
    );
  }
}
