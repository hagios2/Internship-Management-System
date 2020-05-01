import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:internship_management_system/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(animationController);

    animationController.forward();

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Center(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.jpg'),
                      height: 60.0,
                    ),
                  ),
                ),
                Text(
                  'Internship',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              buttonText: 'Login',
              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
              buttonColor: Colors.lightBlueAccent,
            ),
            RoundedButton(
              buttonText: 'Register',
              onPressed: () {
                //Go to registration screen.
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              buttonColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
