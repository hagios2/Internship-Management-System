import 'package:flutter/material.dart';
import 'Screens/login_screen.dart';
import 'Screens/registration_screen.dart';
import 'Screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            body1: TextStyle(color: Colors.black54),
          ),
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
//          ChatScreen.id: (context) => ChatScreen(),
        });
  }
}
