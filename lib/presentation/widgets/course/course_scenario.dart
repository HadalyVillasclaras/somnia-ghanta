import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/entities/phase.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';
import 'package:ghanta/presentation/providers/new_courses_provider.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';

class CourseScenario extends ConsumerWidget {
  const CourseScenario({
    super.key,
    required this.phases,
    required this.courseId,
  });

  final List<Phase> phases;
  final int courseId;

  @override
  Widget build(BuildContext context, ref) {
    final textTheme = Theme.of(context).textTheme;
    final currentCourse = ref.watch(coursesStateProvider.notifier).getCourseById(courseId);
    final currentPhase = currentCourse.currentPhase! - 1;

    final phase = phases[currentPhase];
return SafeArea(
  bottom: false,
  child: Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/course/fondo.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Stack(
      children: [
        Positioned(
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
        ),
        Column(
          children: [
            Expanded(
              child: PageView(
                scrollDirection: Axis.vertical,
                // Set the current page
                controller: PageController(initialPage: currentPhase),
                children: [
                  // Por cada fase mostramos un container con el title_es
                  for (var i = 0; i < phases.length; i++) 
                    PhaseMapView(phase: phases[i])
                ]
              ),
            ),
          ],
        ),
        
      ],
    ),
  ),
);
  }
}


          // AppBar(
          //   surfaceTintColor: Colors.transparent,
          //   automaticallyImplyLeading: false,
          //   toolbarHeight: kToolbarHeight + 30,
          //   title: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const SizedBox(height: 20),
          //       Text(phase.getTitle(lang: Lang.getDeviceLang(context)),
          //         style: textTheme.headlineSmall!),
          //       Text('Fase ${currentPhase + 1}',
          //           style: textTheme.bodyMedium!),
          //       const SizedBox(height: 20),
          //     ],
          //   ),
          //   backgroundColor: Colors.white.withOpacity(0.2),
          //   centerTitle: false,
          // ),