import 'package:flutter/material.dart';
import 'package:ghanta/presentation/views/calendar/calendar_custom_styles.dart';
import 'package:ghanta/presentation/views/calendar/event.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_builders.dart';

class CalendarView extends StatefulWidget {
  CalendarView({
    super.key,
  });

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  // Store the events
  Map<DateTime, List<Event>> events = {};
  late final ValueNotifier<List<Event>> _selectedEvents;
  final TextEditingController _eventController = TextEditingController();

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

  //devuelve la lista de eventos que haga match con el DateTime  
  List<Event>_getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Text("Registro:"),
          content: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: _eventController,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                addEvent(_eventController.text);
                _eventController.clear();
                Navigator.of(context).pop();
              },
              child: Text("Save")
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TableCalendar(
          locale: "es_ES",
          firstDay: DateTime.utc(2021, 10, 15), 
          lastDay: DateTime.utc(2030, 10, 15),
          startingDayOfWeek: StartingDayOfWeek.monday,
          rowHeight: 55,
          daysOfWeekHeight: 25.0,
          focusedDay: _focusedDay, 
          selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
          onDaySelected: _onDaySelected,
          eventLoader: _getEventsForDay,
          headerStyle:  headerCustomStyle(),
          availableGestures: AvailableGestures.all,
          calendarStyle: const CalendarStyle(
              rowDecoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)), // Row separators
              ),
            ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) => DefaultBuilder(day: day),
            outsideBuilder: (context, day, focusedDay) => OutsideDayBuilder(day: day),
            selectedBuilder: (context, date, events) => SelectedDayBuilder(date: date),
            todayBuilder: (context, date, events) => TodayBuilder(date: date),
            markerBuilder: (context, date, events) {
              if (events.isNotEmpty) {
                return EventsMarkerBuilder(date: date, events: events);
              }
            },
          ),
          onPageChanged:(focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        Container(
          color: Color.fromARGB(255, 6, 28, 67),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: const Text('Notas', style:TextStyle(color: Colors.white),),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 30), 
                  child: Text('This is some text on the left side'),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 1.0, color: Colors.grey), 
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 30), 
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity, 
                          child: ElevatedButton(
                            onPressed: _showAddEventDialog,
                            child: Text('Button'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Expanded(
        //   child: ValueListenableBuilder<List<Event>>(
        //     valueListenable: _selectedEvents, 
        //     builder: (context, value, _) {
        //     return ListView.builder(itemCount: value.length, itemBuilder: (context, index) {
        //       return Container(
        //         margin: EdgeInsets.all(2),
        //         decoration: BoxDecoration(
        //           border: Border.all(),
        //         ),
        //         child: ListTile(
        //           onTap: () => print(""),
        //           title: Text("${value[index].title}"),
        //         ),
        //       );
        //     }
        //   );
        // }
        // ),
        // ),
    ],
        );
  }
}