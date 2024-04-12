import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/colors_theme.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:ghanta/presentation/widgets/activities/audio/audio_activity.dart';
import 'package:ghanta/presentation/widgets/activities/draggable/draggable_activity.dart';
import 'package:ghanta/presentation/widgets/activities/popup/popup_activity.dart';
import 'package:ghanta/presentation/widgets/activities/shared/activity_base.dart';
import 'package:ghanta/presentation/widgets/activities/tinder/tinder_activity.dart';

class SubphaseScreen extends ConsumerWidget {
  const SubphaseScreen(
      {Key? key,
      required this.subphaseId,
      required this.courseId,
      required this.phaseId})
      : super(key: key);
  final int subphaseId;
  final int courseId;
  final int phaseId;

  Widget _loadActivityWidget(PageController controller, ActivityType type) {
    switch (type) {
      case ActivityType.meditation:
        return MeditationActivity(pageController: controller);
      case ActivityType.audio:
        return AudioActivity(pageController: controller);
      case ActivityType.tinder:
        return TinderActivity(pageController: controller);
      case ActivityType.popup:
        return PopupActivity(pageController: controller);
      case ActivityType.draggable:
        return const DraggableActivity();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final pageController = PageController();
    final Subphase subphase = ref
        .watch(coursesProvider.notifier)
        .getSubphase(courseId, phaseId, subphaseId);
    return WillPopScope(
      onWillPop: () async {
        //Mostramos dialogo de confirmacion
        return false;
      },
      child: Scaffold(
          //Cambiamos el color de la barra de estado
          backgroundColor: theme.primary,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () {
                    //Mostramos dialogo de confirmacion
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('¿Estás seguro?'),
                          content: const Text(
                              'Si sales ahora, perderás todo tu progreso en esta fase.'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('Salir')),
                          ],
                        );
                      },
                    );
                  },
                  iconSize: 30,
                  color: ColorsTheme.primaryColorBlue,
                  icon: const Icon(Icons.close))
            ],
          ),
          body: ActivityBase(
              subphase: subphase,
              pageController: pageController,
              child: _loadActivityWidget(pageController, subphase.activities.first.activityTypology))),
              // child: _loadActivityWidget(pageController, ActivityType.meditation))),






      // child: _loadActivityWidget(
      //     pageController, subphase.activities.first.activityType))),
    );
  }
}
