import 'package:flutter/material.dart';
import 'package:internship_management_system/components/rounded_button.dart';
import 'package:internship_management_system/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:internship_management_system/services/network.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  dynamic studentprograms = getPrograms();

  List prog = [''];

  String name;
  String email;
  String index_no;
  String password;
  String confirm_password;
  String program = 'Select Program';
  String level = 'Select Level';
  int level_id;
  int program_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200.0,
              child: Image.asset('images/logo.jpg'),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your name',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                index_no = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter index number',
              ),
            ),
            //select tag for
            Container(
              child: DropdownButton(
                items: [
                  DropdownMenuItem(
                    value: '1',
                    child: Text('Eomputer Engineering'),
                  ),
                ],
                onChanged: (value) {
//                    program_id =

                  setState(() {
                    program = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password.',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                confirm_password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Confirm your password',
              ),
            ),
            SizedBox(
              height: 24.0,
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
