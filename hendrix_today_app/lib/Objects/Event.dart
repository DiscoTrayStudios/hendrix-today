import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";

import 'AppState.dart';

class Event {
  final String? title;
  final String? desc;
  final String? time;
  final Timestamp? date; // change this to date

  Event({
    this.title,
    this.desc,
    this.time,
    this.date,
  });

  String stampToString() {
    var dt = date?.toDate();
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    final String _date = formatter.format(dt ?? DateTime.now());
    return _date;
  }

  DateTime stampToDate() {
    var dt = date?.toDate();
    return dt ?? DateTime.now();
  }
}

class EventList extends StatefulWidget {
  @override
  EventListState createState() => EventListState();
}

class EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: appState.events.length,
          itemBuilder: (context, index) {
            final item = appState.events[index];
            return Card(
              child: ListTile(
                title: Text(item.title.toString()),
                subtitle: Text(item.date.toString()),
                onTap: () {
                  AlertDialog alert = AlertDialog(
                    title: Text(item.title.toString()),
                    insetPadding:
                        EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                    content: Column(children: [Text(item.desc.toString())]),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
