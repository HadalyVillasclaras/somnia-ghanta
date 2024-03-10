import 'package:flutter/material.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';

class CourseCardShop extends StatelessWidget {
  const CourseCardShop({super.key, required this.course, required this.index});

  final Course course;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: index.isOdd ? const EdgeInsets.only(top: 20.0) : null,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(course.image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  course.getTitle(lang: Lang.getDeviceLang(context)),
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                //Boton para saber mas
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                )
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
