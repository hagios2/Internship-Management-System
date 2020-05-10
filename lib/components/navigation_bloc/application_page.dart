import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internship_management_system/constants.dart';
import 'package:internship_management_system/components/validator.dart';
import 'package:internship_management_system/components/rounded_button.dart';
import 'package:internship_management_system/services/network.dart';
import 'package:internship_management_system/screens/login_screen.dart';
import 'package:search_map_place/search_map_place.dart';
import 'dart:convert';
import '../navigtion_bloc.dart';

class ProposedApplicationPage extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Color textColor;

  ProposedApplicationPage({this.onMenuTap, this.textColor});

  @override
  _ProposedApplicationPageState createState() =>
      _ProposedApplicationPageState();
}

class _ProposedApplicationPageState extends State<ProposedApplicationPage> {
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
                      'Recommended Company',
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
                            placeholder: 'Name of Company',
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

                              // _validate:
                              // Validator(field: 'Company Name').makeValidator;
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
