import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/enviroment.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/presentation/providers/feedback_provider.dart';
import 'package:ghanta/presentation/views/calendar/calendar_view.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeCalendarView extends ConsumerWidget {
  static const name = 'calendar_screen';
  const HomeCalendarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initializeDateFormatting('es_ES', null);

    final feedbacksAsyncValue = ref.watch(userFeedbackProvider);

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
      body: _calendarBody(feedbacksAsyncValue)
    );
  }        
}

Widget _calendarBody(AsyncValue<List<UserFeedback>> feedbacksAsyncValue) {
    return feedbacksAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const Center(child: Padding(
        padding: EdgeInsets.all(30),
        child: Text('El calendario no está disponible en estos momentos.', textAlign: TextAlign.center,),
      )),
      data: (feedbacks) {
        return CalendarView(feedbacks: feedbacks);
      },
    );
  }