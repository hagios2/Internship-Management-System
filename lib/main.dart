import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'menu_dashboard_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
    bool isSignedIn = false;
    String token = '';

    @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _getLocalStorage(context));
  }

  void _getLocalStorage(BuildContext context) async{

    SharedPreferences localStorage = await SharedPreferences.getInstance();

      setState(() {
         token = localStorage.getString('access_token');
      });
 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: (token !=  null) ? MenuDashboardPage.id : WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          MenuDashboardPage.id: (context) => MenuDashboardPage(),
//          ChatScreen.id: (context) => ChatScreen(),
        });
  }
}