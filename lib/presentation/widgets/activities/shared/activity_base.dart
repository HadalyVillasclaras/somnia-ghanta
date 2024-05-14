import 'package:flutter/material.dart';
import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

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
  final ValueNotifier<int> pageIndexNotifier = ValueNotifier<int>(0);

   Widget _loadActivityWidget(PageController controller, Activity activity, ValueNotifier<int> pageIndexNotifier) {
    switch (activity.activityTypology) {
      case ActivityType.meditation:
        return MeditationActivity(pageController: controller, activity: activity, pageIndexNotifier: pageIndexNotifier);
      case ActivityType.audio:
        return AudioActivity(pageController: controller, activity: activity);
      case ActivityType.voiceRecorder:
        return VoiceRecorderActivity(pageController: controller, activity: activity);
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

 @override
  void dispose() {
    pageController.dispose();
    pageIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var activity = widget.subphase.activities.first;

    return Stack(
      children: [
        //Background image / filter
        _buildBackground(activity.activityTypology),

        //Gradient top
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
            ))),

        //Título
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.11,
          left: 20,
          right: 20,
          child: Text(widget.subphase.getTitle(),
              style: Theme.of(context).textTheme.headlineSmall),
        ),

        //ACTIVITY WIDGET
        _loadActivityWidget(pageController, activity, pageIndexNotifier),

        //PAGINATION
        ActivityPagination(
          pageController: pageController,
          activity: activity,
        )
      ],
    );
  }

   Widget _buildBackground(ActivityType activityTypology) {
    if (activityTypology == ActivityType.meditation) {
      return ValueListenableBuilder<int>(
        valueListenable: pageIndexNotifier,
        builder: (context, pageIndex, child) {
          return TweenAnimationBuilder<Color?>(
            tween: ColorTween(
              begin: Colors.transparent,
              end: (pageIndex == 3 || pageIndex == 4 || pageIndex == 5)
                  ? const Color.fromARGB(255, 0, 44, 105).withOpacity(0.6)
                  : Colors.transparent,
            ),
            duration: const Duration(milliseconds: 500),
            builder: (context, color, child) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(
                      "assets/actividades/app_V02-06.jpg",
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      color ?? Colors.transparent,
                      BlendMode.darken,
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/actividades/app_V02-06.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}