import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:ghanta/config/constants/colors_theme.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class TinderActivity extends StatelessWidget {
  const TinderActivity({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [TinderActivityStepOne()],
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
        child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
            bottom: MediaQuery.sizeOf(context).height * 0.09,
            right: -(MediaQuery.sizeOf(context).width * 0.12),
            child: CircleAvatar(
              backgroundColor: heartIsSelected ? Colors.red : Colors.white,
              child: Icon(
                Icons.favorite,
                color: heartIsSelected ? Colors.white : Colors.red,
                size: 20,
              ),
            )),
        Positioned(
            bottom: MediaQuery.sizeOf(context).height * 0.09,
            left: -(MediaQuery.sizeOf(context).width * 0.12),
            child: CircleAvatar(
              backgroundColor:
                  crossIsSelected ? ColorsTheme.primaryColorBlue : Colors.white,
              child: Icon(
                Icons.clear,
                color: crossIsSelected
                    ? Colors.white
                    : ColorsTheme.primaryColorBlue,
                size: 20,
              ),
            )),
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
                cardBuilder: (context, index) => const TinderActivityCard(),
                cardCount: 8 //! Esto debe ser dinamico

                )),
      ],
    ));
  }
}

class TinderActivityPopUp extends StatelessWidget {
  const TinderActivityPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: MediaQuery.sizeOf(context).width * 0.95,
          // height: MediaQuery.sizeOf(context).height * 0.23,
          constraints: const BoxConstraints(
            minHeight: 300,
            maxHeight: 400,
          ),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const ActivityTextBody(
                '¿Sabías que...?',
                textAlign: TextAlign.center,
                isSmall: false,
              ),
              const ActivityTextBody(
                'El 80% de las personas que se conocen en Tinder, no se conocen en persona. ¿Te gustaría conocer a tu match?',
                textAlign: TextAlign.center,
                isSmall: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: FilledButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        backgroundColor: Colors.white,
                        elevation: 1),
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: ColorsTheme.primaryColorBlue),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: ColorsTheme.primaryColorBlue,
                    ),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class TinderActivityCard extends StatelessWidget {
  const TinderActivityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 20, vertical: MediaQuery.sizeOf(context).height * 0.03),
      width: MediaQuery.sizeOf(context).width * 0.70,
      // height: MediaQuery.sizeOf(context).height * 0.23,
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height * 0.20,
        maxHeight: MediaQuery.sizeOf(context).height * 0.23,
      ),
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
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      ColorsTheme.primaryColorBlue),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                '3/8',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorsTheme.primaryColorBlue,
                    fontWeight: FontWeight.bold),
              )
            ]),
            const SizedBox(
              height: 20,
            ),
            const ActivityTextBody(
              '¿Crees que la felicidad se encuentra principalmente en momentos especiales y eventos extraordinarios?',
              textAlign: TextAlign.start,
              isSmall: true,
            ),
          ],
        ),
      ),
    );
  }
}
