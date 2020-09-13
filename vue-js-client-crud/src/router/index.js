import Vue from 'vue';
import Router from 'vue-router';

Vue.use(Router);

export default new Router({
    mode: "history",
    routes: [
        {
            path: "/",
            alias: "/tutorials",
            name: "TutorialList",
            component: () => import("../components/TutorialList")
        },
        {
            path: "/tutorials/:id",
            name: "Tutorial",
            component: () => import("../components/Tutorial")
        },
        {
            path: "/add",
            name: "AddTutorial",
            component: () => import("../components/AddTutorial")
        }
    ]
});