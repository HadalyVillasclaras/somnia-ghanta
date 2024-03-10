import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:ghanta/presentation/providers/ui_provider.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class AchievModal extends ConsumerWidget {
  const AchievModal({
    super.key,
    required this.currentPosition, required this.moveBoat, required this.isLast,
    required this.subphase,
  });

  final int currentPosition;
  final Function(int) moveBoat;
  final bool isLast;
  final Subphase subphase;

  @override
  Widget build(BuildContext context, ref) {

    final sizes = MediaQuery.sizeOf(context);
    final authProv = ref.watch(authProvider);
    return Center(
      child: IntrinsicHeight(
        child: Container(
          width: sizes.width * 0.9,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: ConfettiWidget(
            confettiController: ConfettiController(
              duration: const Duration(seconds: 3),
            )..stop(),
            blastDirectionality: BlastDirectionality.explosive,
            particleDrag: 0.05,
            emissionFrequency: 0.05,
            numberOfParticles: 30,
            gravity: 0.05,
            shouldLoop: false,
            //Que salgan desde el centro
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('¡Felicidades ${authProv.user!.name}!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.black)),
                const SizedBox(height: 20),
                Text(subphase.getTitle(lang: Lang.getDeviceLang(context)),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black)),
                const SizedBox(height: 20),
                 Achievement(nombre: 'La ecuanimidad', descripcion: '', imagen: '', size: sizes.height * 0.1,),
                const SizedBox(height: 20),
                FilledButton.tonal(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (isLast) return;
                    moveBoat(currentPosition + 1);
                    ref.read(phasesTooltipsProvider)[currentPosition + 1]
                        .showTooltip();
                    
                  },
                  child: const Text('Aceptar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
