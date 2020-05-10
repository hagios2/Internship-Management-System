import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../navigtion_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../rounded_button.dart';
import 'dart:async';


class DefaultApplication extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Color textColor;
  DefaultApplication({this.onMenuTap, this.textColor});
  @override
  _DefaultApplicationState createState() => _DefaultApplicationState();
}

class _DefaultApplicationState extends State<DefaultApplication> {
  @override
  void initState() {
    super.initState();
    textColor = widget.textColor;
    onMenuTap = widget.onMenuTap;
  }

  Color textColor;
  Function onMenuTap;
  String token;
  Company company;
  SharedPreferences localStorage;
  String company_id;
   List<Company> companyList = [];

  Future<List<Company>> getCompany() async {
    localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('access_token');

    http.Response response = await http.get('http://internship-management-system.herokuapp.com/api/companies');

    var companies = json.decode(response.body);

    if (response.statusCode == 200){
        print(companies['companies']);
        for (var company in companies['companies']) {
          Company com = Company(
              companyName: company["company_name"],
              companyLocation: company["location"],
              companyId: company['id'],
              availableSlots: company['total_slots']);
          companyList.add(com);
        }

        return companyList;
    }
                    
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
//          crossAxisAlignment: CrossAxisAlignment.start,
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
              left: 150.0,
              top: 50.0,
            ),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<NavigationBloc>(context)
                    .add(menuNavigationEvents.ProposeApplicationEvent);
              },
              child: Row(
                children: <Widget>[
                  Text(
                    'Propose Company',
                    style: TextStyle(color: textColor),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15.0,
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 20,
              top: 20,
            ),
            decoration: BoxDecoration(
              color: Color(0Xe5e9f0), //change the color later
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                child: FutureBuilder(
                    future: getCompany(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        
                        children = <Widget>[
                          DataTable(
                              columns: [
                                DataColumn(
                                    label: Text('Company'),
                                    numeric: false,
                                    tooltip: 'Recommended Companies'),
                                DataColumn(
                                    label: Text('Location'),
                                    numeric: false,
                                    tooltip: 'Company Location'),
                                DataColumn(
                                  label: Text('Slots'),
                                  tooltip: 'Available Slots',
                                  numeric: true,
                                ),
                              ],
                              rows: snapshot.data
                                  .map<DataRow>(
                                    (companyies) => DataRow(
                                      cells: [
                                        DataCell(
                                          ListTile(
                                            title: Text(
                                                "${companyies.companyName}"),
                                            leading: Radio(
                                              value: companyies.companyId.toString(),
                                              groupValue: 'company',
                                              onChanged: (value) {
                                                setState(() {
                                                  company_id = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        DataCell(Text(
                                            "${companyies.companyLocation}")),
                                        DataCell(Text(
                                            "${companyies.availableSlots}"))
                                      ],
                                    ),
                                  )
                                  .toList())
                        ];
                      } else if (snapshot.hasError) {
                        children = <Widget>[
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Error: ${snapshot.error}'),
                          )
                        ];
                      } else {
                        children = <Widget>[
                          SizedBox(
                            child: CircularProgressIndicator(),
                            width: 40,
                            height: 40,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting company list...'),
                          )
                        ];
                      }

                      return Container(
                          child: Column(
                        children: children,
                      ));
                    }),
              ),
            ),
          ),
               SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                buttonText: 'Register',
                onPressed: () async {
                  // final Map<String, dynamic> data = {
                  //   "name": '$name',
                  //   "email": '$email',
                  //   "phone": '$phone',
                  //   "password": '$password',
                  //   "program_id": "1",
                  //   "level_id": "1",
                  //   "index_no": '$index_no'
                  // };

                  // if (_formKey.currentState.validate()) {
                  //   //Go to registration screen.
                  //   NetworkHelper networkhelper = NetworkHelper(
                  //     url:
                  //         'http://internship-management-system.herokuapp.com/api/register',
                  //     postData: json.encode(data),
                  //   );

                  //   await networkhelper.postUserData();

                  //   Navigator.pushNamed(context, LoginScreen.id);
                  // } else {
                  //   setState(() {
                  //     _validate = true;
                  //   });
                  // }
                },
                buttonColor: Colors.blueAccent,
              ),
        ],
      ),
    );
  }
}

class Company {
  final String companyName;
  final String companyLocation;
  final int availableSlots;
  final int companyId;

  Company(
      {this.companyName,
      this.companyLocation,
      this.availableSlots,
      this.companyId});

  // factory Company.fromJson(Map<String, dynamic> json) {
  //   return Company(
  //       companyId: json['id'],
  //       companyName: json['company_name'],
  //       companyLocation: json['company_location']);
  // }
}
