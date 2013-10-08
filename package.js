Package.describe({
    summary: "Bootstrap 3 LESS w/ Meteor Helpers ..."
});

Package.on_use(function (api) {
    api.use(['standard-app-packages', 'less', 'underscore', 'jquery', 'coffeescript']);

    api.add_files([
    'lib/js/dropdown.js',
    'lib/js/tooltip.js',
    'lib/js/popover.js',
    'lib/js/transition.js',
    'b3.coffee',
    'b3.less',
    'parsley-b3.coffee',
    'alerts/alert-b3.html', 
    'alerts/alert-b3.coffee', 
    'alerts/alert-b3.less',
    'inputs/inputGroups-b3.coffee',
    'inputs/navbarSign.html',
    'inputs/navbarSign.coffee',
    'inputs/navbarSign.less'], ['client']);
});

