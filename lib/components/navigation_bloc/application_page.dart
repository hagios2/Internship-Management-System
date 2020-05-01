import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internship_management_system/constants.dart';
import 'package:internship_management_system/components/validator.dart';
import 'package:internship_management_system/components/rounded_button.dart';
import 'package:internship_management_system/services/network.dart';
import 'package:internship_management_system/screens/login_screen.dart';
import 'package:search_map_place/search_map_place.dart';
import 'dart:convert';

import '../navigtion_bloc.dart';

class ApplicationPage extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Color textColor;

  ApplicationPage({this.onMenuTap, this.textColor});

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  void initState() {
    super.initState();
    textColor = widget.textColor;
    onMenuTap = widget.onMenuTap;
  }

  Color textColor;
  Function onMenuTap;
  String company_name;
  String company_location;
  int region_of_company;
  String company_email;
  String lat;
  String long;

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

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
                Text("Application",
                    style: TextStyle(fontSize: 24, color: textColor)),
                Icon(Icons.settings, color: textColor),
              ],
            ),
            FlatButton(onPressed: null, child: Icon(Icons.arrow_forward_ios)),
            Form(
              key: _formKey,
              autovalidate: _validate,
              child: Expanded(
                child: ListView(children: <Widget>[
                  SizedBox(
                    height: 300.00,
                    child: Stack(children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(24.142, -110.321), zoom: 10),
                      ),
                      Container(
                        child: ListView(children: [
                          SearchMapPlaceWidget(
                            apiKey: gMapsKey,
                            language: "en",
                            placeholder: 'Company Address',
                            onSelected: (Place place) async {
                              final geolocation = await place.geolocation;

                              // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom

                              var _mapController;
                              final GoogleMapController controller =
                                  await _mapController.future;
                              controller.animateCamera(CameraUpdate.newLatLng(
                                  geolocation.coordinates));
                              controller.animateCamera(
                                  CameraUpdate.newLatLngBounds(
                                      geolocation.bounds, 0));

                              _validate:
                              Validator(field: 'Company Email').makeValidator;
                            },
                          ),
                        ]),
                      ),
                    ]),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            company_name = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Name of Company',
                          ),
                          validator: Validator(field: 'Name').makeValidator,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            company_email = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Company Email',
                          ),
                          validator:
                              Validator(field: 'Company Email').makeValidator,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            company_location = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Region',
                          ),
                          validator: Validator(field: 'Region').makeValidator,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RoundedButton(
                    buttonText: 'Submit',
                    onPressed: () async {
                      final Map<String, dynamic> data = {
                        "company_name": '$company_name',
                        "company_email": '$company_email',
                        "company_location": "$company_location",
//                        "company_city": "$company_",
                      };
                      if (_formKey.currentState.validate()) {
                        //Go to registration screen.
                        NetworkHelper networkhelper = NetworkHelper(
                          url:
                              'http://internship-management-system.herokuapp.com/api/register',
                          postData: json.encode(data),
                        );

                        Navigator.pushNamed(context, LoginScreen.id);
                      } else {
                        setState(() {
                          _validate = true;
                        });
                      }
                    },
                    buttonColor: Colors.blueAccent,
                  ),
                ]),
              ),
            ),
          ]),
    );

    Widget defaultApplication() {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Metro Tv'),
              leading: Radio(
                value: '1',
                groupValue: 'company',
                onChanged: (value) {
                  setState(() {
                    company_name = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Ghana Gas Ltd.'),
              leading: Radio(
                value: '2',
                groupValue: 'company',
                onChanged: (value) {
                  setState(() {
                    company_name = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Ghana Tech Lab'),
              leading: Radio(
                value: '3',
                groupValue: 'company',
                onChanged: (value) {
                  setState(() {
                    company_name = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Ghana Tech Lab'),
              leading: Radio(
                value: '4',
                groupValue: 'company',
                onChanged: (value) {
                  setState(() {
                    company_name = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Ghana Tech Lab'),
              leading: Radio(
                value: '5',
                groupValue: 'company',
                onChanged: (value) {
                  setState(() {
                    company_name = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Ghana Tech Lab'),
              leading: Radio(
                value: '6',
                groupValue: 'company',
                onChanged: (value) {
                  setState(() {
                    company_name = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Ghana Tech Lab'),
              leading: Radio(
                value: '7',
                groupValue: 'company',
                onChanged: (value) {
                  setState(() {
                    company_name = value;
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
  }

/*_addMarker() {
    var marker = MarkerOptions(
        position: mapController.cameraPosition.target,
        icon: BitmapDescriptor.defaultMarker,
        infoWindowText: infoWindowText('I am here'));
  }
}
*/
}