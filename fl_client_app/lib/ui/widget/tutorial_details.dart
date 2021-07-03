import 'package:fl_client_app/model/tutorial.dart';
import 'package:fl_client_app/services/tutorial_data_services.dart';
import 'package:flutter/material.dart';

class TutorialDetails extends StatefulWidget {
  const TutorialDetails(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.published})
      : super(key: key);
  final int id;
  final String title;
  final String description;
  final bool published;

  @override
  _TutorialDetailsState createState() => _TutorialDetailsState();
}

class _TutorialDetailsState extends State<TutorialDetails> {
  TutorialDataServices tutorialDataServices = new TutorialDataServices();
  int _id = 0;
  String _title = '';
  final TextEditingController _descriptionController =
  new TextEditingController();
  bool _published = false;
  bool _descriptionInvalid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          TextButton(
              onPressed: ()=>_updateTutorial(_id,context),
              child: Text('UPDATE', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Description:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10.0,),
                Flexible(
                  child: TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter tutorial description',
                      errorText: _descriptionInvalid ? 'Invalid description' : null,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Status:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Switch(
                    value: _published,
                    onChanged: (value) {
                      setState(() {
                        _published = value;
                      });
                    }),
                Text(_published ? 'Published' : 'Pending'),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _parseRouteData();
  }

  void _parseRouteData(){
    _id = widget.id;
    _title = widget.title;
    _descriptionController.text = widget.description;
    _published = widget.published;
  }

  void _updateTutorial(int id, BuildContext context) {
    setState(() {
      if (_descriptionController.text.isEmpty) {
        _descriptionInvalid = true;
      } else {
        _descriptionInvalid = false;
      }
    });
    if(!_descriptionInvalid){

      // PATCH no need to add all data, update specific data, not overwrite
      // BUT, server used Sequelize to access database
      // Sequelize update function support for both patch and update process
      // PATCH doesn't trigger Sequelize instance hooks
      // https://github.com/feathersjs-ecosystem/feathers-sequelize/issues/155
      // depend on api server what used (get, put, delete, update, patch)
      // So, api for patch is not have in server
      // This is testing data object

      // var data = {
      //   "description": _descriptionController.text,
      //   "published": _published
      // };
      // debugPrint('Update data=> $data');
      // Future<Result> result = tutorialDataServices.patch(id, data);

      // UPDATE need all data, if not have data , overwrite with NULL
      var data = {
        "title": _title,
        "description": _descriptionController.text,
        "published": _published
      };
      debugPrint('Update data=> $data');
      Future<Result> result = tutorialDataServices.update(id, data);
      result.then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value.message)));
      });
    }
  }
}
