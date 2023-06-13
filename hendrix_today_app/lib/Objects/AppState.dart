import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hendrix_today_app/Objects/Event.dart';
import 'package:hendrix_today_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // new
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new

class AppState extends ChangeNotifier {
  List<Event> _events = [];
  List<Event> get events => _events;
  // List<Event> events2 = [event1, event2, event3, event4, event5];

  AppState() {
    init();
  }

  bool firstSnapshot = true;
  StreamSubscription<QuerySnapshot>? eventSubscription;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      eventSubscription?.cancel();
      print("starting to listen");
      eventSubscription = FirebaseFirestore.instance
          .collection('events') //GV had .doc(user.uid); document ref
          .snapshots()
          .listen(
        (snapshot) {
          print("in snapshot");
          _events = [];
          snapshot.docs.forEach((document) {
            _events.add(Event(
              title: document.data()['title'],
              desc: document.data()['desc'],
              time: document.data()['time'],
              date: DateUtils.dateOnly(document.data()['date'].toDate()),
            ));
          });
          //  print(snapshot.docChanges.toString()); //prints changes
          firstSnapshot = false;
          notifyListeners();
        },
        onError: (error) {
          print(error);
        },
      );

      notifyListeners();
    });
  }

  List<Event> searchEvents(String searchQuery) {
    List<Event> results = [];
    if (searchQuery.isEmpty) {
      results = _events;
    } else {
      for (Event e in _events) {
        if (e.title!.toLowerCase().contains(searchQuery.toLowerCase()) |
            (e.desc!.toLowerCase().contains(searchQuery.toLowerCase()))) {
          results.add(e);
        }
      }
    }
    notifyListeners();
    return results;
  }
}
// Event event1 = Event(
//     title: "Event1",
//     desc: "this is a description of event 1",
//     time: "1pm",
//     date: "2/1/23",
//     tags: ["Meeting"]);
// Event event2 = Event(
//     title: "Event2",
//     desc:
//         "here is a very long description of event 2. i want to make sure the alert dialog box doesnt look stupid. this is a neat app. i like working on it very much. however i keep getting side tracked.",
//     time: "2pm",
//     date: "2/2/23",
//     tags: ["Scholarships"]);
// Event event3 = Event(
//     title: "Event3",
//     desc: "this is a description of event 3",
//     time: "3pm",
//     date: "2/3/23",
//     tags: ["Psyschology"]);
// Event event4 = Event(
//     title: "Event4",
//     desc: "this is a description of event 4",
//     time: "4pm",
//     date: "2/4/23",
//     tags: ["Jobs/Internships"]);
// Event event5 = Event(
//     title: "Event5",
//     desc: "this is a description of event 5",
//     time: "5pm",
//     date: "2/5/23",
//     tags: ["Meeting"]);

// Event event1 = Event(
//     title: "Event1",
//     desc: "this is a description of event 1",
//     time: "1pm",
//     date: "2/1/23",
//     tags: ["Meeting"]);
// Event event2 = Event(
//     title: "Event2",
//     desc:
//         "here is a very long description of event 2. i want to make sure the alert dialog box doesnt look stupid. this is a neat app. i like working on it very much. however i keep getting side tracked.",
//     time: "2pm",
//     date: "2/2/23",
//     tags: ["Scholarships"]);
// Event event3 = Event(
//     title: "Event3",
//     desc: "this is a description of event 3",
//     time: "3pm",
//     date: "2/3/23",
//     tags: ["Psyschology"]);
// Event event4 = Event(
//     title: "Event4",
//     desc: "this is a description of event 4",
//     time: "4pm",
//     date: "2/4/23",
//     tags: ["Jobs/Internships"]);
// Event event5 = Event(
//     title: "Event5",
//     desc: "this is a description of event 5",
//     time: "5pm",
//     date: "2/5/23",
//     tags: ["Meeting"]);
