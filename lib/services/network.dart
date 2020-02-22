import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({this.url, this.postData});

  final String url;
  final postData;

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  void postUserData() async {
    http.Response response = await http.post(url, body: this.postData);

    if (response.statusCode == 200) {
      String data = response.body;
    } else {
      print(response.statusCode);
    }
  }
}

Future getPrograms() async {
  NetworkHelper networkHelper = NetworkHelper(
      url: 'http://internship-management-system.herokuapp.com/api/programs');

  var programs = await networkHelper.getData();

  return programs;
}

Future getLevels() async {
  NetworkHelper networkHelper = await NetworkHelper(
      url: 'http://internship-management-system.herokuapp.com/api/levels');

  var levels = await networkHelper.getData();

  return levels;
}
