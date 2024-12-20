import 'package:flutter/material.dart';
import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:ghanta/presentation/widgets/activities/shared/activity_audio_player.dart';

class MeditationActivity extends StatelessWidget {
  const MeditationActivity(
      {super.key, required this.pageController, required this.activity, required this.pageIndexNotifier,});

  final PageController pageController;
  final Activity activity;
 final ValueNotifier<int> pageIndexNotifier;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
       onPageChanged: (index) {
        pageIndexNotifier.value = index;
      },
      children: [
        ActivityIntroText(text: activity.descriptionEs),
        const MeditationActivityStepOne(),
        const MeditationActivityStepTwo(),
        const MeditationActivityStepThree(),
        const MeditationActivityStepFour(),
        ActivityAudioPlayer(
          pageController: pageController,
          activity: activity
        )
      ],
    );
  }
}

class MeditationActivityStepOne extends StatelessWidget {
  const MeditationActivityStepOne({super.key});
  @override
  Widget build(BuildContext context) {
    return ActivityBody(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.4),
        const ActivityTextBody(
            'Apaga todas las distracciones, como las notificaciones de tu dispositivo.'),
        const SizedBox(
          height: 25,
        ),
        const CircleIconActivity(iconData: Icons.power_settings_new)
      ],
    );
  }
}

class MeditationActivityStepTwo extends StatelessWidget {
  const MeditationActivityStepTwo({super.key});
  @override
  Widget build(BuildContext context) {
    return ActivityBody(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.4),
        RichText(
          softWrap: true,
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
            children: const <TextSpan>[
              TextSpan(text: 'Tómate un momento para '),
              TextSpan(
                text: 'INHALAR PROFUNDAMENTE',
                style: TextStyle(color: Colors.red),
              ),
              TextSpan(
                text:
                    ' y exhalar suavamente, sintiendo como tu cuerpo se relaja con cada respiración.',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

class CircleIconActivity extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;

  const CircleIconActivity({
    Key? key,
    required this.iconData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      radius: 35,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}

class MeditationActivityStepThree extends StatelessWidget {
  const MeditationActivityStepThree({super.key});
  @override
  Widget build(BuildContext context) {
    return ActivityBody(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.4),
        const ActivityTextBody(
          'Crea un ambiente lumímico agradable, utilizando una luz tenue o velas.',
        ),
        const SizedBox(
          height: 20,
        ),
        const CircleIconActivity(iconData: Icons.lightbulb),
      ],
    );
  }
}

class MeditationActivityStepFour extends StatelessWidget {
  const MeditationActivityStepFour({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityBody(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.4),
        const ActivityTextBody(
          'Estate presente en el aquí y el ahora. ¡Disfruta de este tiempo de dedicado a ti y a tu bienestar persona!',
        ),
        const SizedBox(
          height: 20,
        ),
        CircleIconActivity(
          iconData: Icons.favorite,
          onPressed: () {
          },
        ),
      ],
    );
  }
}
