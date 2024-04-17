import 'package:flutter/material.dart';
import 'package:ghanta/config/constants/colors_theme.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/presentation/widgets/activities/shared/activity_indicator.dart';

class ActivityBase extends StatefulWidget {
  const ActivityBase({
    super.key,
    required this.child,
    required this.pageController,
    required this.subphase,
  });

  final Widget child;
  final PageController pageController;
  final Subphase subphase;

  @override
  State<ActivityBase> createState() => _ActivityBaseState();
}

class _ActivityBaseState extends State<ActivityBase> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
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
                      Colors.black.withOpacity(0.5), BlendMode.srcOver)
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
            ))),

        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.10,
          left: 20,
          child: Text(widget.subphase.getTitle(),
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w900,
                  color: ColorsTheme.primaryColorBlue)),
        ),

        //Ponemos el child
        widget.child,
        ActivityIndicator(
          pageController: widget.pageController,
          // activityType: widget.subphase.activities[0].activityTypology,
          activityType: ActivityType.meditation,
          // activityType: ActivityType.popup,
        )
      ],
    );
  }
}
