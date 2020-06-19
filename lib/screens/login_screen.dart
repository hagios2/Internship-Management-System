import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:internship_management_system/components/rounded_button.dart';
import 'package:internship_management_system/components/validator.dart';
import 'package:internship_management_system/menu_dashboard_layout.dart';
import 'package:internship_management_system/screens/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


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
  bool isLoading = false;
  final globalkey = GlobalKey<ScaffoldState>();

    void _showMessage(Map<String, dynamic> messages){

    // var keys = Object.key
    List<Widget> children = [];

    messages.forEach((key, value)
    {
      children.add(Text("$key: $value", style: TextStyle(color: Colors.red),));
    });
    
    final snackbar = SnackBar(content: Container(
      height: 100.0,
      child: ListView(children: children,
      ),
    ), action: SnackBarAction(label: 'Close', onPressed: (){}), backgroundColor: Colors.white,);
    globalkey.currentState.showSnackBar(snackbar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalkey,
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
              ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.blueGrey,
                      ),
                      title:  TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter your email',
                          ),
                          validator: Validator(field: 'Email').makeValidator,
                        ),
                    ),
              SizedBox(
                height: 8.0,
              ),
                ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.blueGrey,
                      ),
                      title:      TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter your password.',
                        ),
                        validator: Validator(field: 'Password').makeValidator,
                      ),
                    ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  buttonColor: Colors.lightBlueAccent,
                  buttonText: isLoading ? 'Loading...':'Login',
                  onPressed: () async {

                        setState(() {
                          isLoading = true;
                        });

                    if (_formKey.currentState.validate()) {
                      String url =
                          "http://internship-management-system.herokuapp.com/oauth/token";
                      var postData = {
                        "username": "$email",
                        "grant_type": "password",
                        "password": "$password",
                        "scope": "*",
                        "client_id": "1",
                        "client_secret":
                            "aVIWPjhpGgweKfK62OSocQH0HmEfaTspAt7mTt90"
                      };
                      http.Response response = await http.post(
                        url,
                        body: postData,
//                        headers: {
//                          HttpHeaders.contentTypeHeader: "application/json"
                      );

                         var data = json.decode(response.body);

                          setState(() {
                              isLoading = false;
                            });

                      if (response.statusCode == 200) {

                        if (data['access_token'] != '') {

                          String token = data['access_token'];

                          SharedPreferences localStorage =
                              await SharedPreferences.getInstance();

                          await localStorage.setString('access_token', token);

                          url =
                              "http://internship-management-system.herokuapp.com/api/user";

                          http.Response response =
                              await http.get(url, headers: {
                            'Authorization': "Bearer $token",
                            "Accept": "application/json",
                            "Content-type": "application/json"
                          });

                          if (response.statusCode == 200) {
                            await localStorage.setString('user', json.encode(response.body));
                          }
                           

                          Navigator.pushNamed(context, MenuDashboardPage.id);
                          setState(() {
                            _validate = true;
                          });
                        } 
                      }else{
                        print(data);
                        _showMessage(data); 
                    }
                      //Go to login screen.
                    }else{
                        setState(() {
                          isLoading = false;
                        });
                    }
              
                  }),

                  SizedBox(height: 10,),

                  Text('Not having an account?'),

                  GestureDetector(child: Text('Register', style: TextStyle(color: Colors.blue)),
                   onTap:(){
                     Navigator.pushNamed(context, RegistrationScreen.id);
                   } ,)
            ],
          ),
        ),
      ),
    );
  }
}
