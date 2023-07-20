import 'package:flutter/material.dart';

import 'package:hendrix_today_app/widgets/floating_nav_buttons.dart';
import 'package:hendrix_today_app/widgets/resource_button.dart';

import '../widgets/root_app.dart';

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

    bool darkmode = Theme.of(context).brightness == Brightness.dark;

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
              const SizedBox(height: 20),
              ResourceButton(
                  key: const Key('SubmitEventButton'),
                  titleString: "submit new event",
                  icon: Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                  url:
                      'https://forms.office.com/Pages/ResponsePage.aspx?id=jMH2DNLQP0qD0GY9Ygpj020T9lhtzfhCi8WBPrgNg0xURFZXMEEyUzUwR0lNSzZTTDdWWEQwOERSWiQlQCN0PWcu'),
              const SizedBox(height: 20),
              ResourceButton(
                  key: const Key('CafMenuButton'),
                  titleString: "caf menu today",
                  icon: Icons.food_bank,
                  color: Theme.of(context).colorScheme.tertiary,
                  url: menuLink),
              const SizedBox(height: 20),
              ResourceButton(
                  key: const Key('PublicSafetyButton'),
                  titleString: "public safety",
                  icon: Icons.phone,
                  color: Theme.of(context).colorScheme.primary,
                  url: "tel:+5014507711"),
              const SizedBox(height: 20),
              ResourceButton(
                  key: const Key('MapButton'),
                  titleString: "campus map",
                  icon: Icons.map,
                  color: Theme.of(context).colorScheme.tertiary,
                  url: "https://www.hendrix.edu/campusmap/"),
              const SizedBox(height: 30),
              SizedBox(
                height: 60,
                width: 300,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    elevation: 5,
                    color: Theme.of(context).colorScheme.tertiary,
                    child: SwitchListTile(
                      title: Text(
                        'dark mode',
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                      value: darkmode,
                      onChanged: (bool value) => RootApp.toggleTheme(context),
                      secondary: Icon(Icons.brightness_4_outlined,
                          color: Theme.of(context).iconTheme.color),
                    )),
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
