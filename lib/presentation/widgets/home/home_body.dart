import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class HomeBody extends ConsumerWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final sizes = MediaQuery.of(context).size;

    final List<Course> courses = ref.watch(coursesProvider);
    final isLoading = ref.watch(coursesProvider.notifier).isLoading;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Text(Lang.of(context).home_page_body_my_recent_courses,
                style: textTheme.headlineSmall!
                    .copyWith(color: colors.onBackground)),
            const SizedBox(height: 20.0),

            //Horizontal list of courses
            //For each course, we will create a CourseCard
            for (var course in courses) ...[
              if (course.phases.isNotEmpty) ...[
                FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: CourseCard(course: course)),
                const SizedBox(height: 20.0),
              ]
            ],

            if (courses.isEmpty && isLoading) ...[
              Shimmer(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.5),
                    Colors.grey.withOpacity(0.2)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                child: Container(
                  width: double.infinity,
                  height: sizes.height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey,
                  ),
                ),
              )
            ] else if (courses.isEmpty && !isLoading) ...[
              Text('No hay cursos disponibles',
                  style: textTheme.bodyMedium!
                      .copyWith(color: colors.onBackground)),
            ],

            SizedBox(
              height: sizes.height * 0.07,
            )
          ],
        ),
      ),
    );
  }
}

class CourseCard extends ConsumerWidget {
  const CourseCard({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context, ref) {
    final sizes = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => context.push('/course/${course.id}'),
      child: Container(
        width: double.infinity,
        height: sizes.height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: NetworkImage(course.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    Lang.of(context).course_card_phase(
                        course.currentPhase.toString(),
                        course.totalPhases.toString()),
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Text(
                course.getTitle(lang: Lang.getDeviceLang(context)),
                style: textTheme.headlineLarge!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10.0),
              Text(
                Lang.of(context).course_card_current_subphase,
                style: textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
              //Progress bar
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: course.currentSubphase! / course.totalSubphases!,
                      backgroundColor: Colors.white,
                      color: Colors.lightBlue,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    '${course.currentSubphase} / ${course.totalSubphases}',
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
