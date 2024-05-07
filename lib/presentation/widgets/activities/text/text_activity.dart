import 'package:flutter/material.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:go_router/go_router.dart';

class TextActivity extends StatelessWidget {
  const TextActivity({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        TextBlock(),
        TextBlock(),
        TextBlock(),
        TextBlock(),

      ],
    );
  }
}

class TextBlock extends StatelessWidget {
  const TextBlock({super.key});
  @override
  Widget build(BuildContext context) {
    return ActivityBody(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.4),
        Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ac commodo est, non lobortis lectus. Sed iaculis porttitor urna, eu pretium sem porttitor at. Cras magna mauris, sagittis quis ex eu, accumsan faucibus neque. Proin.', 
            style: Theme.of(context).textTheme.titleMedium,
),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
