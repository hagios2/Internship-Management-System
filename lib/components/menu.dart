import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:internship_management_system/components/navigtion_bloc.dart';

class Menu extends StatelessWidget {
  // Animation<double> _scaleAnimation;
  final Animation<double> menuScaleAnimation;
  final Animation<Offset> slideAnimation;
  final Color textColor;
  final int selectedIndex;
  final Function onMenuTapAction;
  Menu(
      {this.menuScaleAnimation,
      this.slideAnimation,
      this.textColor,
      this.selectedIndex,
      @required this.onMenuTapAction});

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
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(menuNavigationEvents.DashboardClickedEvent);
                    onMenuTapAction();
                  },
                  child: Text("Dashboard",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 22,
                          fontWeight: (selectedIndex == 0)
                              ? FontWeight.bold
                              : FontWeight.normal)),
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
                          fontSize: 22,
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
                          fontSize: 22,
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
                        .add(menuNavigationEvents.ApplicationclickedEvent);
                    onMenuTapAction();
                  },
                  child: Text("Logout",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 22,
                          fontWeight: (selectedIndex == 0)
                              ? FontWeight.bold
                              : FontWeight.normal)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
