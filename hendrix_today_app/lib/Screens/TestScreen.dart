import 'package:flutter/material.dart'; // new
import 'package:hendrix_today_app/Objects/Event.dart';

import '../Widgets/EventList.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[EventList2()],
    );
  }
}
