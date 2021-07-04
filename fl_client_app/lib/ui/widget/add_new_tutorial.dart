import 'package:fl_client_app/model/tutorial.dart';
import 'package:fl_client_app/services/tutorial_data_services.dart';
import 'package:fl_client_app/utils/app_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewTutorial extends StatefulWidget {
  const AddNewTutorial({Key? key}) : super(key: key);

  @override
  _AddNewTutorialState createState() => _AddNewTutorialState();
}

class _AddNewTutorialState extends State<AddNewTutorial> {
  TutorialDataServices tutorialDataServices = new TutorialDataServices();
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _descriptionController =
      new TextEditingController();
  bool _published = false;
  bool _titleInvalid = false, _descriptionInvalid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new tutorial'),
        actions: [
          TextButton(
              onPressed: () => _createNewTutorial(context),
              child: Text('SAVE', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter tutorial title',
                errorText: _titleInvalid ? 'Invalid description' : null,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter tutorial description',
                errorText: _descriptionInvalid ? 'Invalid description' : null,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Text('Published'),
                Switch(
                    value: _published,
                    onChanged: (value) {
                      setState(() {
                        _published = value;
                      });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void _createNewTutorial(BuildContext context) {
    _validateForm();
    if (!_titleInvalid && !_descriptionInvalid) {
      var data = {
        "title": _titleController.text,
        "description": _descriptionController.text,
        "published": _published
      };

      // debugPrint('reqData type => ${data.runtimeType}');
      Future<Tutorial> response = tutorialDataServices.create(data);
      response.then((value) {
        if (value.id > 0) {
          Provider.of<AppStateNotifier>(context,listen: false).notifyTutorialList();
          Navigator.of(context).pop();
          _resetForm();
        }
      });
    }
  }

  void _validateForm() {
    setState(() {
      if (_titleController.text.isEmpty) {
        _titleInvalid = true;
      } else {
        _titleInvalid = false;
      }

      if (_descriptionController.text.isEmpty) {
        _descriptionInvalid = true;
      } else {
        _descriptionInvalid = false;
      }
    });
  }

  void _resetForm() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _titleInvalid = false;
      _descriptionInvalid = false;
    });
  }
}
