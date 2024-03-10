import 'package:flutter/material.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class HomeCoursesView extends StatelessWidget {
  const HomeCoursesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: HomeCoursesSearch(),
            ),
            SizedBox(height: 10.0),
            HomeCoursesCategories(),
            SizedBox(height: 10.0),
            HomeCoursesList()
          ],
        ),
      ),
    ));
  }
}





