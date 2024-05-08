import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:ghanta/config/constants/colors_theme.dart';
import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class TinderActivity extends StatelessWidget {
  const TinderActivity({
    super.key, 
    required this.pageController, 
    required this.activity
  });

  final PageController pageController;
  final Activity activity;


  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children:  [
        ActivityIntroText(
            text: activity.descriptionEs),
        const TinderActivityStepOne()],
    );
  }
}

class TinderActivityStepOne extends StatefulWidget {
  const TinderActivityStepOne({super.key});

  @override
  State<TinderActivityStepOne> createState() => _TinderActivityStepOneState();
}

class _TinderActivityStepOneState extends State<TinderActivityStepOne> {
  bool heartIsSelected = false;
  bool crossIsSelected = false;
  @override
  Widget build(BuildContext context) {
    return ActivityBody(
        children: [Stack(
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
                swipeOptions: const SwipeOptions.only(left: true, right: true),
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

                  if (targetIndex == 8) {
                    //!Esto debe ser dinamico
                    //Mostrar boton de compartir
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => const TinderActivityPopUp());
                  }
                },
                onSwipeEnd: (previousIndex, targetIndex, activity) {
                  setState(() {
                    heartIsSelected = false;
                    crossIsSelected = false;
                  });
                },
                backgroundCardOffset: const Offset(0, 0),
                cardBuilder: (context, index) => TinderActivityCard(
                      currentIndex: index,
                      totalCards: 8,
                    ),
                cardCount: 8 //! Esto debe ser dinamico
                )),
      ],
    )]);
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
  const TinderActivityPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          width: MediaQuery.sizeOf(context).width * 0.95,
          height: 350,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ActivityTextBody(
                '¿Sabías que...?',
                textAlign: TextAlign.center,
                isSmall: false,
              ),
              const ActivityTextBody(
                'La felicidad puede ser una elección consciente al cultivar actitudes y prácticas que promueven el bienestar emocional y la satisfacción personal.',
                textAlign: TextAlign.center,
                isSmall: true,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
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
  });

  final int currentIndex;
  final int totalCards;

  @override
  Widget build(BuildContext context) {
    List<String> dummyTexts = [
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit",
      "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
      "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur",
      "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
      "Curabitur pretium tincidunt lacus nulla gravida orci a odio",
      "Nullam varius, turpis et commodo pharetra, est eros bibendum elit, nec luctus magna felis sollicitudin mauris",
      "Integer in mauris eu nibh euismod gravida"
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical:20),
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
                dummyTexts[currentIndex],
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
