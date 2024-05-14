
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';

class HomeProfileActivity extends StatelessWidget {
  const HomeProfileActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          Lang.of(context).home_profile_my_activity,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: theme.onBackground),
        ),
        const SizedBox(
          height: 20,
        ),
        EasyDateTimeLine(
          dayProps: EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            todayStyle: DayStyle(
                dayNumStyle: TextStyle(color: theme.onBackground),
                dayStrStyle: TextStyle(color: theme.onBackground),
                decoration: BoxDecoration(
                    //Cambiamos el color del border
                    border: Border.all(
                        color: theme.brightness == Brightness.light
                            ? theme.primary
                            : const Color(0xFF06667C),
                        width: 2),
                    borderRadius: BorderRadius.circular(20))),
            inactiveDayStyle: DayStyle(
              dayNumStyle: TextStyle(color: theme.onBackground),
              dayStrStyle: TextStyle(color: theme.onBackground),
            ),
            activeDayStyle: DayStyle(
                dayNumStyle: TextStyle(color: theme.onPrimary),
                dayStrStyle: TextStyle(color: theme.onPrimary),
                decoration: BoxDecoration(
                    color: theme.brightness == Brightness.light
                        ? theme.primary
                        : const Color(0xFF06667C),
                    borderRadius: BorderRadius.circular(20))),
          ),
          onDateChange: (selectedDate) {
          
          },
          initialDate: DateTime.now(),
          locale: Lang.getDeviceLang(context),
          headerProps: EasyHeaderProps(
              selectedDateStyle: TextStyle(color: theme.onBackground),
              monthStyle: TextStyle(color: theme.onBackground)),
        )
      ],
    );
  }
}