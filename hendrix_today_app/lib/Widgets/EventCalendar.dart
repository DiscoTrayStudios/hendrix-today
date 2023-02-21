import 'package:hendrix_today_app/Objects/Event.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:hendrix_today_app/Objects/AppState.dart';
import "package:intl/intl.dart";

class EventCalendar extends StatefulWidget {
  const EventCalendar({super.key});

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

//creation of the TableCalendar
//code obtained from TableCalendar repo: https://github.com/aleksanderwozniak/table_calendar
class _EventCalendarState extends State<EventCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime calendarRoot = DateTime.now();
  DateTime? _selectedDay;
  late DateTime calendarStartDate;
  late DateTime calendarEndDate;

  @override
  void initState() {
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      //_selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    calendarStartDate =
        DateTime(calendarRoot.year, calendarRoot.month - 6, calendarRoot.day);
    calendarEndDate =
        DateTime(calendarRoot.year, calendarRoot.month + 6, calendarRoot.day);
    return SizedBox(
      child: Consumer<AppState>(builder: (context, appState, _) {
        return ListView(children: [
          TableCalendar(
            firstDay: calendarStartDate,
            lastDay: calendarEndDate,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
          EventList(),
        ]);
      })
    );
  }
}
