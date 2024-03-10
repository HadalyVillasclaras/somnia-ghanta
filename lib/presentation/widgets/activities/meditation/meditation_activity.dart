import 'package:flutter/material.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:go_router/go_router.dart';

class MeditationActivity extends StatelessWidget {
  const MeditationActivity({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        MeditationActivityStepOne(),
        MeditationActivityStepTwo(),
        MeditationActivityStepThree(),
        MeditationActivityStepFour(),
      ],
    );
  }
}

class MeditationActivityStepOne extends StatelessWidget {
  const MeditationActivityStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityBody(
      child: Column(
        children: [
          ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.9),
              child: const ActivityTextBody(
                  'Apaga todas las distracciones, como las notificaciones de tu dispositivo.')),
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 17, 36, 66),
            radius: 40,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.power_settings_new,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MeditationActivityStepTwo extends StatelessWidget {
  const MeditationActivityStepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityBody(
        child: Column(
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.9),
            child: const ActivityTextBody(
              'Tómate un momento para INHALAR PROFUNDAMENTE y exhalar suavamente, sintiendo como tu cuerpo se relaja con cada respiración.',
            )),
        const SizedBox(
          height: 20,
        ),
        CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 17, 36, 66),
          radius: 40,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ],
    ));
  }
}

class MeditationActivityStepThree extends StatelessWidget {
  const MeditationActivityStepThree({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityBody(
        child: Column(
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.9),
            child: const ActivityTextBody(
              'Crea un ambiente lumímico agradable, utilizando una luz tenue o velas.',
            )),
        const SizedBox(
          height: 20,
        ),
        CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 17, 36, 66),
          radius: 40,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.lightbulb,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ],
    ));
  }
}

class MeditationActivityStepFour extends StatelessWidget {
  const MeditationActivityStepFour({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityBody(
        child: Column(
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.9),
            child: const ActivityTextBody(
              'Estate presente en el aquí y el ahora. ¡Disfruta de este tiempo de dedicado a ti y a tu bienestar persona!',
            )),
        const SizedBox(
          height: 20,
        ),
        CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 17, 36, 66),
          radius: 40,
          child: IconButton(
            onPressed: () {
              context.push('/feedback');
            },
            icon: const Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ],
    ));
  }
}
