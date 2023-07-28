import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:hendrix_today_app/firebase_options.dart';
import 'package:hendrix_today_app/widgets/root_app.dart';
import 'package:hendrix_today_app/objects/app_state.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.subscribeToTopic("new_events");

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  runApp(ChangeNotifierProvider(
    create: (context) => AppState(auth, firestore),
    builder: ((context, _) => const RootApp()),
  ));
}
