import 'package:flutter/material.dart';

import 'package:hendrix_today_app/screens/resource_screen.dart';
import 'package:hendrix_today_app/screens/search_screen.dart';
import 'package:hendrix_today_app/screens/home_screen.dart';
import 'package:hendrix_today_app/widgets/event_calendar.dart';

import 'package:url_launcher/url_launcher.dart';

class ScreenContainer extends StatefulWidget {
  const ScreenContainer({super.key});

  @override
  State<ScreenContainer> createState() => _ScreenContainerState();
}

class _ScreenContainerState extends State<ScreenContainer> {
  Color webOrange = const Color.fromARGB(255, 202, 81, 39);
  int selectedIndex = 0;
  List<Widget> pages = []; //contains each page
  List<String> titles = [];
  List<String> menuLinks = []; //contains the title of each page
  final List<String> dropdownItems = [
    "Events",
    "Announcements",
    "Meetings",
  ];
  String dropdownValue = "Events";

  @override
  void initState() {
    super.initState();
    pages = [
      const MyHomeScreen(),
      const EventCalendar(),
      const SearchScreen(),
      const ResourcesScreen(),
    ];
    titles = [
      "Hendrix Today",
      "HDX Calendar",
      "Search",
      "Resources Page",
    ];
    menuLinks = [
      "https://www.hendrix.edu/diningservices/default.aspx?id=1003",
      "https://www.hendrix.edu/diningservices/default.aspx?id=1004",
      "https://www.hendrix.edu/diningservices/default.aspx?id=1005",
      "https://www.hendrix.edu/diningservices/default.aspx?id=1006",
      "https://www.hendrix.edu/diningservices/default.aspx?id=1007",
      "https://www.hendrix.edu/diningservices/default.aspx?id=1008",
      "https://www.hendrix.edu/diningservices/default.aspx?id=1002"
    ];
  }

  _launchURLApp() async {
    int dayOfWeek = DateTime.now().weekday;
    String menuLink = menuLinks[dayOfWeek - 1];
    Uri menuUrl = Uri.parse(menuLink);
    if (await canLaunchUrl(menuUrl)) {
      await launchUrl(menuUrl);
    } else {
      throw 'Could not launch $menuUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: webOrange,
        title: Text(titles[selectedIndex]),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/sign-in");
            },
            icon: Icon(Icons.account_circle)),
        actions: [
          DropdownButton<String>(
              value: dropdownValue,
              style: const TextStyle(color: Colors.white),
              dropdownColor: webOrange,
              items: dropdownItems.map((itemone) {
                return DropdownMenuItem(value: itemone, child: Text(itemone));
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue.toString();
                });
              }),
        ],
      ),
      body: Center(child: pages[selectedIndex]),
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              key: const Key('CalendarButton'),
              margin: EdgeInsets.all(10),
              child: FloatingActionButton.small(
                onPressed: () {
                  onItemTapped(1);
                },
                backgroundColor: Colors.black87,
                child: Icon(Icons.calendar_month),
              )), //button first

          Container(
              key: const Key('HomeButton'),
              margin: EdgeInsets.all(10),
              child: FloatingActionButton.small(
                onPressed: () {
                  onItemTapped(0);
                },
                backgroundColor: Colors.deepOrangeAccent,
                child: Icon(Icons.home),
              )), // button second

          Container(
              key: const Key('SearchButton'),
              margin: EdgeInsets.all(10),
              child: FloatingActionButton.small(
                onPressed: () {
                  onItemTapped(2);
                  //action code for button 3
                },
                backgroundColor: Colors.teal,
                child: Icon(Icons.search),
              )),
          // button third
          Container(
            key: const Key('MenuButton'),
            margin: EdgeInsets.all(10),
            child: FloatingActionButton.small(
                onPressed: _launchURLApp,
                backgroundColor: Color.fromARGB(255, 162, 131, 102),
                child: const Icon(Icons.food_bank)),
          ),
          Container(
              key: const Key('ResourcesPage'),
              margin: EdgeInsets.all(10),
              child: FloatingActionButton.small(
                onPressed: () {
                  onItemTapped(3);
                  //action code for button 3
                },
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.question_mark),
              )),
          /**
          Container(
              key: const Key('ResourcesPage2'),
              margin: EdgeInsets.all(10),
              child: FloatingActionButton.small(
                onPressed: () {
                  onItemTapped(4);
                  //action code for button 3
                },
                backgroundColor: Colors.yellow,
                child: Icon(Icons.question_mark),
              ))
*/
          // Container(
          //     key: const Key('TestButton'),
          //     margin: EdgeInsets.all(10),
          //     child: FloatingActionButton.small(
          //       onPressed: () {
          //         onItemTapped(3);
          //         //action code for button 3
          //       },
          //       backgroundColor: Colors.teal,
          //       child: Icon(Icons.emoji_nature),
          //     )), // button third
          // Container(
          //   key: const Key('MenuButton'),
          //   margin: EdgeInsets.all(10),
          //   child: FloatingActionButton.small(
          //       onPressed: _launchURLApp,
          //       backgroundColor: Color.fromARGB(255, 162, 131, 102),
          //       child: const Icon(Icons.food_bank)),
          // )
          //Add more buttons here
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Stores Page Titles for AppBar

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
