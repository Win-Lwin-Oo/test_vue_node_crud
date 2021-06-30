import 'dart:convert';
import 'dart:io';

import 'package:fl_client_app/model/tutorial.dart';
import 'package:http/http.dart' as http;

const String base_uri = 'http://localhost:8012/api/tutorials';

Future<Tutorial> getDataObj(String uri) async {
  String fullUri = base_uri + uri;
  final response = await http.get(
    Uri.parse(fullUri),
    headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  if (response.statusCode == 200) {
    var data = Tutorial.fromJsonObj(json.decode(response.body));
    print('Data =>$data');
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Tutorial>> getDataList(String uri) async {
  String fullUri = base_uri + uri;
  final response = await http.get(
    Uri.parse(fullUri),
    //To fetch data from most web services, you need to provide authorization.
    //Add authorization
    headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  //debugPrint('Response type=> ${(response.body).runtimeType}');
  //debugPrint('Response decode type=> ${(json.decode(response.body)).runtimeType}');
  //debugPrint('Response decode data=> ${(json.decode(response.body))}');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonArr = json.decode(response.body) as List;
    List<Tutorial> data =
        jsonArr.map((album) => Tutorial.fromJsonArr(album)).toList();
    print('Tutorial=>$data');
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}
