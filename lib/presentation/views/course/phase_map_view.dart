import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/_config.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/domain/entities/phase.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/presentation/providers/ui_provider.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:super_tooltip/super_tooltip.dart';

class PhaseMapView extends ConsumerStatefulWidget {
  const PhaseMapView({
    super.key,
    required this.currentCourse,
    required this.subphases,
  });
  final Course currentCourse;
  final List<Subphase> subphases;

  @override
  ConsumerState<PhaseMapView> createState() => _PhaseMapViewState();
}

class _PhaseMapViewState extends ConsumerState<PhaseMapView> {
  double screenSize = 0.0;
  late int currentPosition;
  ScrollController scrollController = ScrollController();
  List<GlobalKey> keys = [];
  List<bool> hasBeenLogged = [];
  List<Phase> phases = [];
  Phase? currentPhase;

  @override
  void initState() {
    super.initState();
    phases = widget.currentCourse.phases;
    currentPhase = phases[widget.currentCourse.currentPhase! - 1]; 

    keys = List<GlobalKey>.generate(
        widget.subphases.length, (index) => GlobalKey());
    hasBeenLogged = List<bool>.filled(widget.subphases.length, false);

    currentPosition = widget.currentCourse.currentPhase! -
        1; //importante! la posición debe ser ser la currentSubphase no la currentPhase
    if (scrollController.hasClients && currentPosition != 0) {
      moveScreenScroll(currentPosition);
    }
  }

  bool isWidgetVisible(double top) {
    double viewportHeight = MediaQuery.of(context).size.height;
    double currentScroll = scrollController.offset;
    return (top < currentScroll + viewportHeight && top > currentScroll);
  }

  void setCurrentPhaseOnView() {
    for (int i = 0; i < widget.subphases.length; i++) {
      double top = CourseEnviroment.getVerticalSeparation(i) + 330;
      bool isVisible = isWidgetVisible(top);
      if (isVisible && !hasBeenLogged[i]) {
        final GlobalKey key = keys[i];
        final RenderBox box =
            key.currentContext?.findRenderObject() as RenderBox;
        // ignore: unnecessary_null_comparison
        if (box != null) {
          final subphase = widget.subphases[i];
          hasBeenLogged[i] = true;
          setState(() {
            currentPhase = phases.firstWhere((p) => p.id == subphase.phaseId);
          });
        }
      } else if (!isVisible && hasBeenLogged[i]) {
        hasBeenLogged[i] = false;
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void moveScreenScroll(int i) {
    //inicial bounce animation
    scrollController.animateTo(CourseEnviroment.getVerticalSeparation(i) - 15,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final subphases = widget.subphases;

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
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          currentPhase = phases.firstWhere((p) => p.id == widget.subphases[i].phaseId);
        });
      });

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

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollUpdateNotification ||
            scrollNotification is ScrollEndNotification) {
          setCurrentPhaseOnView();
        }
        return true;
      },
      child: Stack(children: [
        SingleChildScrollView(
          controller: scrollController,
          child: SizedBox(
            height: screenSize,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ...subphases.asMap().entries.map((entry) {
                  final i = entry.key;
                  final subphase = entry.value;
                  double left = CourseEnviroment.getHorizontalSeparation(
                      i); // Reducción de la separación horizontal
                  double top = CourseEnviroment.getVerticalSeparation(i) + 100;
                  return Positioned(
                    key: keys[i],
                    top: top,
                    left: left,
                    child: subphase.type == SubphaseType.normal
                    ? NormalLevel(
                      key: ValueKey(subphase.id),
                      subphase: subphase,
                      course: subphase.courseId!,
                      index: i,
                      onTap: () => onTapFlower(i, isAchieve: false),
                    )
                    : AchieveLevel(
                      key: ValueKey(subphase.id),
                      subphase: subphase,
                      onTap: () {
                        onTapFlower(i, isAchieve: true);
                      }
                    )
                  );
                }).toList(),
                Boat(currentPosition: currentPosition),
              ],
            ),
          ),
        ),
        CourseScenarioHeader(currentPhase: currentPhase!)
      ]),
    );
  }
}

class CourseScenarioHeader extends StatelessWidget {
  const CourseScenarioHeader({
    super.key,
    required this.currentPhase,
  });

  final Phase currentPhase;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.9),
              Colors.white.withOpacity(0.6),
              Colors.white.withOpacity(0),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(currentPhase.titleEs, style: textTheme.headlineSmall!),
              Text('Fase ${currentPhase.order}', style: textTheme.bodyMedium!),
            ],
          ),
        ),
      ),
    );
  }
}
