Package.describe({
    summary: "Helpers for Bootstrap 3 LESS ala Meteor ..."
});

Package.on_use(function (api) {
    api.use(['standard-app-packages', 'accounts-base', 'accounts-password', 'http', 'parsleyb3', 'less', 'underscore', 'jquery', 'coffeescript'], 'client');
    api.use('iron-router', ['client', 'server']);
    api.imply(['accounts-base', 'accounts-password'],['client', 'server']);

    var path = Npm.require('path');
    var asset_path = path.join('lib');
    api.add_files(['accounts/accountsB3.coffee'],['client', 'server']);
    api.add_files(path.join(asset_path, 'fonts','glyphicons-halflings-regular.eot'), 'client');
    api.add_files(path.join(asset_path, 'fonts','glyphicons-halflings-regular.ttf'), 'client');
    api.add_files(path.join(asset_path, 'fonts','glyphicons-halflings-regular.svg'), 'client');
    
    api.add_files(path.join(asset_path, 'fonts','glyphicons-halflings-regular.woff'), 'client');

    api.add_files([
    'lib/js/tooltip.js',
    'lib/js/dropdown.js',
    'lib/js/popover.js',
    'lib/js/transition.js',
    'b3.coffee',
    'b3.less',
    'config-b3.coffee',
    'defaults/parsley-defaults.coffee',
    'alerts/alert-b3.html', 
    'alerts/alert-b3.coffee', 
    'alerts/alert-b3.less',
    'tooltips/tooltip-b3.html',
    'tooltips/tooltip-b3.coffee',
    'accounts/dynaSign.html',
    'accounts/dynaSign.coffee'
    ], ['client']);

    if (typeof api.export !== 'undefined'){
        api.export([
        'b3'
        ], 'client');
    }


});

