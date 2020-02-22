import 'package:flutter/material.dart';
import 'package:internship_management_system/components/rounded_button.dart';
import 'package:internship_management_system/components/validator.dart';
import 'package:internship_management_system/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:internship_management_system/screens/login_screen.dart';
import 'package:internship_management_system/services/network.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  dynamic studentprograms;
  dynamic studentLevels;
  List<DropdownMenuItem> prog = [];
  List<DropdownMenuItem> proglevels = [];

  @override
  void initState() async {
    super.initState();

    studentprograms = await getPrograms();

    studentLevels = await getLevels();
  }

  List<DropdownMenuItem> levelsDropdown() {
    studentprograms.forEach(
      (id, programs) {
        proglevels.add(
          DropdownMenuItem(
            value: id,
            child: Text('${programs}'),
          ),
        );
        return proglevels;
      },
    );
  }

  List<DropdownMenuItem> programsDropdown() {
    studentprograms.forEach(
      (id, programs) {
        prog.add(
          DropdownMenuItem(
            value: id,
            child: Text('${programs}'),
          ),
        );
//
//        CupertinoPicker(
//          backgroundColor: Colors.lightBlue,
//          itemExtent: 32,
//          onSelectedItemChanged: (selectedIndex) {},
//        );

        return prog;
      },
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
                child: DropdownButton(
                  items: prog,
                  onChanged: (value) {
                    setState(() {
                      program = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),

              Container(
                child: DropdownButton(
                  items: proglevels,
                  onChanged: (value) {
                    setState(() {
                      level = value;
                    });
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
