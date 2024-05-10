import 'package:flutter/material.dart';
import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:ghanta/presentation/widgets/activities/shared/activity_audio_player.dart';

class AudioActivity extends StatelessWidget {
  const AudioActivity(
      {super.key, required this.pageController, required this.activity});

  final PageController pageController;
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        ActivityIntroText(text: activity.descriptionEs),
        ActivityAudioPlayer(
          pageController: pageController,
          activity: activity,
        ),
      ],
    );
  }
}