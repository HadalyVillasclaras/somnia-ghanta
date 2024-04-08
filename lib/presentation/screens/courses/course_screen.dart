import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/enviroment.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/domain/entities/phase.dart';
import 'package:ghanta/presentation/providers/courses_provider.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:ghanta/presentation/providers/new_courses_provider.dart';

class CourseScreen extends ConsumerWidget {
  const CourseScreen({Key? key, required this.courseId}) : super(key: key);

  final int courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

   
    final newCoursesState = ref.watch(newCoursesProvider);

    Course course;
    List<Phase> coursePhases = [];
    try {
      course = newCoursesState.courses.firstWhere((c) => c.id == courseId);
      coursePhases = course.phases ?? [];
    } catch (e) {
      print("No course found with id $courseId");
    }

    // final Course course = ref.watch(coursesProvider).firstWhere(
    //   (Course course) => course.id == courseId,
    // );

    // final sizes = MediaQuery.of(context).size;
    // final List<Phase> phases = course.phases ?? [];

    // final courseId = 0;
    return Scaffold(
      appBar: const NavigationTop(),
      extendBodyBehindAppBar: true,
      body: _buildBody(newCoursesState),
    );

    // return Scaffold(
    //   appBar: const NavigationTop(),
    //   extendBodyBehindAppBar: true,
    //   body: CourseScenario(
    //     phases: coursePhases,
    //     courseId: courseId,
    //   ),
        // body: Container(
        //   color: Colors.black,
        // )
    // );
  }

  
}

Widget _buildBody(NewCoursesState state) {
      print(state);
      return ListView.builder(
      itemCount: state.courses.length,
      itemBuilder: (context, index) {
        final course = state.courses[index];
        return ListTile(
          title: Text(course.titleEs),
        );
      },
    );
  }

