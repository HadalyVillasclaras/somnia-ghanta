import 'package:flutter/material.dart';

class HomeCoursesCategories extends StatelessWidget {
  const HomeCoursesCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          HomeCoursesCategory(
            title: 'Meditación',
            color: Theme.of(context).colorScheme.primary,
            icon: Icons.self_improvement,
          ),
          HomeCoursesCategory(
            title: 'Yoga',
            color: Theme.of(context).colorScheme.secondary,
            icon: Icons.spa,
          ),
          HomeCoursesCategory(
            title: 'Pilates',
            color: Theme.of(context).colorScheme.primary,
            icon: Icons.sports_volleyball,
          ),
          HomeCoursesCategory(
            title: 'Tai Chi',
            color: Theme.of(context).colorScheme.secondary,
            icon: Icons.sports_kabaddi,
    
          ),
        ],
      ),
    );
  }
}

class HomeCoursesCategory extends StatelessWidget {
  const HomeCoursesCategory(
      {super.key, required this.title, required this.color, required this.icon});
  final String title;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    //pills
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      width: 100.0,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 40.0),
          const SizedBox(height: 10.0),
          Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

