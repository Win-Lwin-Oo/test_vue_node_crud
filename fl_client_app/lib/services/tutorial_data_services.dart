import 'package:fl_client_app/utils/http_helper.dart';

class TutorialDataServices {
  getAll() {
    return getDataList('/');
  }

  getById(int id) {
    return getDataObj('/$id');
  }

  findByTitle(String title) {
    return getDataList('/?title=$title');
  }
}
