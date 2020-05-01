import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_management_system/components/menu.dart';
import 'package:internship_management_system/components/dashboad.dart';
import 'package:internship_management_system/components/navigation_bloc/application_page.dart';
import 'package:internship_management_system/components/navigation_bloc/main_dashboard.dart';
import 'package:internship_management_system/components/navigtion_bloc.dart';

final Color backgroundColor = Colors.white;
final Color textColor = Color(0xFF4A4A58);

class MenuDashboardPage extends StatefulWidget {
  static const String id = 'dashboard_id';

  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  void onMenuTap() {
    setState(() {
      if (isCollapsed)
        _controller.forward();
      else
        _controller.reverse();

      isCollapsed = !isCollapsed;
    });
  }

  onMenuTapAction() {
    setState(() {
      _controller.reverse();
    });

    isCollapsed = !isCollapsed;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocProvider<NavigationBloc>(
        create: (context) =>
            NavigationBloc(onMenuTap: onMenuTap, textColor: textColor),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
                builder: (context, NavigationStates navigationState) {
              return Menu(
                menuScaleAnimation: _menuScaleAnimation,
                slideAnimation: _slideAnimation,
                textColor: textColor,
                selectedIndex: findSelectedIndex(navigationState),
                onMenuTapAction: onMenuTapAction,
              );
            }),
            Dashboard(
              onMenuTap: onMenuTap,
              duration: duration,
              isCollapsed: isCollapsed,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              scaleAnimation: _scaleAnimation,
              background: backgroundColor,
              child: BlocBuilder<NavigationBloc, NavigationStates>(
                  builder: (context, NavigationStates navigationState) {
                return navigationState as Widget;
              }),
            ),
          ],
        ),
      ),
    );
  }

  findSelectedIndex(NavigationStates navigationStates) {
    if (navigationStates is MainDashboard) {
      return 0;
    } else if (navigationStates is Notification) {
      return 1;
    } else if (navigationStates is ApplicationPage) {
      return 2;
//    } else if (navigationStates is Notification) {
//      return 3;
//    } else if (navigationStates is Notification) {
//      return 4;
    } else {
      return 0;
    }
  }
}
