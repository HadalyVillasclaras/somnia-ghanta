import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/enviroment.dart';
import 'package:ghanta/presentation/providers/auth/auth_provider.dart';
import 'package:ghanta/presentation/providers/courses_provider.dart';
import 'package:ghanta/presentation/providers/feedback_provider.dart';
import 'package:ghanta/presentation/widgets/home/home_body.dart';
import 'package:ghanta/presentation/widgets/home/home_header.dart';
import 'package:go_router/go_router.dart';
class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool showHeader = true;

  @override
  void initState() {
    super.initState();
    ref.read(coursesProvider.notifier).getUserCourses(Environment.apiToken);
    ref.read(feedbackProvider.notifier).getUserFeedback(Environment.apiToken);

  }

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    final controller = ScrollController();
    final courses = ref.watch(coursesProvider);
    controller.addListener(() {
      if (controller.offset > controller.position.maxScrollExtent - (sizes.height * 0.05) &&
          !controller.position.outOfRange  && controller.position.userScrollDirection == ScrollDirection.reverse
          ) {
        if (showHeader) {
          setState(() {
            showHeader = false;
          });
        }
      } else {
        if (!showHeader) {
          setState(() {
            showHeader = true;
          });
        }
      }
    });


    return CustomScrollView(
      physics:   //Buscamos la cantidad de cursos que tienen fases 
      courses.where((course) => course.phases.isNotEmpty).length >= 2
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      controller: controller,
      slivers: [
        SliverAppBar(
          backgroundColor: const Color(0xF09E0A56),
          expandedHeight: sizes.height * 0.4,
          foregroundColor: Colors.pink,
          //Quitar padding de la appbar
          toolbarHeight: 10,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            //Hacemos un fade del home header
            background: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: showHeader ? 1 : 0,
                child: const HomeHeader()),
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: showHeader ? 1 : 0,
              child: Image.asset(
                'assets/images/meditation.png',
                width: sizes.width * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        SliverList(
          delegate: SliverChildListDelegate(
            [const HomeBody()],
          ),

        ),
        SliverToBoxAdapter(
      // Use SliverToBoxAdapter to add a single widget, in this case, a Text widget
      child: Container(
        alignment: Alignment.center, // Center the text horizontally
        child: TextButton(
              onPressed: () {
                ref.read(authProvider.notifier).logout(errorMessage: '¡Hasta pronto!');
                Future.microtask(() => context.go('/login'));
              },
              child: const Text('Log-out'),
            ),
      ),
    ),
      ],
    );
  }
}
