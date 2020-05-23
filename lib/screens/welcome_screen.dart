import 'package:introduction_screen/introduction_screen.dart';
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
  final introKey = GlobalKey<IntroductionScreenState>();
      static const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      // bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );


  List<PageViewModel> _getPages()
  {
    return [
     
         PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('intv.jpeg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Learn as you go",
          body:
              "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('int12.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kids and teens",
          body:
              "Kids and teens can track their stocks 24/7 and place trades that you approve.",
           image: _buildImage('int.png'),
          decoration: pageDecoration,
        ),

        PageViewModel(
          title: "Kids and teens",
          body:
              "Kids and teens can track their stocks 24/7 and place trades that you approve.",
           image: _buildImage('inm.jpeg'),
          decoration: pageDecoration,
        ),

    ];
  }
    Widget _buildImage(String assetName) {
      
    return Align(
      child: Image.asset('images/$assetName', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: animation.value,
      body: IntroductionScreen(
        key: introKey,
        pages: _getPages(),
        onDone: () {

          Navigator.pushNamed(context, LoginScreen.id);
        },
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
        
        /* done: Text('Done', style: TextStyle(color: Colors.blueGrey),
         */
   
     //   
   //   ),
      // body: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 24.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: <Widget>[
            /* Row(
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
            ), */
//             SizedBox(
//               height: 48.0,
//             ),
//             Container(
//               height: 200,
//               child: PageView(
//                 controller: PageController(viewportFraction: 0.8),
//                 scrollDirection: Axis.horizontal,
//                 pageSnapping: true,
//                 children: <Widget>[
// //                Container(child: ,),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 8),
//                     color: Colors.redAccent,
//                     width: 100,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 8),
//                     color: Colors.blueAccent,
//                     width: 100,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 8),
//                     color: Colors.greenAccent,
//                     width: 100,
//                   ),
//                 ],
//               ),
//             ),
//             RoundedButton(
//               buttonText: 'Login',
//               onPressed: () {
//                 //Go to login screen.
//                 Navigator.pushNamed(context, LoginScreen.id);
//               },
//               buttonColor: Colors.lightBlueAccent,
//             ),
//             RoundedButton(
//               buttonText: 'Register',
//               onPressed: () {
//                 //Go to registration screen.
//                 Navigator.pushNamed(context, RegistrationScreen.id);
//               },
//               buttonColor: Colors.blueAccent,
//             ),
//           ],
//         ),
//       ),
    
      ));
  }
}
