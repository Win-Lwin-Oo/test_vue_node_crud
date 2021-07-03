import 'package:fl_client_app/model/tutorial.dart';
import 'package:fl_client_app/services/tutorial_data_services.dart';
import 'package:fl_client_app/ui/page/search_tutorial_page.dart';
import 'package:fl_client_app/ui/widget/add_new_tutorial.dart';
import 'package:fl_client_app/ui/widget/tutorial_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TutorialDataServices tutorialDataServices = new TutorialDataServices();
  late Future<List<Tutorial>> tutorialList;

  @override
  void initState() {
    super.initState();
    _getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return SearchTutorialPage();
              }));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(CupertinoIcons.search),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
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
                        child: Text(tutorial.title.substring(0, 1).toUpperCase()),
                      ),
                      title: Row(
                        children: [
                          Text(tutorial.title),
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            width: 10.0,
                            height: 10.0,
                            decoration: BoxDecoration(
                                color: tutorial.published ? Colors.green : Colors.yellow,
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                          ),
                        ],
                      ),
                      trailing: InkWell(
                        child: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        ),
                        onTap: () => _deleteTutorial(tutorial.id, context, index),
                      ),
                      onTap: () => _openDetailDialog(context, tutorial.id, tutorial.title,
                          tutorial.description, tutorial.published),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddNewDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _getAllData() {
    setState(() {
      tutorialList = tutorialDataServices.getAll();
    });
  }

  void _deleteTutorial(int id, BuildContext context, int index) {
    Future<Result> result = tutorialDataServices.delete(id);
    result.then((value) {
      setState(() {
        tutorialList.then((value) => value.removeAt(index));
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value.message)));
    });
  }

  void _openAddNewDialog(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new AddNewTutorial();
        },
        fullscreenDialog: true));
  }

  void _openDetailDialog(
      BuildContext context, int id, String title, String description, bool published) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new TutorialDetails(
              id: id, title: title, description: description, published: published);
        },
        fullscreenDialog: true));
  }
}
