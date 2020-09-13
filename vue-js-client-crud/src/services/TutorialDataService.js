import http from '../utils/http';
import htpp from '../utils/http';

//service will use axios from HTTP client to send HTTP requests

class TutorialDataService {
    create(data) {
        return htpp.post("/tutorials", data);
    }

    getAll() {
        return http.get("/tutorials");
    }

    get(id) {
        return htpp.get(`/tutorials/${id}`);
    }

    update(id, data) {
        return http.put(`/tutorials/${id}`, data);
    }

    delete(id) {
        return http.delete(`/tutorials/${id}`);
    }

    deleteAll() {
        return http.delete("/tutorials");
    }

    findByTitle(title) {
        return http.get(`/tutorials?title=${title}`);
    }
}

export default new TutorialDataService();