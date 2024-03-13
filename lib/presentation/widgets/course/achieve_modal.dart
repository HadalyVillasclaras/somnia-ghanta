import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:ghanta/presentation/providers/ui_provider.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class AchievModal extends ConsumerWidget {
  const AchievModal({
    super.key,
    required this.currentPosition,
    required this.moveBoat,
    required this.isLast,
    required this.subphase,
  });

  final int currentPosition;
  final Function(int) moveBoat;
  final bool isLast;
  final Subphase subphase;

  @override
  Widget build(BuildContext context, ref) {
    final authProv = ref.watch(authProvider);
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Making the dialog content take only the space it needs
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 40,
              child: Icon(
                Icons.circle,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
            ),
            const SizedBox(height: 20),
            Text('¡Felicidades\n${authProv.user!.name}!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 20),
            Text(
                'Has logrado\n${subphase.getTitle(lang: Lang.getDeviceLang(context))}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (isLast) return;
                  moveBoat(currentPosition + 1);
                  ref
                      .read(phasesTooltipsProvider)[currentPosition + 1]
                      .showTooltip();
                },
                child: const Text('Aceptar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
