Package.describe({
    summary: "Helpers for Bootstrap 3 LESS ala Meteor ..."
});

Package.on_use(function (api) {
    api.use(['standard-app-packages', 'parsley', 'less', 'underscore', 'jquery', 'coffeescript', 'iron-router']);
    api.add_files(['accounts/accountMethods.coffee'],['client', 'server']);
    api.add_files([
    'lib/js/dropdown.js',
    'lib/js/tooltip.js',
    'lib/js/popover.js',
    'lib/js/transition.js',
    'b3.coffee',
    'b3.less',
    'defaults/parsley-defaults.coffee',
    'alerts/alert-b3.html', 
    'alerts/alert-b3.coffee', 
    'alerts/alert-b3.less',
    'accounts/accounts.coffee',
    'accounts/dynaSign.html',
    'accounts/dynaSign.coffee',
    'accounts/signUpPage.html',
    'accounts/signUpPage.coffee'
    ], ['client']);

    if (typeof api.export !== 'undefined'){
        api.export([
        'b3'
        ], 'client');
    }


});

