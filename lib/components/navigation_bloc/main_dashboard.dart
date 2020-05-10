import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_management_system/components/navigtion_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDashboard extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Color textColor;

  MainDashboard({this.onMenuTap, this.textColor});
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  Color textColor;
  Function onMenuTap;
  var User;

  @override
  void initState() {
    super.initState();

    textColor = widget.textColor;
    onMenuTap = widget.onMenuTap;

    getUser();
  }

  getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setState(() {
      User = json.decode(localStorage.getString('user'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                child: Icon(Icons.menu, color: textColor),
                onTap: onMenuTap,
              ),
              Text("Dashboard",
                  style: TextStyle(fontSize: 15, color: textColor)),
              Icon(Icons.settings, color: textColor),
            ],
          ),
          SizedBox(height: 50),
//          Container(child: Text("Welcome $User['name']")),
          Container(
            child: Column(
              children: <Widget>[
                Text('Internship Application'),
                SizedBox(height: 20),
                FlatButton(
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(menuNavigationEvents.ApplicationclickedEvent);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
