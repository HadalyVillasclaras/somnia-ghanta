import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/_config.dart';
import 'package:ghanta/domain/entities/phase.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/presentation/providers/ui_provider.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:super_tooltip/super_tooltip.dart';

class PhaseMapView extends ConsumerStatefulWidget {
  const PhaseMapView({
    super.key, 
    required this.phase,
    this.currentPhase = 0, 
  });
  final Phase phase;
  final int currentPhase;
  
  @override
  ConsumerState<PhaseMapView> createState() => _PhaseMapViewState();
}

class _PhaseMapViewState extends ConsumerState<PhaseMapView> {
  double screenSize = 0.0;
  late int currentPosition;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
      currentPosition = widget.currentPhase; //importante! la posición debe ser ser la currentSubphase no la currentPhase

      if (scrollController.hasClients && currentPosition != 0) {
        moveScreenScroll(currentPosition);
      }

    // WidgetsBinding.instance.addPostFrameCallback((_) {
      // Abri tooltip al entrar en screen
      // final phaseTooltips = ref.read(phasesTooltipsProvider);
      // final tooltipController = phaseTooltips[currentPosition];
      // tooltipController.showTooltip();
    // });
  }

  void moveScreenScroll(int i) {
    //inicial bounce animation
    scrollController.animateTo(CourseEnviroment.getVerticalSeparation(i) - 15,
      duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final subphases = widget.phase.subphases;
    screenSize = subphases.length.toDouble() * CourseEnviroment.verticalSeparation;

    final List<SuperTooltipController> tooltipControllers =
        List.generate(subphases.length, (index) => SuperTooltipController());

    ref.read(phasesTooltipsProvider).addAll(tooltipControllers);

    moveBoat(int i) {
      setState(() {
        currentPosition = i;
      });
    }

    onTapFlower(int i, {isAchieve}) {
      moveBoat(i);

      //Haremos scroll solo si el usuario no ha llegado a la última subfase
      if (i != subphases.length - 1) {
        moveScreenScroll(i);
      }

      if (!isAchieve) return;

      //Abrimos un modal de Logro
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final isLast = i == subphases.length - 1;
          return AchievModal(
            currentPosition: currentPosition,
            moveBoat: moveBoat,
            subphase: subphases[i],
            isLast: isLast);
        },
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: SingleChildScrollView(
          controller: scrollController,
          child: SizedBox(
            height: screenSize,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // por cada subfase creamos un nenufar
                ...subphases.asMap().entries.map((entry) {
                  final i = entry.key;
                  final subphase = entry.value;
                  double left = CourseEnviroment.getHorizontalSeparation(i); // Reducción de la separación horizontal
                  double top = CourseEnviroment.getVerticalSeparation(i) +  100; // Añado 100 para que no se oculte tras el título
                  return subphase.type == SubphaseType.normal
                  ? NormalLevel(
                      key: ValueKey(subphase.id),
                      subphase: subphase,
                      left: left,
                      course: widget.phase.courseId,
                      top: top,
                      index: i,
                      onTap: () => onTapFlower(i, isAchieve: false),
                    )
                  : AchieveLevel(
                      key: ValueKey(subphase.id),
                      subphase: subphase,
                      left: left,
                      top: top,
                      onTap: () {
                        onTapFlower(i, isAchieve: true);
                      });
                }).toList(),
                Boat(currentPosition: currentPosition),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
