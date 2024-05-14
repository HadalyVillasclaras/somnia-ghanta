import 'package:flutter/material.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class HomeCoursesList extends StatelessWidget {
  const HomeCoursesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final List<Course> courses = Course.getCourses();
    final List<Course> courses = [];
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(Lang.of(context).home_store_available_courses,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      )),

                      //Filter button
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
              ),
            ],
          ),

          //Hacemos un grid de 2 columnas
          const SizedBox(height: 20.0),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: courses.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
            ),
            itemBuilder: (context, index) {
              return CourseCardShop(
                course: courses[index],
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }
}