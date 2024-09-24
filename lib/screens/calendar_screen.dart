import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/widgets/event_calendar.dart';
import 'package:hendrix_today_app/widgets/event_list.dart';
import 'package:hendrix_today_app/widgets/floating_nav_buttons.dart';
import 'package:hendrix_today_app/widgets/permission_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';

/// An event calendar for Hendrix Today.
///
/// This page displays a calendar that shows how many events are happening on
/// any given day and a list of the specific events happening on a selected day.
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  /// The day for which to show events; defaults to [DateTime.now].
  DateTime _selectedDay = DateTime.now();

  void _updateSelectedDay(DateTime newSelectedDay) {
    setState(() {
      _selectedDay = newSelectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final eventList = appState.events
        .where((HDXEvent e) =>
            (e.matchesDate(_selectedDay) || e.matchesDeadline(_selectedDay)) &&
            e.inPostingRangeCal(DateTime.now()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "calendar",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Column(
        children: [
          const PermissionWidget(Permission.notification),
          EventCalendar(onSelectDay: _updateSelectedDay),
          Expanded(
            child: EventList(events: eventList),
          ),
        ],
      ),
      floatingActionButton: const FloatingNavButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// all of this will change. olivia is doing this.
