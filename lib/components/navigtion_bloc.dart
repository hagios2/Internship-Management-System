import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internship_management_system/components/navigation_bloc/main_dashboard.dart';
import 'package:internship_management_system/components/navigation_bloc/application_page.dart';
import 'package:internship_management_system/components/navigation_bloc/notification.dart';
import 'package:internship_management_system/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigation_bloc/default_application.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum menuNavigationEvents {
  DashboardClickedEvent,
  NotificationClickedEvent,
  LogoutClickedEvent,
  ApplicationclickedEvent,
  ProposeApplicationEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<menuNavigationEvents, NavigationStates> {
  final Function onMenuTap;
  final Color textColor;

  NavigationBloc({this.onMenuTap, this.textColor});

  @override
  NavigationStates get initialState => MainDashboard(
        onMenuTap: onMenuTap,
        textColor: textColor,
      );

  @override
  Stream<NavigationStates> mapEventToState(menuNavigationEvents event) async* {
    switch (event) {
      case menuNavigationEvents.DashboardClickedEvent:
        yield MainDashboard(onMenuTap: onMenuTap, textColor: textColor);
        break;

      case menuNavigationEvents.NotificationClickedEvent:
        yield NotificationPage(onMenuTap: onMenuTap, textColor: textColor);
        break;

      case menuNavigationEvents.ApplicationclickedEvent:
        yield DefaultApplication(onMenuTap: onMenuTap, textColor: textColor);
        break;

      case menuNavigationEvents.ProposeApplicationEvent:
        yield ProposedApplicationPage(
          textColor: textColor,
          onMenuTap: onMenuTap,
        );
        break;

      case menuNavigationEvents.LogoutClickedEvent:
        loggout();
        break;
    }
  }

  void loggout() async* {

      SharedPreferences localStorage = await SharedPreferences.getInstance();

      String token = localStorage.getString('access_token');
 
    http.Response response = await http.post('https://internship-management-system.herokuapp.com/api/logout',headers: {
      'Authorization': 'Bearer $token',
      'content-type': 'Application/json'
    });

    var body = json.decode(response.body);

    if(response.statusCode == 200){

      localStorage.remove('user');

      localStorage.remove('access_tokekn');

       yield  WelcomeScreen(
          // textColor: textColor,
          // onMenuTap: onMenuTap,
        );
    }

  }
}


