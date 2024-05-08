import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/entities/activity.dart';
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
      
    final Activity? firstActivity = subphase.activities.isNotEmpty ? subphase.activities[0] : null;
    final String firstActivityTitle = firstActivity?.titleEs ?? "Sin actividad";
    final Widget activityIcon = firstActivity?.getIconByType() ?? const Icon(Icons.block);

    bool areUrlParamsValid = course != null && subphase.phaseId != null && subphase.id != null &&
                   course > 0 && subphase.phaseId > 0 && subphase.id > 0;

    return Positioned(
      left: left,
      top: top,
      child: SuperTooltip(
        controller: tooltipsProvider[index],
        // showCloseButton: ShowCloseButton.inside,
        // closeButtonSize: 12,
        hasShadow: false,
        content: IntrinsicHeight(
          child: Container(
              height: sizes.height * 0.22,
              width: sizes.width * 0.6,
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(  //Título subfase
                    'Título subfase: ${subphase.titleEs}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall!
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column( //tiempo estimado
                        children: [
                          const Icon(Icons.timer_sharp),
                          Text(
                            '${subphase.estimatedTime}m',
                            style: Theme.of(context).textTheme.bodySmall!
                          ),
                        ],
                      ),
                      Column(//actividad
                        children: [
                          activityIcon,
                          Text(
                            firstActivityTitle,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox( height: 5,),
                  FilledButton.tonal(
                    onPressed: areUrlParamsValid ? () {
                      tooltipsProvider[index].hideTooltip();
                      context.push('/course/$course/phase/${subphase.phaseId}/subphase/${subphase.id}');
                    } : null,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all( Size(sizes.width * 0.6, 50)),
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
