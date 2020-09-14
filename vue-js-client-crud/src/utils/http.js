import axios from 'axios';

export default axios.create({
    baseURL: "http://localhost:8012/api/tutorials", // depends on REST APIs url that Server configures api.
    headers: {
        "Content-type": "application/json"
    }
})