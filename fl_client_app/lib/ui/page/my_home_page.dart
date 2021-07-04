import 'package:fl_client_app/model/tutorial.dart';
import 'package:fl_client_app/ui/widget/add_new_tutorial.dart';
import 'package:fl_client_app/ui/widget/tutorial_details.dart';
import 'package:fl_client_app/utils/app_state_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _searchController;
  String _terms = '';
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateNotifier>(context);
    appState.search(_terms);
    //model.tutorialList = results;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
      ),
      body: Consumer<AppStateNotifier>(
        builder: (context, appState, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Column(
                  children: [
                    Flexible(child:
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xffe0e0e0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 6,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.search,
                              color: Color.fromRGBO(128, 128, 128, 1),
                            ),
                            Expanded(
                              child: CupertinoTextField(
                                controller: _searchController,
                                placeholder: 'Search',
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                ),
                                cursorColor: Color.fromRGBO(0, 122, 255, 1),
                                decoration: null,
                              ),
                            ),
                            GestureDetector(
                              onTap: _searchController.clear,
                              child: const Icon(
                                CupertinoIcons.clear_thick_circled,
                                color: Color.fromRGBO(128, 128, 128, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ),
                    Flexible(
                      child: FutureBuilder<List<Tutorial>>(
                        future: appState.tutorialList,
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
                                    child: Text(
                                        tutorial.title.substring(0, 1).toUpperCase()),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(tutorial.title),
                                      Container(
                                        margin: EdgeInsets.only(left: 5.0),
                                        width: 10.0,
                                        height: 10.0,
                                        decoration: BoxDecoration(
                                            color: tutorial.published
                                                ? Colors.green
                                                : Colors.yellow,
                                            borderRadius: BorderRadius.circular(10.0)),
                                      ),
                                    ],
                                  ),
                                  trailing: InkWell(
                                    child: Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.red,
                                    ),
                                    onTap: () =>
                                        _deleteTutorial(tutorial.id, context, index),
                                  ),
                                  onTap: () => _openDetailDialog(
                                      context,
                                      tutorial.id,
                                      tutorial.title,
                                      tutorial.description,
                                      tutorial.published),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return TextButton(
                                onPressed: () => appState.notifyTutorialList(),
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddNewDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AppStateNotifier>(context, listen: false).getTutorialList();
    _searchController = TextEditingController()..addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _terms = _searchController.text;
    });
  }

  void _deleteTutorial(int id, BuildContext context, int index) async {
    final appState = Provider.of<AppStateNotifier>(context, listen: false);
    await appState.deleteTutorial(id, index);
    // print('Delete=>${appState.message}');
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${appState.message}')));
  }

  void _openAddNewDialog(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new AddNewTutorial();
        },
        fullscreenDialog: true));
  }

  void _openDetailDialog(BuildContext context, int id, String title,
      String description, bool published) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new TutorialDetails(
              id: id,
              title: title,
              description: description,
              published: published);
        },
        fullscreenDialog: true));
  }
}
