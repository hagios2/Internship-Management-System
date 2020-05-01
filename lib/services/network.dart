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

List<Level> levelsFromJson(String str) =>
    List<Level>.from(json.decode(str).map((x) => Level.fromJson(x)));
//String levelsToJson(List<Level> data) =>
//    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LevelsList {
  final List<Level> levels;
  LevelsList({this.levels});

  factory LevelsList.fromJson(List<dynamic> parsedJson) {
    List<Level> levels = List<Level>();
    levels = parsedJson.map((i) => Level.fromJson(i)).toList();

    return LevelsList(
      levels: levels,
    );
  }
}

Future<List<Level>> getLevels() async {
  http.Response response = await http
      .get('https://internship-management-system.herokuapp.com/api/levels');

  if (response.statusCode == 200) {
//    print(response.body);
    final levels = levelsFromJson(response.body);
    return levels;
  } else {
    throw Exception('Failed to load level');
  }
}

Future<List<Program>> getPrograms() async {
  http.Response response = await http
      .get('https://internship-management-system.herokuapp.com/api/programs');

  if (response.statusCode == 200) {
    print(response.body);

    List<Program> programList = [];

    for (var programs in json.decode(response.body)) {
      Program program =
          Program(programId: programs["id"], program: programs["program"]);

      programList.add(program);
    }

    print(programList);

    return programList;
  } else {
    throw Exception('Failed to load program');
  }
}
