import 'package:flutter/material.dart';

class ActivityEndButton extends StatelessWidget {
  const ActivityEndButton({
    super.key,
    required this.isVisible,
  });

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.background,
                foregroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.fromLTRB(15, 2, 0, 2)),
            onPressed: () {
               Navigator.pop(context);
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
    );
  }
}
