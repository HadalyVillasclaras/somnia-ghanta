import 'package:flutter/material.dart';
import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class TextActivity extends StatelessWidget {
  const TextActivity({
   super.key, 
    required this.pageController, 
    required this.activity
  });

  final PageController pageController;
  final Activity activity;

 List<Widget> _createTextBlocks(String text) {
    List<Widget> blocks = [];
    for (int i = 0; i < text.length; i += 190) {
      String textChunk = text.substring(i, i + 190 > text.length ? text.length : i + 190);
      blocks.add(TextBlock(text: textChunk));
    }
    return blocks;
  }

  @override
  Widget build(BuildContext context) {
     List<Widget> textBlocks = _createTextBlocks(activity.descriptionEs);

    return PageView(
      controller: pageController,
      children: textBlocks,
    );
  }
}

class TextBlock extends StatelessWidget {
  const TextBlock({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return ActivityBody(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.4),
        Text(
            text, 
            style: Theme.of(context).textTheme.titleMedium,
),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
