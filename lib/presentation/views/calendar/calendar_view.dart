import 'package:flutter/material.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/presentation/views/calendar/calendar_custom_styles.dart';
import 'package:ghanta/presentation/views/calendar/event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_builders.dart';

class CalendarView extends StatefulWidget {
  final List<UserFeedback> feedbacks;

  const CalendarView({
    Key? key,
    required this.feedbacks, 
  }) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Event>> events = {};
  // final TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;
  
  Map<DateTime, List<UserFeedback>> feedbacksByDate = {};
  
  // INIT STATE
  @override
  void initState() {
    super.initState();

    _organizeFeedbacks();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  void _organizeFeedbacks() {
    final Map<DateTime, List<UserFeedback>> map = {};
    for (var feedback in widget.feedbacks) {
      DateTime date = DateTime(feedback.date.year, feedback.date.month, feedback.date.day);
      if (map.containsKey(date)) {
        map[date]?.add(feedback);
      } else {
        map[date] = [feedback];
      }
    }
    setState(() {
      feedbacksByDate = map;
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay; // Update the focused day to the selected day
      _selectedEvents.value = _getEventsForDay(selectedDay); // Update the events for the selected day
    });
  }

  void addEvent(String eventName) {
    final event = Event(title: eventName); 
    setState(() {
      if (events[_focusedDay] != null) {
        events[_focusedDay]!.add(event);
      } else {
        events[_focusedDay] = [event];
      }
      _selectedEvents.value = _getEventsForDay(_focusedDay); // Update the events  
    });
  }


  // void _addCrisisDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         scrollable: true,
  //         title: const Text("Registro de crisis:"),
  //         content: Padding(
  //           padding: const EdgeInsets.all(8),
  //           child: TextField(
  //             controller: _eventController,
  //           ),
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               addEvent(_eventController.text);
  //               _eventController.clear();
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text("Save")
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  //devuelve la lista de eventos que haga match con el DateTime  
  List<Event>_getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TableCalendar(
          locale: "es_ES",
          firstDay: DateTime.utc(2021, 10, 15), 
          lastDay: DateTime.utc(2030, 10, 15),
          startingDayOfWeek: StartingDayOfWeek.monday,
          rowHeight: 58,
          daysOfWeekHeight: 25.0,
          headerStyle:  headerCustomStyle(),
          eventLoader: _getEventsForDay,
          focusedDay: _focusedDay, 
          selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
          onDaySelected: _onDaySelected,
          availableGestures: AvailableGestures.all,
          calendarStyle: CalendarStyle(
              rowDecoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: themeColor.tertiary, width: 0.5)), 
              ),
            ),
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
            List<String> dayNames = ['LUN', 'MAR', 'MIE', 'JUE', 'VIE', 'SÁB', 'DOM']; 
            String dayName = dayNames[day.weekday - 1]; 

            return Center(
              child: Text(
                dayName.toUpperCase(), 
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700 ),
              ),
            );
          },
            defaultBuilder: (context, day, focusedDay) => DefaultBuilder(day: day),
            outsideBuilder: (context, day, focusedDay) => OutsideDayBuilder(day: day),
            selectedBuilder: (context, date, events) => SelectedDayBuilder(date: date),
            todayBuilder: (context, date, events) => TodayBuilder(date: date),
            markerBuilder: (context, date, events) {
              DateTime dateOnly = DateTime(date.year, date.month, date.day);
              // it checks on every month change
              if (feedbacksByDate.containsKey(dateOnly)) {
                List<int> emotions = feedbacksByDate[dateOnly]!
                .expand((feedback) => feedback.feedbackDetails.map((detail) => detail.emotion))
                .toList();
                if (emotions.length > 3) {
                  emotions = emotions.sublist(0, 3);  
                }
                return FeedbacksMarkerBuilder(date: date, emotions: emotions);
              } else {
                return null;
              }
            },
          ),
          onPageChanged:(focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        Container(
          color: themeColor.primary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: const Text('Notas', style:TextStyle(color: Colors.white),),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: NotesField(selectedDay: _selectedDay, feedbacksByDate: feedbacksByDate),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 1.0, color: themeColor.tertiary), 
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 30), 
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EmotionsField(selectedDay: _selectedDay, feedbacksByDate: feedbacksByDate),
                        // SizedBox(
                        //   width: double.infinity, 
                        //   child: ElevatedButton(
                        //     onPressed: _addCrisisDialog,
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.red,  
                        //       padding: const EdgeInsets.all(0),
                        //     ),
                        //     child: const Text(
                        //       'Consultar crisis de pánico',
                        //       style: TextStyle(
                        //         fontSize: 12, 
                        //         fontWeight: FontWeight.w300, 
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    ],
        );
  }
}

class EmotionsField extends StatelessWidget {
  const EmotionsField({
    super.key,
    required DateTime? selectedDay,
    required this.feedbacksByDate,
  }) : _selectedDay = selectedDay;

  final DateTime? _selectedDay;
  final Map<DateTime, List<UserFeedback>> feedbacksByDate;

  String? _getEmojiIconPath(int emotionNumber) { 
    if (emotionNumber >= 1 && emotionNumber <= 16) {
      return 'assets/icons/emotions/emoji-$emotionNumber.png';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: _selectedDay != null && feedbacksByDate.containsKey(DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day))
        ? feedbacksByDate[DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day)]!
          .expand((feedback) => feedback.feedbackDetails.map((detail) {
              final emojiIconPath = _getEmojiIconPath(detail.emotion);
              return emojiIconPath != null 
              ? Padding(
                padding: const EdgeInsets.all(1.0),
                child: Image.asset(emojiIconPath, width: 50, height: 50),) 
              : const SizedBox.shrink();  
            }))
            .toList()
        : [const Text('')],
      ),
    );
  }
}

class NotesField extends StatelessWidget {
  const NotesField({
    super.key,
    required DateTime? selectedDay,
    required this.feedbacksByDate,
  }) : _selectedDay = selectedDay;

  final DateTime? _selectedDay;
  final Map<DateTime, List<UserFeedback>> feedbacksByDate;

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 30), 
      child: _selectedDay != null && feedbacksByDate.containsKey(DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day))
      ? SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: List.generate(
              feedbacksByDate[DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day)]!.expand((feedback) => feedback.feedbackDetails).length * 2 - 1,
              (index) {
                if (index.isEven) {
                  final feedbackDetail = feedbacksByDate[DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day)]!
                    .expand((feedback) => feedback.feedbackDetails)
                    .elementAt(index ~/ 2);
                  return Text(
                    feedbackDetail.feedback, 
                    style: TextStyle(color: themeColor.tertiary, fontSize: 13),
                  );
                } else {
                  return Divider(color: themeColor.tertiary,);
                }
              },
            ),
          ),
      )
      : const Text(''),
    );
  }
}