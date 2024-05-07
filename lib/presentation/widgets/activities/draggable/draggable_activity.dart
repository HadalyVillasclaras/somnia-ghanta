import 'package:flutter/material.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class DraggableActivity extends StatelessWidget {
  const DraggableActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const [
        DraggableActivityStepOne(),
      ],
    );
  }
}

class DraggableActivityStepOne extends StatefulWidget {
  const DraggableActivityStepOne({super.key});

  @override
  State<DraggableActivityStepOne> createState() =>
      _DraggableActivityStepOneState();
}

class _DraggableActivityStepOneState extends State<DraggableActivityStepOne> {
  int selectedPill = -1;
  @override
  Widget build(BuildContext context) {
    final List<String> items =
        List<String>.generate(5, (index) => "Item $index");

    return ActivityBody(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              height: MediaQuery.of(context).size.height * 0.20,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.8,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Draggable(
                    data: items[index],
                    feedback: DraggablePill(
                      text: items[index],
                    ),
                    childWhenDragging: const SizedBox(),
                    child: DraggablePill(
                      text: items[index],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.09,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.30,
                // width: MediaQuery.of(context).size.width ,
                width: double.infinity,
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.20),
                        spreadRadius: 0.5,
                        blurRadius: 0.90,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: //Ponemos un draggable para completar la frase
                    Row(
                  children: [
                    Expanded(
                      child: DragTarget<String>(
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.width * 0.30,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.20),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.90,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                'Arrastra aquí',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                        onWillAccept: (data) {
                          return true;
                        },
                        onAccept: (data) {
                          setState(() {
                            selectedPill = items.indexOf(data);
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      '3/8',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ))
          ],
       );
  }
}

class DraggablePill extends StatelessWidget {
  const DraggablePill({super.key, required this.text});

  final String text;
  final bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.30,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.20),
          spreadRadius: 0.5,
          blurRadius: 0.90,
          offset: const Offset(0, 1), // changes position of shadow
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
