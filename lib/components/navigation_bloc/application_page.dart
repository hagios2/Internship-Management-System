import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internship_management_system/constants.dart';
import 'package:internship_management_system/components/validator.dart';
import 'package:internship_management_system/components/rounded_button.dart';
import 'package:http/http.dart' as http;
import 'package:internship_management_system/menu_dashboard_layout.dart';
//import 'package:internship_management_system/screens/login_screen.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  final _formKey = GlobalKey<FormState>();

  final globalkey = GlobalKey<ScaffoldState>();


  Color textColor;
  Function onMenuTap;
  String company_name;
  String company_location;
  int region_of_company;
  String company_email;
  var region_id;
  double lat;
  double long;

    Future<List<Region>> getRegions() async {
    http.Response response = await http
        .get('https://internship-management-system.herokuapp.com/api/regions');

    if (response.statusCode == 200) {

      print(response.body);
    
      List<Region> regionsList = [];

      for (var regions in json.decode(response.body)) {
        Region region = Region(regionId: regions["id"], region: regions["region"]);

        regionsList.add(region);
      }

      return regionsList;
    
    } else {
      print(response.body);
    }
  }


  void _showMessage(Icon msgIcon, messages){
  
    final snackbar = SnackBar(content: Container(
        height: 100.0,
        child:  ListTile(
                      leading: msgIcon,
                      title: Text(messages),  
                    ),
        ),
      action: SnackBarAction(label: 'Close', onPressed: (){}), backgroundColor: Colors.white,);
      globalkey.currentState.showSnackBar(snackbar);
  }
  
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
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

                                setState(() {
                                  
                                  company_name = place.description;

                                  lat = geolocation.coordinates.latitude;

                                  long = geolocation.coordinates.longitude;

                                });
                           
                                // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom

                                var _mapController;
                                final GoogleMapController controller = await _mapController.future;

                                controller.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
                                controller.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                              },
                            ),
                          ]),
                        ),
                      ]),
                    ),
                     ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.blueGrey,
                      ),
                      title: TextFormField(
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

                        SizedBox(height: 20,),
                      ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.blueGrey,
                      ),
                      title: TextFormField(
                            onChanged: (value) {
                              company_location = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Location',
                            ),
                            validator:
                                Validator(field: 'Company Location').makeValidator,
                          ),
                        ),
                    SizedBox(height: 20,),

                       ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.blueGrey,
                      ),
                      title: TextFormField(
                            onChanged: (value) {
                              company_location = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Location',
                            ),
                            validator:
                                Validator(field: 'Company Location').makeValidator,
                          ),
                        ),
                    

                SizedBox(height: 20,),

                ListTile(
                leading: Icon(
                  Icons.location_city,
                  color: Colors.blueGrey,
                ),
                title:   Container(
                child: FutureBuilder(
                  future: getRegions(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List<Widget> children;

                    if (snapshot.hasData) {
                      children = <Widget>[
                        DropdownButtonFormField(
                          hint: Text('Select Region'),
                          value: region_id,
                           validator: (region) => region_id== null ? 'Region is required' : null,
                            onChanged: (selectedRegion) {
                              setState(() {
                                region_id = selectedRegion;
                              });
                            },
                            // value: level,
                            items: snapshot.data
                                .map<DropdownMenuItem>((menuItems) =>
                                    DropdownMenuItem(
                                      child: Text("${menuItems.region}"),
                                      value: "${menuItems.regionId.toString()}",
                                    ))
                                .toList())
                      ];
                    } else if (snapshot.hasError) {
                      children = <Widget>[
                       Row(children: <Widget>[
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text('Error: Failed to load regions'),
                          ),
                       ],),
                      ];
                    } else {
                      children = <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 40.0,
                          height: 40.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting region list...'),
                        )
                      ];
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children,
                      ),
                    );
                  },
                ),
              ),
              ),
              SizedBox(height: 20),
                    RoundedButton(
                      buttonText: 'Apply',
                      onPressed: () async {

                        if (_formKey.currentState.validate()) {

                          final data = {
                          "preferred_company_name": '$company_name',
                          "preferred_company_email": '$company_email',
                          "preferred_company_location": "$company_location",
                          "preferred_company_city": "$region_id",
                          "preferred_company_latitude": "$lat",
                          "preferred_company_longitude": "$long",
                          "preferred_company": true
                        };

                         SharedPreferences localStorage = await SharedPreferences.getInstance();

                         String token = localStorage.getString('access_token');
                          //Go to registration screen.
                         var headers = { 'Accept':'application/json','Authorization': "Bearer $token",};
                         
                         http.Response response = await http.post(
                                'http://internship-management-system.herokuapp.com/api/student-application',
                            body: data, headers: headers
                         );

                        if(response.statusCode == 200){

                          var data = json.decode(response.body);

                          if(data['status'] == 'success')
                          {
                            _showMessage(
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              data['status']
                              
                            );

                              Navigator.pushNamed(context, MenuDashboardPage.id);

                          }else{

                              _showMessage(
                                Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                                data['status']);
                            }
                          }else{
                              _showMessage(
                                Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ), 
                                  data['errors']
                                  
                                  ); 
                          }

                    }
                      },
                      buttonColor: Colors.blueAccent,
                    ),
                  ]),
                ),
              ),
            ]),
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


class Region {
  final int regionId;
  final String region;

  Region(
      {this.regionId,
      this.region,
     });
}
