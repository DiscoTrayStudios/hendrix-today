import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/event.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// A [ChangeNotifier] that keeps an up-to-date list of events from Firebase.
class AppState extends ChangeNotifier {
  StreamSubscription<QuerySnapshot>? _eventSubscription;
  late Future<Database> _readItemsDb;
  List<({int id, String event})> _readItemsLocal = [];
  List<Event> _events = [];

  /// The list of events, ordered by [Event.compareByDate].
  List<Event> get events => _events;

  AppState(this.auth, this.firestore) {
    _init();
  }
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Future<void> _init() async {
    _initReadItems();
    _initFirebase();
  }

  Future<void> _initReadItems() async {
    _readItemsDb = openDatabase(
      join(await getDatabasesPath(), 'htLocal.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE Views (id INTEGER PRIMARY KEY, event STRING)');
      },
      version: 1,
    );
    _readItemsDb.then((db) async {
      final query = await db.query('Views');
      _readItemsLocal = query
          .map(
              (item) => (id: item['id'] as int, event: item['event'] as String))
          .toList();
    });
  }

  /// Listens for login and Firestore changes, updates the event list, then
  /// notifies listeners.
  void _initFirebase() {
    auth.userChanges().listen((user) {
      _eventSubscription?.cancel();
      _eventSubscription = firestore
          .collection('events') //GV had .doc(user.uid); document ref
          .snapshots()
          .listen(
        (snapshot) {
          _events = [];
          for (var document in snapshot.docs) {
            final Map<String, dynamic> data = document.data();
            final Event? event = Event.fromFirebase(data);
            if (event != null) {
              _events.add(event);
            } else {
              debugPrint("Throwing away invalid event data: $data");
            }
          }
          // establishes a default sort order
          _events.sort((Event a, Event b) => a.compareByDate(b));
          notifyListeners();
        },
        onError: (error) {
          debugPrint(error);
        },
      );
      notifyListeners();
    });
  }

  /// Returns `true` if an item with an ID of [id] exists in [_readItemsDb].
  bool hasBeenRead(int id) {
    return _readItemsLocal.any((record) => record.id == id);
  }

  /// Returns `true` if an item with the same ID as [event] exists in [_readItemsDb]
  /// but has different contents.
  bool hasBeenUpdated(Event event) {
    final matches = _readItemsLocal.where((record) => record.id == event.id);
    if (matches.isEmpty) return false;
    return matches.first.event != event.toString();
  }

  /// Add [event] to [_readItemsDb].
  ///
  /// If an item with the same ID as [event] exists, it will be replaced.
  void markEventAsRead(Event event) {
    _readItemsLocal.add((id: event.id, event: event.toString()));
    _readItemsDb.then((db) => db.insert(
          'Views',
          {'id': event.id, 'event': event.toString()},
          conflictAlgorithm: ConflictAlgorithm.replace,
        ));
  }

  /// Mark all events in [_events] as read.
  void markAllAsRead() {
    for (final event in _events) {
      markEventAsRead(event);
    }
  }

  /// Remove all items from [_readItemsDb].
  Future<void> markAllAsUnread() async {
    _readItemsLocal.clear();
    _readItemsDb.then((db) => db.delete('Views'));
  }

  void debugPrintLocalDb() {
    _readItemsDb.then((db) async {
      final query = await db.query('Views');
      debugPrint('${query.length} items in SQLite marked as read: $query');
      debugPrint('${_readItemsLocal.length} items in local marked as read: '
          '$_readItemsLocal');
    });
  }
}
