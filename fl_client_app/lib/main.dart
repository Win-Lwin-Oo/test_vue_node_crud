import 'package:fl_client_app/model/tutorial.dart';
import 'package:fl_client_app/services/tutorial_data_services.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TutorialDataServices tutorialDataServices = new TutorialDataServices();
  late Future<List<Tutorial>> tutorialList;

  @override
  void initState() {
    super.initState();
    _getAllData();
  }

  _getAllData() {
    debugPrint('Hello');
    setState(() {
      tutorialList = tutorialDataServices.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tutorial'),
        ),
        body: Center(
          child: FutureBuilder<List<Tutorial>>(
            future: tutorialList,
            builder: (context, snapshot) {
              /*Note that snapshot.hasData only returns true
              when the snapshot contains a non-null data value.
              This is why the fetchAlbumList function should throw an exception
              even in the case of a “404 Not Found” server response.*/
              if (snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.black26,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Tutorial tutorial = snapshot.data![index];
                    return ListTile(
                      leading: CircleAvatar(
                        child:
                            Text(tutorial.title.substring(0, 1).toUpperCase()),
                      ),
                      title: Text(tutorial.title),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return TextButton(
                    onPressed: _getAllData,
                    child: Text(
                      'Try again',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ));
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _getAllData,
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
