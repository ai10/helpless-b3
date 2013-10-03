Package.describe({
    summary: "Help injecting bootstrap-3 alerts, ..."
});

Package.on_use(function (api) {
    api.use(['deps', 'templating', 'underscore', 'jquery', 'coffeescript']);

    api.add_files(['bs3alert.html', 'bootstrap-3-alert.coffee'], ['client']);
});

