import 'package:fl_client_app/utils/http_helper.dart';

class TutorialDataServices {

  create(Map<String, Object> data) {
    return postDataObj('/', data);
  }

  getAll() {
    return getDataList('/');
  }

  getById(int id) {
    return getDataObj('/$id');
  }

  findByTitle(String title) {
    return getDataList('/?title=$title');
  }

  delete(int id) {
    return deleteDataObj('/$id');
  }

  update(int id,Map<String, Object> data) {
    return updateDataObj('/$id', data);
  }

  patch(int id,Map<String, Object> data) {
    return patchDataObj('/$id', data);
  }
}
