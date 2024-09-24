import 'package:flutter/material.dart';

import 'package:hendrix_today_app/widgets/floating_nav_buttons.dart';
import 'package:hendrix_today_app/widgets/resource_button.dart';
import 'package:hendrix_today_app/widgets/toggle_bar.dart';

/// A list of official Hendrix resources.
///
/// This screen provides links to the following resources:
/// * The form to submit a new Hendrix Today item
/// * The Hendrix Caf daily menu
/// * The campus Public Safety phone number
/// * The official campus map
class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const menuLinks = [
      "https://www.hendrix.edu/diningservices/default.aspx?id=1003", // Mo
      "https://www.hendrix.edu/diningservices/default.aspx?id=1004", // Tu
      "https://www.hendrix.edu/diningservices/default.aspx?id=1005", // We
      "https://www.hendrix.edu/diningservices/default.aspx?id=1006", // Th
      "https://www.hendrix.edu/diningservices/default.aspx?id=1007", // Fr
      "https://www.hendrix.edu/diningservices/default.aspx?id=1008", // Sa
      "https://www.hendrix.edu/diningservices/default.aspx?id=1002", // Su
    ];
    int dayOfWeek = DateTime.now().weekday;
    String menuLink = menuLinks[dayOfWeek - 1];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "resources",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              ResourceButton(
                  key: const Key('SubmitEventButton'),
                  titleString: "submit event",
                  icon: Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                  url:
                      'https://forms.office.com/Pages/ResponsePage.aspx?id=jMH2DNLQP0qD0GY9Ygpj020T9lhtzfhCi8WBPrgNg0xURFZXMEEyUzUwR0lNSzZTTDdWWEQwOERSWiQlQCN0PWcu'),
              const SizedBox(height: 10),
              ResourceButton(
                  key: const Key('ReserveRoom'),
                  titleString: "reserve room",
                  icon: Icons.meeting_room,
                  color: Theme.of(context).colorScheme.tertiary,
                  url:
                      'https://www.aaiscloud.com/HendrixC/events/EventReqForm.aspx?id=a7fcc274-cc27-4980-8cf2-ee1581df1879#viewmode%3Dedit'),
              const SizedBox(height: 10),
              ResourceButton(
                  key: const Key('CafMenuButton'),
                  titleString: "caf menu",
                  icon: Icons.food_bank,
                  color: Theme.of(context).colorScheme.primary,
                  url: menuLink),
              const SizedBox(height: 10),
              ResourceButton(
                  key: const Key('PublicSafetyButton'),
                  titleString: "call psafe",
                  icon: Icons.phone,
                  color: Theme.of(context).colorScheme.tertiary,
                  url: "tel:+15014507711"),
              const SizedBox(height: 10),
              ResourceButton(
                  key: const Key('TitleIXButton'),
                  titleString: "title IX",
                  icon: Icons.group,
                  color: Theme.of(context).colorScheme.primary,
                  url: "https://www.hendrix.edu/titleix"),
              const SizedBox(height: 10),
              ResourceButton(
                  key: const Key('WarriorEvents'),
                  titleString: "warrior games",
                  icon: Icons.scoreboard,
                  color: Theme.of(context).colorScheme.tertiary,
                  url: "https://hendrixwarriors.com/calendar"),
              const SizedBox(height: 10),
              ResourceButton(
                  key: const Key('MapButton'),
                  titleString: "map",
                  icon: Icons.map,
                  color: Theme.of(context).colorScheme.primary,
                  url: "https://www.hendrix.edu/campusmap/"),
              const SizedBox(height: 10),
              ToggleBar(
                key: const Key('DarkToggle'),
                titleString: "dark mode",
                icon: Icons.brightness_4_outlined,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: const FloatingNavButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
