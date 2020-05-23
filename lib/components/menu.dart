import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:internship_management_system/components/navigtion_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Menu extends StatefulWidget {
  Menu(
      {this.menuScaleAnimation,
      this.slideAnimation,
      this.textColor,
      this.selectedIndex,
      @required this.onMenuTapAction});

  final Animation<double> menuScaleAnimation;
  final Animation<Offset> slideAnimation;
  final Color textColor;
  final int selectedIndex;
  final Function onMenuTapAction;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // Animation<double> _scaleAnimation;
  Animation<double> menuScaleAnimation;
  Animation<Offset> slideAnimation;
  Color textColor;
  int selectedIndex;
  Function onMenuTapAction;
  String User;
  SharedPreferences localStorage;

  @override
  void initState() {
    menuScaleAnimation = widget.menuScaleAnimation;
    slideAnimation = widget.slideAnimation;
    textColor = widget.textColor;
    selectedIndex = widget.selectedIndex;
    onMenuTapAction = widget.onMenuTapAction;

    super.initState();
  }

  getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    if (localStorage.containsKey('user')) {
      setState(() {
        User = json.decode(localStorage.getString('user'));
      });
      return Container(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage('images/noimage.jpg'),
              child: Text(''),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 1.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//                FutureBuilder(
//                  future: ,
//                )
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(menuNavigationEvents.DashboardClickedEvent);
                    onMenuTapAction();
                  },
                   child:  ListTile(
                      leading: Icon(
                        Icons.dashboard,
                        color: Colors.blueGrey,
                      ),
                      title: Text(
                        'Dashboard',
                        style: TextStyle(
                            fontSize: 18.0,
                              fontWeight: (selectedIndex == 0)
                              ? FontWeight.bold
                              : FontWeight.normal,
                           /*  fontFamily: 'Source Sans Pro', */
                            color: Colors.blueGrey),
                      ),
                    )
                   
                    //Text("Dashboard",
                  //     style: TextStyle(
                  //         color: textColor,
                  //         fontSize: 22,
                        //),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(menuNavigationEvents.NotificationClickedEvent);
                    onMenuTapAction();
                  },
                  child: Text("Notification",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: (selectedIndex == 1)
                              ? FontWeight.bold
                              : FontWeight.normal)),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(menuNavigationEvents.ApplicationclickedEvent);
                    onMenuTapAction();
                  },
                  child: Text("Appplication",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: (selectedIndex == 2)
                              ? FontWeight.bold
                              : FontWeight.normal)),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(menuNavigationEvents.ApplicationclickedEvent);
                    onMenuTapAction();
                  },
                  child: Text("Appliation",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 22,
                          fontWeight: (selectedIndex == 3)
                              ? FontWeight.bold
                              : FontWeight.normal)),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(menuNavigationEvents.ApplicationclickedEvent);
                    onMenuTapAction();
                  },
                  child: Text("Branches",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 22,
                          fontWeight: (selectedIndex == 4)
                              ? FontWeight.bold
                              : FontWeight.normal)),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(menuNavigationEvents.LogoutClickedEvent);
                    onMenuTapAction();
                  },
                  child: ListTile(
                      leading: Icon(
                        Icons.dashboard,
                        color: Colors.blueGrey,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 18.0,
                              fontWeight: (selectedIndex == 5)
                              ? FontWeight.bold
                              : FontWeight.normal,
                           /*  fontFamily: 'Source Sans Pro', */
                            color: Colors.blueGrey),
                      ),
                    )
                  //Text("Logout",
                  //     style: TextStyle(
                  //         color: textColor,
                  //         fontSize: 22,
                  //         fontWeight: (selectedIndex == 0)
                  //             ? FontWeight.bold
                  //             : FontWeight.normal)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
