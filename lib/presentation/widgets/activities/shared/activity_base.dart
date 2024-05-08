import 'package:flutter/material.dart';
import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:ghanta/presentation/widgets/activities/audio/audio_activity.dart';
import 'package:ghanta/presentation/widgets/activities/popup/popup_activity.dart';
import 'package:ghanta/presentation/widgets/activities/tinder/tinder_activity.dart';
import 'package:ghanta/presentation/widgets/activities/text/text_activity.dart';
import 'package:ghanta/presentation/widgets/activities/voice_recorder/voice_recorder_activity.dart';

class ActivityBase extends StatefulWidget {
  const ActivityBase({
    super.key,
    required this.subphase,
  });

  final Subphase subphase;

  @override
  State<ActivityBase> createState() => _ActivityBaseState();
}

class _ActivityBaseState extends State<ActivityBase> {
  final pageController = PageController();

  Widget _loadActivityWidget(PageController controller, Activity activity) {
    switch (activity.activityTypology) {
      case ActivityType.meditation:
        return MeditationActivity(
            pageController: controller, activity: activity);
      case ActivityType.audio:
        return AudioActivity(pageController: controller, activity: activity);
      case ActivityType.voiceRecorder:
        return VoiceRecorderActivity(
            pageController: controller, activity: activity);
      case ActivityType.tinder:
        return TinderActivity(pageController: controller, activity: activity);
      case ActivityType.popup:
        return PopupActivity(pageController: controller, activity: activity);
      case ActivityType.text:
        return TextActivity(pageController: controller, activity: activity);
      default:
        return Container();
    }
  }

  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    var activity = widget.subphase.activities.first;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(
                "assets/actividades/app_V02-06.jpg",
              ),
              fit: BoxFit.cover,
              colorFilter: isDarkMode
                  ? ColorFilter.mode(
                      const Color.fromARGB(255, 14, 0, 143).withOpacity(0.6),
                      BlendMode.darken)
                  : null,
            ),
          ),
        ),
        Container(
            height: MediaQuery.sizeOf(context).height * 0.20,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(222, 255, 246, 211),
                Color.fromARGB(0, 255, 255, 255)
              ],
              stops: [0, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ))
        ),

        //Título
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.11,
          left: 20,
          right: 20,
          child: Text(widget.subphase.getTitle(),
              style: Theme.of(context).textTheme.headlineSmall),
        ),

        //ACTIVITY WIDGET
        _loadActivityWidget(pageController, activity),

        //PAGINATION
        ActivityPagination(
          pageController: pageController,
          activity: activity,
          // activityType: ActivityType.popup,
        )
      ],
    );
  }
}
