import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/presentation/providers/ui_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:super_tooltip/super_tooltip.dart';

class NormalLevel extends ConsumerWidget {
  const NormalLevel({
    super.key,
    required this.index,
    required this.subphase,
    required this.left,
    required this.top,
    required this.onTap,
    required this.course,
  });

  final Subphase subphase;
  final double left;
  final double top;
  final VoidCallback onTap;
  final int course;
  final int index;

  @override
  Widget build(BuildContext context, ref) {
    final sizes = MediaQuery.of(context).size;
    final tooltipsProvider = ref.watch(phasesTooltipsProvider);

    // print(subphase.activities?.first.getIconByType());
    return Positioned(
      left: left,
      top: top,
      child: SuperTooltip(
        controller: tooltipsProvider[index],
        showCloseButton: ShowCloseButton.inside,
        closeButtonColor: Colors.black.withOpacity(0.2),
        closeButtonSize: 12,
        hasShadow: false,
        content: IntrinsicHeight(
          child: Container(
            height: sizes.height * 0.22,
              width: sizes.width * 0.6,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(  //Título subfase
                    subphase.titleEs,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column( //tiempo estimado
                        children: [
                          const Icon(Icons.timer_sharp),
                          Text(
                            '${subphase.estimatedTime}m',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                        // Column(
                        //   children: [
                        //     Text('subphase.activities.first.getIconByType()'),
                        //     Text(
                        //       'subphase.activities[0].titleEs',
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .bodyMedium!
                        //           .copyWith(color: Colors.black),
                        //     ),
                        //   ],
                        // ),
                     
                      Column(//actividad
                        children: [
                          const Icon(Icons.self_improvement),
                          Text(
                            'Meditar',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FilledButton.tonal(
                    onPressed: () {
                      tooltipsProvider[index].hideTooltip();
                      context.push('/course/$course/subphase/${subphase.id}');
                    },
                    //HAcemos que el boton ocupe todo el ancho
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(sizes.width * 0.6, 50)),
                    ),
                    child: const Text('Iniciar'),
                  ),
                ],
              )),
        ),
        //Quitamos el backdrop
        onShow: onTap,
        borderColor: Colors.transparent,
        borderRadius: 20,
        borderWidth: 0,
        popupDirection: TooltipDirection.up,
        hideTooltipOnTap: true,
        barrierColor: Colors.black.withOpacity(0.2),
        child: Image.asset(
          subphase.type == SubphaseType.normal
              ? 'assets/course/hojas.png'
              : 'assets/course/flor.png',
          height: sizes.height * 0.16,
          width: sizes.height * 0.16,
        ),
      ),
    );
  }
}
