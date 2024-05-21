import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/entities/phase.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';
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

    final currentPhase = currentCourse.currentPhase! - 1; //-1 para buscar en arrays
    final List<Phase> phases = currentCourse.phases;
    final phase = phases[currentPhase];

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
      // CourseScenarioHeader(
            //   phase: phases[_currentPhaseIndex],
            //   currentPhase: _currentPhaseIndex,
            // ),
    );
    }
}

// class PhaseMap extends StatelessWidget {
//   const PhaseMap({
//     super.key,
//     required this.currentPhase,
//     required this.phases,
//     required this.pageController,
//   });

//   final int currentPhase;
//   final List<Phase> phases;

//   @override
//   Widget build(BuildContext context) {
//     List<Subphase> allSubphases = phases.expand((phase) => phase.subphases).toList();
//     return Column(
//       children: [
//         PhaseMapView(subphases: allSubphases),
//       ],
//     );
//   }
// }

class CourseScenarioHeader extends StatelessWidget {
  const CourseScenarioHeader({
    super.key,
    required this.phase,
    required this.currentPhase,
  });

  final Phase phase;
  final int currentPhase;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 100, 
      child: Container(
        decoration: BoxDecoration(
          gradient:  LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.9),  
              Colors.white.withOpacity(0.6),  
              Colors.white.withOpacity(0),  
            ],
            stops: const [0.0, 0.5, 1.0], 
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 25, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(phase.getTitle(lang: Lang.getDeviceLang(context)), style: textTheme.headlineSmall!),
              Text('Fase ${currentPhase + 1}', style: textTheme.bodyMedium!),
            ],
          ),
        ),
      ),
    );
  }
}