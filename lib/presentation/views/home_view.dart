import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/new_courses_provider.dart';
import 'package:ghanta/presentation/widgets/home/home_body.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    final controller = ScrollController();
    final coursesAsyncValue = ref.watch(getCoursesProvider);

    return coursesAsyncValue.when(
      data: (courses) {
        return CustomScrollView(
          physics: courses.where((course) => course.phases.isNotEmpty).length >= 2
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          controller: controller,
          slivers: [
            SliverAppBar(
              expandedHeight: sizes.height * 0.4,
              toolbarHeight: 10,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: const Color.fromARGB(255, 22, 130, 130),
                ),
                title: const Text('Home view'),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                 [HomeBody(courses: courses)],
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(),),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
    );
  }
}