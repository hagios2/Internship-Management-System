import 'package:flutter/material.dart';
import 'package:internship_management_system/components/rounded_button.dart';
import 'package:internship_management_system/components/validator.dart';
import 'package:internship_management_system/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:internship_management_system/screens/login_screen.dart';
import 'package:internship_management_system/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'dart:io' show Platform;

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Future<List<Program>> studentprograms;
  Future<List<Level>> studentLevels;

  @override
  void initState() {
    super.initState();

//    studentprograms = getPrograms();
//    print(studentprograms);
    studentLevels = getLevels();
    print(studentLevels);
  } //
//  DropdownButton<String> levelsDropdown() {
//    FutureBuilder<LevelsList>(
//        future: studentLevels,
//        builder: (context, snapshot) {
//          if (snapshot.hasData) {
//            for (int i = 0; i < snapshot.data.levels.length; i++) {
//              dropdownItem.add(
//                DropdownMenuItem(
//                  value: snapshot.data.levels[i].levelId.toString(),
//                  child: Text('${snapshot.data.levels[i].level}'),
//                ),
//              );
//            }
//          } else {
//            return Text("${snapshot.error}");
//          }
//          // By default, show a loading spinner.
//          return CircularProgressIndicator();
//        });
//
//    return DropdownButton(
//      value: level,
//      items: dropdownItem,
//      onChanged: (value) {
//        setState(() {
//          level = value;
//        });
//      },
//    );
//  }

//  DropdownButton<String> programsDropdown() {
//    List<DropdownMenuItem<String>> dropdownItem = [];
//
//    studentprograms.forEach((id, program) {
//      dropdownItem.add(
//        DropdownMenuItem(
//          value: id,
//          child: Text('${program}'),
//        ),
//      );
//    });
//
//    return DropdownButton<String>(
//      value: program,
//      style: TextStyle(),
//      items: dropdownItem,
//      onChanged: (value) {
//        setState(() {
//          program = value;
//        });
//      },
//    );
//  }

//  CupertinoPicker getProgramspicker() {
//    List<Text> programspickerItems = [];
//
//    studentprograms.forEach((id, program) {
//      programspickerItems.add(Text(program));
//    });
//
//    return CupertinoPicker(
//      backgroundColor: Colors.lightBlue,
//      itemExtent: 32,
//      children: <Widget>[],
//      onSelectedItemChanged: (selectedIndex) {},
//    );
//  }

//  CupertinoPicker getLevelspicker() {
//    List<Text> levelspickerItems = [];
//
//    studentlevels.forEach((id, level) {
//      levelspickerItems.add(Text(level));
//    });

//    return CupertinoPicker(
//      children: <Widget>[],
//      backgroundColor: Colors.lightBlue,
//      itemExtent: 32,
//      onSelectedItemChanged: (selectedIndex) {},
//    );
//  }

  String name;
  String email;
  String index_no;
  String password;
  String confirm_password;
  String program = 'Select Program';
  String level = 'Select Level';
  String phone;

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          autovalidate: _validate,
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
                  name = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Enter your name',
                ),
                validator: Validator(field: 'Name').makeValidator,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: Validator(field: 'Email').makeValidator,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                onChanged: (value) {
                  index_no = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Enter index number',
                ),
                validator: Validator(field: 'Index number').makeValidator,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                onChanged: (value) {
                  phone = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Enter phone',
                ),
                keyboardType: TextInputType.phone,
                validator: Validator(field: 'Phone').makeValidator,
              ),
              //select tag for
//              Container(
//                child:
//                    (Platform.isIOS) ? getProgramspicker() : programsDropdown(),
//              ),
              SizedBox(
                height: 8.0,
              ),

//              Container(
//                child: levelsDropdown(),
//              ),

              Container(
                child: FutureBuilder<List<Level>>(
                  future: studentLevels,
                  builder: (context, snapshot) {
                    List<Widget> children;
//                    List<DropdownMenuItem<String>> dropdownItem = [];
                    if (snapshot.hasData) {
                      print(snapshot
                          .data); //                      print(dropdownItem);
//                      return DropdownButton<String>(
//                        value: "level",
//                        items: snapshot.data
//                            .map((levels) => DropdownMenuItem(
//                                  child: Text(levels.level),
//                                  value: levels.levelId.toString(),
//                                ))
//                            .toList(),
//                        onChanged: (value) {
//                          setState(() {
//                            level = value;
//                          });
//                        },
//                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      children = <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 40.0,
                          height: 40.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting level list...'),
                        )
                      ];
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children,
                      ),
                    );
//                    return CircularProgressIndicator();
                  },
                ),
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
                height: 8.0,
              ),
              TextFormField(
                onChanged: (value) {
                  confirm_password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Confirm your password',
                ),
                validator: Validator(field: 'Confirm Password').makeValidator,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                buttonText: 'Register',
                onPressed: () async {
                  final Map<String, dynamic> data = {
                    "name": '$name',
                    "email": '$email',
                    "phone": '$phone',
                    "password": '$password',
                    "program_id": "1",
                    "level_id": "1",
                    "index_no": '$index_no'
                  };

                  if (_formKey.currentState.validate()) {
                    //Go to registration screen.
                    NetworkHelper networkhelper = NetworkHelper(
                      url:
                          'http://internship-management-system.herokuapp.com/api/register',
                      postData: json.encode(data),
                    );

                    await networkhelper.postUserData();

                    Navigator.pushNamed(context, LoginScreen.id);
                  } else {
                    setState(() {
                      _validate = true;
                    });
                  }
                },
                buttonColor: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
