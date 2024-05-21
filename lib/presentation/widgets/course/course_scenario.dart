import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/entities/phase.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/presentation/providers/courses_provider.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class CourseScenario extends ConsumerStatefulWidget {
  const CourseScenario({super.key, required this.courseId});

  final int courseId;

  @override
  CourseScenarioState createState() => CourseScenarioState();
}

class CourseScenarioState extends ConsumerState<CourseScenario> {
  late final PageController _pageController;
  int _currentPhaseIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      int newCurrentPhase = _pageController.page!.round();
      if (_currentPhaseIndex != newCurrentPhase) {
        setState(() {
          _currentPhaseIndex = newCurrentPhase;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coursesNotifier = ref.watch(coursesStateProvider.notifier);
    final currentCourse = coursesNotifier.getCourseById(widget.courseId);
    final List<Phase> phases = currentCourse.phases;

    List<Subphase> allSubphases = phases.expand((phase) => phase.subphases).toList();

    return SafeArea(
      bottom: false,
      child: Container(
          decoration:  const BoxDecoration(
          color:  Color.fromARGB(255, 125, 228, 223),
          image:  DecorationImage(
            image: AssetImage('assets/course/fondo.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: FadeInAnimation(
          child: PhaseMapView(subphases: allSubphases, currentCourse: currentCourse,)
        ),
      ),
    );
    }
}