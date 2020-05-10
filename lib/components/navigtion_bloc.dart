import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internship_management_system/components/navigation_bloc/main_dashboard.dart';
import 'package:internship_management_system/components/navigation_bloc/application_page.dart';
import 'package:internship_management_system/components/navigation_bloc/notification.dart';
import 'navigation_bloc/default_application.dart';

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
        break;
    }
  }
}
