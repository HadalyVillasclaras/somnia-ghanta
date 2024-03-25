import 'package:flutter/material.dart';

class SelectedDayBuilder extends StatelessWidget {
  final DateTime date;

  const SelectedDayBuilder({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 3, bottom: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey, width: 2),
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
  final bool isLastColumn = day.weekday == DateTime.sunday; 
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: isLastColumn ? BorderSide.none : BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 3, bottom: 0),
      child: Text(
        '${day.day}',
        style: TextStyle(fontSize: 14),
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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: isLastColumn ? BorderSide.none : const BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 3, bottom: 0),
      child: Text(
        '${day.day}',
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}


class EventsMarkerBuilder extends StatelessWidget {
  final DateTime date;
  final List events;

  const EventsMarkerBuilder(
    {Key? key, required this.date, required this.events})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 3,
      top: 4,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: events
          .take(3) // Limit the number of dots
          .map((event) => Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 216, 86, 6),
            ),
          ))
          .toList(),
      ),
    );
  }
}


