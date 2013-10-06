Package.describe({
    summary: "Bootstrap 3 with Meteor style Javascripts., ..."
});

Package.on_use(function (api) {
    api.use(['deps', 'templating', 'less', 'underscore', 'jquery', 'coffeescript']);

    api.add_files([
    'lib/js/dropdown.js',
    'bootstrap.lessimport',
    'b3alert.html', 'b3alert.coffee', 'b3alert.less'], ['client']);
});

