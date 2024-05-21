import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:ghanta/config/constants/colors_theme.dart';
import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:ghanta/presentation/widgets/activities/shared/activity_end_button.dart';

class TinderActivity extends StatefulWidget {
  const TinderActivity(
      {super.key, required this.pageController, required this.activity});

  final PageController pageController;
  final Activity activity;

  @override
  State<TinderActivity> createState() => _TinderActivityState();
}

class _TinderActivityState extends State<TinderActivity> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          if (widget.pageController.page! > 0) {
            widget.pageController.previousPage(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          }
        } else if (details.delta.dx < 0) {
          if (widget.pageController.page! < 1) {
            widget.pageController.nextPage(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          }
        }
      },
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: widget.pageController,
        children: [
          ActivityIntroText(text: widget.activity.descriptionEs),
          TinderActivityStepOne(
              activity: widget.activity, pageController: widget.pageController)
        ],
      ),
    );
  }
}

class TinderActivityStepOne extends StatefulWidget {
  const TinderActivityStepOne(
      {super.key, required this.activity, required this.pageController});

  final Activity activity;
  final PageController pageController;

  @override
  State<TinderActivityStepOne> createState() => _TinderActivityStepOneState();
}

class _TinderActivityStepOneState extends State<TinderActivityStepOne> {
  bool heartIsSelected = false;
  bool crossIsSelected = false;
  bool isEndButtonVisible = false;
  bool isCardBlocked = false;

  late AppinioSwiperController swiperController;
  ScrollHoldController? holdController;

  @override
  void initState() {
    super.initState();
    swiperController = AppinioSwiperController();
  }

  @override
  void dispose() {
    swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tinderData = widget.activity.tinderData;
    final totalCards = tinderData!.length;

    return ActivityBody(children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          ActionButton(
            isSelected: heartIsSelected,
            icon: Icons.favorite,
            position: Alignment.centerRight,
            color: Colors.red,
          ),
          ActionButton(
            isSelected: crossIsSelected,
            icon: Icons.clear,
            position: Alignment.centerLeft,
            color: ColorsTheme.primaryColorBlue,
          ),
          //CARD
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.25,
            width: MediaQuery.sizeOf(context).width * 0.70,
            child: AppinioSwiper(
              loop: false,
              isDisabled: isCardBlocked,
              controller: swiperController,
              swipeOptions:
                  const SwipeOptions.only(left: true, right: true),
              onSwipeBegin: (previousIndex, targetIndex, activity) {
                if (activity.direction == AxisDirection.left) {
                  setState(() {
                    crossIsSelected = true;
                  });
                } else if (activity.direction == AxisDirection.right) {
                  setState(() {
                    heartIsSelected = true;
                  });
                }
              },
              onSwipeEnd: (previousIndex, targetIndex, activity) {
                setState(() {
                  heartIsSelected = false;
                  crossIsSelected = false;

                  if (targetIndex == totalCards) {
                    isEndButtonVisible = true;
                    isCardBlocked = true;
                  }
                });
                if (previousIndex != targetIndex &&
                    targetIndex != totalCards + 1) {
                  //dont trigger before the swipe is completed
                  int adjustedIndex = (targetIndex - 1) %
                      tinderData
                          .length; //targetIndex starts in 1. when reaching total lenght, it starts from 0 again.

                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => TinderActivityPopUp(
                          popupText:
                              tinderData[adjustedIndex].popupTextEs));
                }
              },
              backgroundCardOffset: const Offset(0, 0),
              cardBuilder: (context, index) {
                if (index == totalCards) {
                  return const LastTinderActivityCard();
                } else {
                  return TinderActivityCard(
                    currentIndex: index,
                    totalCards: totalCards,
                    cardText: tinderData[index].cardTextEs,
                  );
                }
              },
              cardCount: totalCards + 1)),
        ],
      ),
      const SizedBox(
        height: 50,
      ),
      ActivityEndButton(isVisible: isEndButtonVisible),
    ]);
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.position,
    required this.color,
  });

  final bool isSelected;
  final IconData icon;
  final AlignmentGeometry position;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.09,
      left: position == Alignment.centerLeft
          ? -(MediaQuery.of(context).size.width * 0.12)
          : null,
      right: position == Alignment.centerRight
          ? -(MediaQuery.of(context).size.width * 0.12)
          : null,
      child: CircleAvatar(
        backgroundColor: isSelected ? color : Colors.white,
        child: Icon(
          icon,
          color: isSelected ? Colors.white : color,
          size: 20,
        ),
      ),
    );
  }
}

class TinderActivityPopUp extends StatelessWidget {
  const TinderActivityPopUp({
    super.key,
    required this.popupText,
  });

  final String popupText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          width: MediaQuery.sizeOf(context).width * 0.95,
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ActivityTextBody(
                '¿Sabías que...?',
                textAlign: TextAlign.center,
                isSmall: false,
              ),
              ActivityTextBody(
                popupText,
                textAlign: TextAlign.center,
                isSmall: true,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                ),
              )
            ],
          ),
        ));
  }
}

class TinderActivityCard extends StatelessWidget {
  const TinderActivityCard({
    super.key,
    required this.currentIndex,
    required this.totalCards,
    required this.cardText,
  });

  final int currentIndex;
  final int totalCards;
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.sizeOf(context).width * 0.70,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: LinearProgressIndicator(
                value: currentIndex / totalCards.toDouble(),
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(
                    ColorsTheme.primaryColorBlue),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text('${currentIndex + 1}/$totalCards',
                style: Theme.of(context).textTheme.titleSmall)
          ]),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ActivityTextBody(
                cardText,
                textAlign: TextAlign.start,
                isSmall: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LastTinderActivityCard extends StatelessWidget {
  const LastTinderActivityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.sizeOf(context).width * 0.70,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: const Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ActivityTextBody(
                '¡Actividad completada con éxito!',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
