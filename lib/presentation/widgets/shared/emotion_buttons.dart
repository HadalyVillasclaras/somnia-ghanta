import 'package:flutter/material.dart';

class EmotionButtons extends StatelessWidget {
  const EmotionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.sentiment_very_dissatisfied,
                size: sizes.width * 0.1,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.sentiment_dissatisfied,
                size: sizes.width * 0.1,
                color: Colors.orange,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.sentiment_neutral,
                size: sizes.width * 0.1,
                color: Colors.yellow,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.sentiment_satisfied,
                size: sizes.width * 0.1,
                color: Colors.lightGreen,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.sentiment_very_satisfied,
                size: sizes.width * 0.1,
                color: Colors.green,
              ),
            ),
          ],
        );
  }
}