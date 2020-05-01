import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:internship_management_system/components/rounded_button.dart';
import 'package:internship_management_system/components/validator.dart';
import 'package:internship_management_system/constants.dart';
import 'package:internship_management_system/menu_dashboard_layout.dart';
import 'package:internship_management_system/services/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';

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
      appBar: AppBar(
        title: Text('Login'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 120.0,
                  child: Image.asset('images/logo.jpg'),
                ),
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
                validator: Validator(field: 'Name').makeValidator,
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
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    String url =
                        "http://internship-management-system.herokuapp.com/oauth/token";
                    var postData = {
                      "username": "$email",
                      "grant_type": "password",
                      "password": "$password",
                      "scope": "*",
                      "client_id": "3",
                      "client_secret":
                          "J47UBbLJw0FtQFfCRdIueKb48yDPxkg0iiEWi2TT"
                    };
                    http.Response response = await http.post(
                      url,
                      body: postData,
//                        headers: {
//                          HttpHeaders.contentTypeHeader: "application/json"
                    );
                    if (response.statusCode == 200) {
                      var data = json.decode(response.body);

//                      print(data);
                      if (data['access_token'] != '') {
//                      hasError = true;
                        String token = data['access_token'];

                        print(token);

                        SharedPreferences localStorage =
                            await SharedPreferences.getInstance();

                        //save token
                        await localStorage.setString('access_token', token);

                        //  get user info
                        NetworkHelper getUser = NetworkHelper(
                            url:
                                "http://internship-management-system.herokuapp.com/api/user",
                            headers: {
                              HttpHeaders.authorizationHeader: "Bearer $token"
//                              HttpHeaders.contentTypeHeader: "application/json"
                            });
                        String body = await getUser.getData();

                        print(body);
                      } else {
                        print(response.statusCode);
                      }

                      bool hasError = true;

//                      if (body.containsKey(key))
                      Navigator.pushNamed(context, MenuDashboardPage.id);
                      setState(() {
                        _validate = true;
                      });
                    } else {
                      setState(() {
                        _validate = false;
                      });
                    }
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
