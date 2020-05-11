import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'menu_dashboard_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: WelcomeScreen.id,
//         routes: {
//           WelcomeScreen.id: (context) => WelcomeScreen(),
//           LoginScreen.id: (context) => LoginScreen(),
//           RegistrationScreen.id: (context) => RegistrationScreen(),
//           MenuDashboardPage.id: (context) => MenuDashboardPage(),
// //          ChatScreen.id: (context) => ChatScreen(),
//         });
//   }
// }


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    @override
  void initState() {
    super.initState();

    _getLocalStorage();
  }

  void _getLocalStorage() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token');

    print(token);

    if(localStorage.containsKey('token'))
    {
      setState(() {
           isSignedIn = true;
      });
    }else{
      setState(() {
           isSignedIn = false;
      });
    }

  }

  bool isSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: isSignedIn ? MenuDashboardPage.id : WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          MenuDashboardPage.id: (context) => MenuDashboardPage(),
//          ChatScreen.id: (context) => ChatScreen(),
        });
  }
}