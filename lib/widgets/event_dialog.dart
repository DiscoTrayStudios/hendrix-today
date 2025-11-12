import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/widgets/rich_description.dart';
import 'package:intl/intl.dart';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' show Document, Node;

/// A detailed display of an [HDXEvent] built on the [AlertDialog] widget.
///
/// This dialog holds all [HDXEvent] information accessible to the user, so its
/// layout must be thoughtfully planned. This widget conforms to the Hendrix
/// College style guide.
///
/// To ensure Users can see titles of extreme length, this widget has been
/// made a Stateful Widget.

class EventDialog extends StatelessWidget {
  const EventDialog({super.key, required this.event});
  final HDXEvent event;


  /// Attempts to begin a draft email to the [HDXEvent.contactEmail].
  ///
  /// Fails if the [event]'s contact email cannot be parsed into a [Uri].
  void _tryEmailContact(bool contact) async {
    String mailto = "";
    if (contact) {
      final subject = 'Hendrix Today - response to "${event.title}"';
      mailto = 'mailto:${event.contactEmail}?subject=$subject';
    } else {
      final subject = 'Hendrix Today - report correction for "${event.title}"';
      mailto = 'mailto:prstu2@hendrix.edu?subject=$subject';
    }
    final uri = Uri.tryParse(mailto);
    if (uri == null) return;
    // skip the `canLaunchUrl(uri)` check because mailto: links fail
    launchUrl(uri);
  }

  _dialogSize(BuildContext context, String orientation) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    const originalHeight = 25.0;
    const originalWidth = 50.0;

    if (orientation.contains("v")) {
      if (screenHeight >= 1200) {
        return 300.0 + originalHeight;
      } else {
        return originalHeight;
      }
    }
    if (orientation.contains("h")) {
      if (screenWidth >= 500) {
        return 150.0 + originalWidth;
      } else {
        return originalWidth;
      }
    }

    return screenWidth;
  }

  String _parseDescription(desc) {
    final List<String> rtItems = [];
    final Document doc = parse(desc);
    final Node body = doc.body!;

    // remove all non-anchor tags (for safety)
    body.children.removeWhere((e) => e.localName != "a");

    while (body.hasChildNodes()) {
      final Node child = body.firstChild!;
      final String text = child.text ?? "";

      if (child.nodeType == Node.TEXT_NODE) {
        rtItems.add(text);
      } else if (child.nodeType == Node.ELEMENT_NODE) {
        final String hrefLink = child.attributes["href"].toString();
        rtItems.add("$text($hrefLink)");
      }

      child.remove();
    }
    final modifiedDesc = rtItems.toString();
    return modifiedDesc.substring(1, modifiedDesc.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(1970);
    DateTime date2 = DateTime(1970);
    bool parseFailed = false;

    if (event.time != null){
      // Parses the time of the event into a start and end time
      List<String> times = event.time!.split(' - ');
      times.first = times.first.replaceAll(' ', '');
      times.first = times.first.toUpperCase();
      times.last = times.last.replaceAll(' ', '');
      times.last = times.last.toUpperCase();
      try{
        date= DateFormat("hh:mma").parse(times.first);
        date2= DateFormat("hh:mma").parse(times.last);
      }
      catch(e){
        parseFailed = true;
      }
    }
    if (date2 == date){
      date2 = date2.add(const Duration(hours:1));
    }
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: _dialogSize(context, "v"),
          horizontal: _dialogSize(context, "h")),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))),
      titlePadding: const EdgeInsets.fromLTRB(0, 24, 18, 0),
      title: Stack(
        children: [
          Container(
            // From https://www.flutterbeads.com/card-border-in-flutter/
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    color: event.eventType.color(context), width: 16),
              ),
            ),
            padding: const EdgeInsetsDirectional.only(start: 8.0, end: 20.0),
            // minimum height to contain all 3 side buttons
            constraints: const BoxConstraints(minHeight: 185.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventDialogTitle(eventTitle: event.title),
                Text(
                  event.eventType.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: event.eventType.color(context)),
                ),
                const SizedBox(height: 5),
                Text(
                  "∙ ${event.displayDate()}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                if (event.time != null)
                  Text(
                    "∙ ${event.time!}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                if (event.location != null)
                  Text(
                    "∙ ${event.location!}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                if (event.hip) ...[
                  const SizedBox(height: 5),
                  Row(children: [
                    Icon(
                      Icons.local_activity,
                      color: Theme.of(context).colorScheme.primary,
                      size: 21,
                    ),
                    Text(
                      " This event is HIP approved!",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ]),
                ],
              ],
            ),
          ),
          Positioned(
            top: -15.0,
            right: -15.0,
            child: Column(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(0),
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () => Share.share(
                      '"${event.title}" -${_parseDescription(event.desc)}',
                      subject: 'Check out this event!'),
                  icon: const Icon(Icons.share),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.only(right: 2.0),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () => _tryEmailContact(true),
                  icon: const Icon(Icons.mail_outlined),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.only(right: 2.0),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    final Event calevent = Event(
                        title: (event.time == null || parseFailed)
                            ? event.title
                            : "${event.title}: ${event.time}",
                        description: event.desc,
                        location: event.location,
                        startDate: (event.time == null || parseFailed)
                        ? event.date
                        : DateTime(event.date.year,event.date.month, event.date.day,
                        date.hour, date.minute),
                        endDate: (event.time == null || parseFailed)
                        ? event.date.add(const Duration(days:1))
                        : 
                        DateTime(event.date.year,event.date.month, event.date.day,
                        date2.hour, date2.minute),
                        allDay: (event.time == null || parseFailed)
                        ? true
                        : false);
                    Add2Calendar.addEvent2Cal(calevent);
                  },
                  icon: const Icon(Icons.edit_calendar),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.only(right: 2.0),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () => _tryEmailContact(false),
                  icon: const Icon(Icons.feedback_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (event.applyDeadline != null) ...[
            Text(
              "This ${event.eventType.toString()} has a deadline: ",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              event.displayDeadline()!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 5),
          ],
          Flexible(
            child: SingleChildScrollView(
              child: RichDescription(text: event.desc),
            ),
          ),
        ],
      ),
    );
  }

  /// This widget creates an elipsis TextButton that only appears
  /// when the maximum title length has been exceeded. This will
  /// allow users to click and view the whole title should they desire.
}

class EventDialogTitle extends StatefulWidget {
  const EventDialogTitle({super.key, required this.eventTitle});
  final String eventTitle;

  @override
  // If there is a better way to do this. Let me know!
  // ignore: no_logic_in_create_state
  State createState() => _EventTitleState(eventTitle: eventTitle);
}

class _EventTitleState extends State<EventDialogTitle> {
  _EventTitleState({required this.eventTitle});
  final String eventTitle;
  int maximumLines = 4;
  bool extended = false;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        eventTitle.toString(),
        style: Theme.of(context).textTheme.headlineLarge,
        maxLines: maximumLines,
      ),
      _buildTextButton()
    ]);
  }

  Widget _buildTextButton() {
    if (eventTitle.length < 80 || extended) {
      return const SizedBox.shrink();
    } else {
      return TextButton(
          onPressed: () {
            setState(() {
              maximumLines = 20;
              extended = true;
            });
          },
          child: const Text(
            "...",
            style: TextStyle(
              // No remaining TextStyles remained, this was the only option.
              color: Color.fromARGB(255, 202, 81, 39),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ));
    }
  }
}
