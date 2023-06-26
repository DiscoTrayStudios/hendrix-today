import 'package:flutter/material.dart';
import 'package:hendrix_today_app/widgets/resource_button.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
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

    return Center(
        child: Column(children: <Widget>[
      const SizedBox(height: 100),
      const ResourceButton(
          titleString: "submit new event",
          icon: Icons.add,
          color: Color.fromARGB(255, 202, 81, 39),
          url:
              'https://forms.office.com/Pages/ResponsePage.aspx?id=jMH2DNLQP0qD0GY9Ygpj020T9lhtzfhCi8WBPrgNg0xURFZXMEEyUzUwR0lNSzZTTDdWWEQwOERSWiQlQCN0PWcu'),
      const SizedBox(height: 30),
      ResourceButton(
          titleString: "caf menu today",
          icon: Icons.food_bank,
          color: Colors.black,
          url: menuLink),
      const SizedBox(height: 30),
      const ResourceButton(
          titleString: "public safety",
          icon: Icons.phone,
          color: Color.fromARGB(255, 202, 81, 39),
          url: "tel:+5014507711"),
    ]));
  }
}
