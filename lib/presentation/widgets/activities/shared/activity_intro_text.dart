import 'package:flutter/material.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class ActivityIntroText extends StatelessWidget {
  const ActivityIntroText({
    super.key,
    required this.text,  
  });

  final String text;  

  @override
  Widget build(BuildContext context) {
    return ActivityBody(
        children: [
          Text(
            text,  
            style: Theme.of(context).textTheme.titleMedium
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.08)
        ],
    );
  }
}
