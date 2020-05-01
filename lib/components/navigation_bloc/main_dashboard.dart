import 'package:flutter/material.dart';
import 'package:internship_management_system/components/navigtion_bloc.dart';

class MainDashboard extends StatelessWidget with NavigationStates {
  final Function onMenuTap;
  final Color textColor;
  MainDashboard({this.onMenuTap, this.textColor});

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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
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
                    style: TextStyle(fontSize: 24, color: textColor)),
                Icon(Icons.settings, color: textColor),
              ],
            ),
            SizedBox(height: 50),
            Container(
              height: 200,
              child: PageView(
                controller: PageController(viewportFraction: 0.8),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.redAccent,
                    width: 100,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.blueAccent,
                    width: 100,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.greenAccent,
                    width: 100,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Transactions",
              style: TextStyle(color: textColor, fontSize: 20),
            ),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Macbook"),
                    subtitle: Text("Apple"),
                    trailing: Text("-2900"),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 16);
                },
                itemCount: 10)
          ],
        ),
      ),
    );
  }
}
