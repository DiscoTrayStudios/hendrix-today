import 'package:flutter/material.dart';
import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/widgets/event_card.dart';
import 'package:intl/intl.dart';

/// A scrollable [ListView] of [EventCard]s.
class EventList extends StatelessWidget {
  const EventList({super.key, required this.events});

  /// The events to be displayed as [EventCard]s.
  final List<HDXEvent> events;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: [
        ..._eventListing(context, events),
        const SizedBox(height: 85),
      ],
    );
  }

  List<Widget> _eventListing(context, events) {
    HDXEvent? previousEvent = null;
    List<Widget> eventList = [];
    for (HDXEvent e in events) {
      if (previousEvent == null) {
        eventList.add(Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(DateFormat('EEEE').format(e.date),
              style: Theme.of(context).textTheme.displaySmall),
        ));
        eventList.add(EventCard(event: e));
      } else if (e.matchesDate(previousEvent.date)) {
        eventList.add(EventCard(event: e));
      } else {
        eventList.add(const SizedBox(height: 20));
        eventList.add(Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(DateFormat('EEEE').format(e.date),
              style: Theme.of(context).textTheme.displaySmall),
        ));
        eventList.add(EventCard(event: e));
      }
      previousEvent = e;
    }
    return eventList;
  }
}


//  ````````````````````````````````
// my dog put her paw on by keyboard and wrote that.  who am i to tell her she cant code.
