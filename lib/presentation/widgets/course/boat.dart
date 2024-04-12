import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/_config.dart';
import 'package:ghanta/presentation/providers/ui_provider.dart';

class Boat extends ConsumerWidget {
  const Boat({super.key, required this.currentPosition});

  final int currentPosition;

  @override
  Widget build(BuildContext context, ref) {
    final tooltipsProvider = ref.watch(phasesTooltipsProvider);
    return AnimatedPositioned(
      //Calculamos la duracion de la animacion en base a la posicion actual si va de un punto mas lejano del 0 al 0.5
      duration: Duration(
          milliseconds: currentPosition == 0 ? 2000 : currentPosition * 800),
      left: currentPosition.isEven
          ? CourseEnviroment.horizontalEvenSeparation - 50
          : CourseEnviroment.horizontalOddSeparation - 50,
      top: currentPosition == 0
          ? 100
          : currentPosition * CourseEnviroment.verticalSeparation + 100 - 50,
      child: AnimatedRotation(
        duration: const Duration(milliseconds: 2000),
        turns: currentPosition.isOdd ? 0.5 : 0.6,
        child: InkWell(
          onTap: () {
            tooltipsProvider[currentPosition].showTooltip();
          },
          child: Image.asset('assets/course/personaje_V02.gif',
              height: 300, width: 350),
        ),
      ),
    );
  }
}
