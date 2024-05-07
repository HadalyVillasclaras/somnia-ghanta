import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ghanta/config/constants/colors_theme.dart';

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
        ActivityIntroText(
            text:
                'Duis a lacus convallis, sagittis erat nec, lobortis urna. Fusce ac risus malesuada, consectetur magna et, scelerisque felis. Phasellus laoreet scelerisque facilisis. Duis luctus sollicitudin semper. Aenean viverra enim eget enim euismod, vitae aliquet libero semper.'),
        MeditationActivityStepOne(),
        MeditationActivityStepTwo(),
        MeditationActivityStepThree(),
        MeditationActivityStepFour(),
        MeditationActivityStepFive()
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
          softWrap:true,
              textAlign:TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary), 
            children: const <TextSpan>[
              TextSpan(text: 'Tómate un momento para '),
              TextSpan(
                text: 'INHALAR PROFUNDAMENTE',
                style:
                    TextStyle(color: Colors.red),
              ),
              TextSpan(
                text:' y exhalar suavamente, sintiendo como tu cuerpo se relaja con cada respiración.',
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
            context.push('/feedback');
          },
        ),
      ],
    );
  }
}

class MeditationActivityStepFive extends StatelessWidget {
  const MeditationActivityStepFive({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityBody(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.45),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("00:00"),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey[300],
                ),
                child: Slider(
                  value: 70,
                  max: 155,
                  onChanged: (value) {},
                ),
              ),
            ),
            const Text("02:35"),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: () {},
            ),
            const SizedBox(
              width: 25,
            ),
            CircleIconActivity(
              iconData: Icons.play_arrow_rounded,
              onPressed: () {},
            ),
            const SizedBox(
              width: 25,
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
