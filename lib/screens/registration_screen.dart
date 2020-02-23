import 'package:flutter/material.dart';
import 'package:internship_management_system/components/rounded_button.dart';
import 'package:internship_management_system/components/validator.dart';
import 'package:internship_management_system/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:internship_management_system/screens/login_screen.dart';
import 'package:internship_management_system/services/network.dart';
import 'dart:io' show Platform;

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  dynamic studentprograms = [];
  dynamic studentLevels = [];

  @override
  void initState() {
    super.initState();

    getRegistrationData();
  }

  Future getRegistrationData() async {
    studentprograms = await getPrograms();

    studentLevels = await getLevels();
  }

  DropdownButton<String> levelsDropdown() {
    List<DropdownMenuItem<String>> dropdownItem = [];

    var temp;
    studentLevels.forEach((id, level) {
      temp = DropdownMenuItem(
        value: id,
        child: Text('${level}'),
      );

      dropdownItem.add(temp);
    });

    return DropdownButton(
      value: level,
      items: dropdownItem,
      onChanged: (value) {
        setState(() {
          level = value;
        });
      },
    );
  }

  DropdownButton<String> programsDropdown() {
    List<DropdownMenuItem<String>> dropdownItem = [];

    var tempItem;

    studentprograms.forEach((id, program) {
      tempItem = DropdownMenuItem(
        value: id,
        child: Text('${program}'),
      );
      dropdownItem.add(tempItem);
    });

    return DropdownButton<String>(
      value: program,
      style: TextStyle(),
      items: dropdownItem,
      onChanged: (value) {
        setState(() {
          program = value;
        });
      },
    );
  }

  CupertinoPicker getProgramspicker() {
    List<Text> programspickerItems = [];

    studentprograms.forEach((id, program) {
      programspickerItems.add(Text(program));
    });

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {},
    );
  }

  CupertinoPicker getLevelspicker() {
    List<Text> levelspickerItems = [];

    studentprograms.forEach((id, level) {
      levelspickerItems.add(Text(level));
    });

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {},
    );
  }

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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          autovalidate: _validate,
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
              Container(
                child: (Platform.isAndroid)
                    ? getProgramspicker()
                    : programsDropdown(),
              ),
              SizedBox(
                height: 8.0,
              ),

              Container(
                child: (Platform.isIOS) ? getLevelspicker() : levelsDropdown(),
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
                  if (_formKey.currentState.validate()) {
                    //Go to registration screen.
                    NetworkHelper networkhelper = NetworkHelper(
                      url:
                          'http://internship-management-system.herokuapp.com/api/register',
                      postData: {
                        "name": name,
                        "email": email,
                        "phone": phone,
                        "password": password,
                        "program_id": program,
                        "level_id": level,
                        "index_no": index_no
                      },
                    );

                    networkhelper.postUserData();

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
