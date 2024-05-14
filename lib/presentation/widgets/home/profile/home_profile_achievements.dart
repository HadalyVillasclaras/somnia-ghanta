import 'package:flutter/material.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class HomeProfileAchievements extends StatelessWidget {
  const HomeProfileAchievements({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(Lang.of(context).home_profile_my_achievements,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: theme.onSurface,
                  )),
        ),

        //Lista de logros
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              Achievement(
                nombre: 'Logro 1',
                descripcion: 'Descripcion logro 1',
                imagen: 'assets/images/achievement.png',
              ),
              Achievement(
                nombre: 'Logro 2',
                descripcion: 'Descripcion logro 2',
                imagen: 'assets/images/achievement.png',
              ),
              Achievement(
                nombre: 'Logro 3',
                descripcion: 'Descripcion logro 3',
                imagen: 'assets/images/achievement.png',
              ),
              Achievement(
                nombre: 'Logro 4',
                descripcion: 'Descripcion logro 4',
                imagen: 'assets/images/achievement.png',
              ),
              Achievement(
                nombre: 'Logro 5',
                descripcion: 'Descripcion logro 5',
                imagen: 'assets/images/achievement.png',
              ),
            ],
          ),
        ),
      ],
    );
  }
}