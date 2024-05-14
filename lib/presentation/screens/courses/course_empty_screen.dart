import 'package:flutter/material.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
class CourseEmptyScreen extends StatelessWidget {
  const CourseEmptyScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const NavigationTop(),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/course/fondo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: PageView(children: [
                    Text('No hay cursos disponibles.',
                        style: textTheme.headlineSmall!)
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
