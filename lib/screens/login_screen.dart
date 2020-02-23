import 'package:flutter/material.dart';
import 'package:internship_management_system/components/rounded_button.dart';
import 'package:internship_management_system/components/validator.dart';
import 'package:internship_management_system/constants.dart';
import 'package:internship_management_system/services/network.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
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
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Enter your email',
                ),
                validator: Validator(field: 'Email').makeValidator,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Enter your password.',
                ),
                validator: Validator(field: 'Password').makeValidator,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                buttonText: 'Login',
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    NetworkHelper networkhelper = NetworkHelper(
                      url:
                          'http://internship-management-system.herokuapp.com/api/oauth/token',
                      postData: {
                        "username": email,
                        "grant_type": "password",
                        "password": password,
                        "provider": "users",
                        "client_id": "1",
                        "client_secret":
                            "FzMJLeA0KouA0FcVSQXwTKVcS2p9PnAaQXgsRxBl",
                      },
                    );

                    networkhelper.postUserData();

                    Navigator.pushNamed(context, LoginScreen.id);
                    setState(() {
                      _validate = true;
                    });
                  }
                  //Go to login screen.
                },
                buttonColor: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
