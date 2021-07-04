import 'package:fl_client_app/model/tutorial.dart';
import 'package:fl_client_app/services/tutorial_data_services.dart';
import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier {
  TutorialDataServices tutorialDataServices = new TutorialDataServices();

  late Future<List<Tutorial>> _tutorialList;
  Future<List<Tutorial>> get tutorialList => _tutorialList;

  late Future<Result> _result;
  Future<Result> get result => _result;

  String _message = '';
  String get message => _message;

  int _age = 0;
  int get age => _age;

  getTutorialList() {
    _tutorialList = tutorialDataServices.getAll();
  }

  notifyTutorialList() {
    getTutorialList();
    notifyListeners();
  }

  deleteTutorial(int id, int index) async {
    _result = tutorialDataServices.delete(id);
    var data = await _result;
    _message = data.message;
    if (data.status == 'success') {
      _tutorialList.then((value) => value.removeAt(index));
    }
    notifyListeners();
  }

  updateTutorial(int id, Map<String, Object> dataObj) async {
    _result = tutorialDataServices.update(id, dataObj);
    var data = await _result;
    _message = data.message;
    notifyTutorialList();
  }
}
