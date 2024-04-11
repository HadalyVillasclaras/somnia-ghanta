import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

HeaderStyle headerCustomStyle() {
  return HeaderStyle(
    formatButtonVisible: false,
    titleTextStyle:const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
    leftChevronMargin:const EdgeInsets.symmetric(horizontal: 0),
    rightChevronMargin: const EdgeInsets.symmetric(horizontal: 0),
    headerPadding:const EdgeInsets.symmetric(vertical: 0.0),
    headerMargin: const EdgeInsets.only(bottom: 5),
    leftChevronIcon:const Icon(Icons.chevron_left, size: 20),
    rightChevronIcon:const Icon(Icons.chevron_right, size: 20),
    titleTextFormatter: (date, locale) {
      String month = DateFormat('MMMM', locale).format(date);
      //Capitalize the first letter of month
      String capitalizedMonth = month[0].toUpperCase() + month.substring(1);
      String year = DateFormat('yyyy', locale).format(date);
      return '$year$capitalizedMonth';
    },
  );
}