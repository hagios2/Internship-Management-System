import 'package:flutter/material.dart';
import 'package:internship_management_system/components/navigtion_bloc.dart';

class NotificationPage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;
  final Color textColor;

  NotificationPage({this.onMenuTap, this.textColor});

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
              Text("Notification",
                  style: TextStyle(fontSize: 24, color: textColor)),
              Icon(Icons.settings, color: textColor),
            ],
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
