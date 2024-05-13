import 'package:flutter/material.dart';
import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:go_router/go_router.dart';

class ActivityEndButton extends StatelessWidget {
  const ActivityEndButton({
    super.key,
    required this.isVisible,
    this.activity,
  });

  final bool isVisible;
  final Activity? activity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Visibility(
        visible: isVisible,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.fromLTRB(15, 1, 0, 1)),
              onPressed: () {
                if (activity!.activityTypology == ActivityType.meditation) {
                  context.push('/feedback/${activity!.id}');
                  //context.go('/course/${notEmptyCourse!.id}');
                } else {
                 Navigator.pop(context);
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Finalizar'),
                  SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right,
                    size: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
