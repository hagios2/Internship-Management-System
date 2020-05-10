import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internship_management_system/components/navigtion_bloc.dart';

class CheckInPage extends StatefulWidget {
  final Function onMenuTap;
  final Color textColor;
  CheckInPage({this.onMenuTap, this.textColor});
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  @override
  void initState() {
    super.initState();
    textColor = widget.textColor;
    onMenuTap = widget.onMenuTap;
  }

  Color textColor;
  Function onMenuTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                child: Icon(Icons.menu, color: textColor),
                onTap: onMenuTap,
              ),
              Text("Internship Application",
                  style: TextStyle(fontSize: 15, color: textColor)),
              Icon(Icons.settings, color: textColor),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 50.0,
            ),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<NavigationBloc>(context)
                    .add(menuNavigationEvents.DashboardClickedEvent);
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_back_ios,
                    size: 15.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Back',
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: <Widget>[],
          )
        ],
      ),
    );
  }
}
