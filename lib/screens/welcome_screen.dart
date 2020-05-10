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
            Container(
              height: 200,
              child: PageView(
                controller: PageController(viewportFraction: 0.8),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                children: <Widget>[
//                Container(child: ,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.redAccent,
                    width: 100,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.blueAccent,
                    width: 100,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.greenAccent,
                    width: 100,
                  ),
                ],
              ),
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
