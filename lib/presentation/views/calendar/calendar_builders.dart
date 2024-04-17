import 'package:flutter/material.dart';

class SelectedDayBuilder extends StatelessWidget {
  final DateTime date;

  const SelectedDayBuilder({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;

    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 3, bottom: 0),
      decoration: BoxDecoration(
        border: Border.all(color: themeColor.primary, width: 2),
        shape: BoxShape.rectangle,
      ),
      child: Text(
        date.day.toString(),
        style: const TextStyle(fontSize: 14)
      ),    );
  }
}

class TodayBuilder extends StatelessWidget {
  final DateTime date;

  const TodayBuilder({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 3, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        shape: BoxShape.rectangle,
      ),
      child: Text(
        date.day.toString(),
        style: const TextStyle(fontSize: 14)
      ),
    );
  }
}

class DefaultBuilder extends StatelessWidget {
  final DateTime day;
  const DefaultBuilder({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final themeColor = Theme.of(context).colorScheme;

  final bool isLastColumn = day.weekday == DateTime.sunday; 
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: isLastColumn ? BorderSide.none : BorderSide(color: themeColor.tertiary, width: 0.5),
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 3, bottom: 0),
      child: Text(
        '${day.day}',
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class OutsideDayBuilder extends StatelessWidget {
  final DateTime day;

  const OutsideDayBuilder({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLastColumn = day.weekday == DateTime.sunday;
    final themeColor = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: isLastColumn ? BorderSide.none :  BorderSide(color: themeColor.tertiary, width: 0.5),
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 3, bottom: 0),
      child: Text(
        '${day.day}',
        style:  TextStyle(fontSize: 14, color:themeColor.tertiary),
      ),
    );
  }
}


class FeedbacksMarkerBuilder extends StatelessWidget {
  final DateTime date;
  final List<int> emotions;

  const FeedbacksMarkerBuilder(
    {Key? key, required this.date, required this.emotions,})
    : super(key: key);

  String? _getEmojiIconPath(int emotionNumber) { 
    if (emotionNumber >= 1 && emotionNumber <= 16) {
      return 'assets/icons/emotions/emoji-$emotionNumber.png';
    } else {
      return null;
    }
  }

@override
  Widget build(BuildContext context) {
    return Positioned(
      right: 3,
      top: 4,
      child: Wrap(
      direction: Axis.horizontal,
      children: emotions.map((emotion) {
        final path = _getEmojiIconPath(emotion);
        return path != null 
        ? Image.asset(path, width: 16, height: 16) 
        : const SizedBox.shrink();
      }).toList(),
      )
    );
  }
}


