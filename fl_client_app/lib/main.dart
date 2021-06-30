import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/album.dart';

Future<Album> fetchAlbum() async {
  final response =
  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    //To fetch data from most web services, you need to provide authorization.
    //Add authorization
    headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},);
  //debugPrint('Response=> ${(response.body).runtimeType}');
  //debugPrint('Response decode=> ${(json.decode(response.body)).runtimeType}');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var obj = Album.fromJsonObj(json.decode(response.body));
    debugPrint('AlbumObj=>$obj');
    return Album.fromJsonObj(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Album>> fetchAlbumList() async {
  final response =
  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    //To fetch data from most web services, you need to provide authorization.
    //Add authorization
    headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},);
  //debugPrint('Response type=> ${(response.body).runtimeType}');
  //debugPrint('Response decode type=> ${(json.decode(response.body)).runtimeType}');
  //debugPrint('Response decode data=> ${(json.decode(response.body))}');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonArr = json.decode(response.body) as List;
    List<Album> albumList = jsonArr.map((album) => Album.fromJsonArr(album)).toList();
    debugPrint('AlbumList=>$albumList');
    return albumList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;
  late Future<List<Album>> futureAlbumList;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    futureAlbumList = fetchAlbumList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tutorial'),
        ),
        body: Center(
          child: FutureBuilder<List<Album>>(
            future: futureAlbumList,
            builder: (context, snapshot) {
              /*Note that snapshot.hasData only returns true
              when the snapshot contains a non-null data value.
              This is why the fetchAlbumList function should throw an exception
              even in the case of a “404 Not Found” server response.*/
              if (snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.blueGrey,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    Album album = snapshot.data![index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(album.title.substring(0,1).toUpperCase()),
                      ),
                      title: Text(album.title),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}