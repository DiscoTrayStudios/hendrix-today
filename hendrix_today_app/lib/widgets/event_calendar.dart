import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/objects/event_type.dart';
import 'package:hendrix_today_app/widgets/event_list.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({super.key});

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

//creation of the TableCalendar
//code obtained from TableCalendar repo: https://github.com/aleksanderwozniak/table_calendar
class _EventCalendarState extends State<EventCalendar> {
  DateTime _focusedDay = DateTime(2022, 11, 7);
  DateTime calendarRoot = DateTime(2022, 11, 7);
  DateTime _selectedDay = DateTime(2022, 11, 7);

  List<Event> _applyEventFilters(AppState appState, DateTime day) =>
    appState.events
    .where((event) =>
      event.matchesDate(day) &&
      !event.eventType.matchesFilter(EventTypeFilter.announcements))
    .toList();

  /// Gets the events/announcements/etc. for the given day while also applying 
  /// relevant filters like the type filter dropdown on the app bar.
  List<Event> _getEventsForDay(DateTime day) {
    final appState = Provider.of<AppState>(context, listen: false);
    return _applyEventFilters(appState, day);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime(2022, 11, 7);
    final calendarStartDate = DateTime(today.year - 2, today.month, today.day);
    final calendarEndDate = DateTime(today.year, today.month + 1, today.day);
    return SizedBox(
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          return Column(
            children: [
              TableCalendar(
                firstDay: calendarStartDate,
                lastDay: calendarEndDate,
                focusedDay: _focusedDay,
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                },
                eventLoader: _getEventsForDay,
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.
                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: _onDaySelected,
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _selectedDay = DateTime(
                      focusedDay.year, focusedDay.month, _selectedDay.day);
                  _focusedDay = focusedDay;
                  setState(() {});
                },
              ),
              //EventList()
              Expanded(
                child: Consumer<AppState>(
                  builder: (context, appState, _) => EventList(
                    events: _applyEventFilters(appState, _selectedDay),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
