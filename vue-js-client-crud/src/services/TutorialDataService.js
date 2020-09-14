import http from '../utils/http';
import htpp from '../utils/http';

//service will use axios from HTTP client to send HTTP requests

class TutorialDataService {
    create(data) {
        return htpp.post("/", data);
    }

    getAll() {
        return http.get("/");
    }

    get(id) {
        return htpp.get(`/${id}`);
    }

    update(id, data) {
        return http.put(`/${id}`, data);
    }

    delete(id) {
        return http.delete(`/${id}`);
    }

    deleteAll() {
        return http.delete("/");
    }

    findByTitle(title) {
        return http.get(`?title=${title}`);
    }
}

export default new TutorialDataService();