import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({this.url, this.postData, this.headers});

  final String url;
  final postData;
  final headers;

  dynamic getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      return data;
    } else {
      print(response.statusCode);
    }
  }

  Future postUserData() async {
    http.Response response = await http.post(url, body: this.postData);

    if (response.statusCode == 200) {
      String data = response.body;
//      print(data);
      return json.decode(data);
    } else {
      print(response.statusCode);
    }
  }
}

class Program {
  final int programId;

  final String program;

  Program({this.programId, this.program});

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      programId: json['id'],
      program: json['program'],
    );
  }

}

class Level {
  final int levelId;
  final String level;

  Level({this.levelId, this.level});

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      levelId: json['id'],
      level: json['level'],
    );
  }
}

