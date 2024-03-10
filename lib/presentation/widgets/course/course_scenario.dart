import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/entities/phase.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';
import 'package:ghanta/presentation/providers/courses_provider.dart';
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
    final colors = Theme.of(context).colorScheme;
    final currentPhase = ref.watch(coursesProvider.notifier).getCourseById(courseId).currentPhase! - 1;
    // final currentPhase = ref.watch(coursesProvider.notifier).getCourseById(courseId).currentPhase!;

    final phase = phases[currentPhase];

    return Container(
      //Background Image
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/course/fondo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          AppBar(
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            toolbarHeight: kToolbarHeight + 30,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(phase.getTitle(lang: Lang.getDeviceLang(context)),
                    style: textTheme.headlineSmall!
                        .copyWith(color: colors.primaryContainer)),
                const SizedBox(height: 10),
                Text('Fase ${currentPhase + 1}',
                    style: textTheme.titleMedium!
                        .copyWith(color: colors.primaryContainer)),
                const SizedBox(height: 10),
              ],
            ),
            backgroundColor: Colors.black.withOpacity(0.2),
            centerTitle: false,
          ),
          Expanded(
            child: PageView(
                scrollDirection: Axis.vertical,
                //Set the current page
                controller: PageController(initialPage: currentPhase),
                children: [
                  //Por cada fase mostramos un container con el title_es
                  for (var i = 0; i < phases.length; i++)
                    PhaseMapView(phase: phases[i])
                    // Placeholder()
                ]),
          ),
        ],
      ),
    );
  }
}
