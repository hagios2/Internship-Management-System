import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final bool isCollapsed;
  final double screenWidth, screenHeight;
  final Duration duration;
  final Animation<double> scaleAnimation;
  final Function onMenuTap;
  final Color background;
  final Widget child;

  Dashboard(
      {this.scaleAnimation,
      this.isCollapsed,
      this.screenHeight,
      this.screenWidth,
      this.onMenuTap,
      this.duration,
      this.background,
      this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Material(
            animationDuration: duration,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            elevation: 8,
            color: background,
            child: child),
      ),
    );
  }
}
