import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new
import 'package:hendrix_today_app/Objects/AppState.dart';
import 'package:hendrix_today_app/Widgets/ScreenContainer.dart';
import 'package:hendrix_today_app/Screens/SearchScreen.dart';
import 'package:provider/provider.dart';

import 'package:hendrix_today_app/Widgets/EventCalendar.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});
  final Color webOrange = const Color.fromARGB(255, 202, 81, 39);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: webOrange),
      //Start adding here

      initialRoute: '/home',
      routes: {
        '/home': (context) {
          return Consumer<AppState>(
              builder: (context, appState, _) => const ScreenContainer());
        },
        '/search': (context) => SearchScreen(),
        '/calendar': (context) => EventCalendar(),
        // '/testing': (context) => TestScreen(),
        '/sign-in': ((context) {
          return SignInScreen(
            actions: [
              ForgotPasswordAction(((context, email) {
                Navigator.of(context)
                    .pushNamed('/forgot-password', arguments: {'email': email});
              })),
              AuthStateChangeAction(((context, state) {
                if (state is SignedIn || state is UserCreated) {
                  var user = (state is SignedIn)
                      ? state.user
                      : (state as UserCreated).credential.user;
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            'Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              })),
            ],
          );
        }),
        '/forgot-password': ((context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

          return ForgotPasswordScreen(
            email: arguments?['email'] as String,
            headerMaxExtent: 200,
          );
        }),
        '/profile': ((context) {
          return ProfileScreen(
            providers: [],
            actions: [
              SignedOutAction(
                ((context) {
                  //Navigator.of(context).pushNamedAndRemoveUntil("/home", (r) => false)
                  //to get rid of all previous pathing and return to the original route
                  Navigator.of(context).pushReplacementNamed('/home');
                }),
              ),
            ],
          );
        })
      },
    );
  }
}
