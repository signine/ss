var App = Ember.Application.create({
    LOG_TRANSITIONS: true
})


App.Router.map(function () {
    this.resource("app");
})


App.IndexRoute = Ember.Route.extend({
    redirect: function () {
        this.transitionTo("app");
    }
});