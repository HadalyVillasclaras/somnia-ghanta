import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/views/calendar/calendar_view.dart';
import 'package:intl/date_symbol_data_local.dart';


class HomeCalendarView extends ConsumerWidget {
  static const name = 'calendar_screen';
  const HomeCalendarView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    initializeDateFormatting('es_ES', null);

    return Scaffold(
      appBar: AppBar(
       automaticallyImplyLeading: false,
        centerTitle: false,
        leadingWidth: 200,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: [
          TextButton.icon(
            onPressed: (){
              Navigator.pop(context); 
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 15,
            ),
            label: const Text('Volver', style: TextStyle(color: Colors.grey)),
          ),])
      ),
      body: CalendarView(),
    );
  }
}