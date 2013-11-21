Package.describe({
    summary: "(Alert) Helpers for Bootstrap 3 LESS ala Meteor ..."
});

Package.on_use(function (api) {
    api.use(['standard-app-packages', 'less', 'underscore', 'jquery'], 'client');
    api.use(['coffeescript'], ['client', 'server']);
    api.add_files([
    'lib/fonts/glyphicons-halflings-regular.eot',
    'lib/fonts/glyphicons-halflings-regular.ttf',
    'lib/fonts/glyphicons-halflings-regular.svg',
    'lib/fonts/glyphicons-halflings-regular.woff'
    ], 'client', {
        isAsset: true
    });
    

    api.add_files('b3.coffee', ['client', 'server']);

    api.add_files([
    'lib/js/tooltip.js',
    'lib/js/dropdown.js',
    'lib/js/popover.js',
    'lib/js/transition.js',
    'lib/js/modal.js',
    'b3.less',
    'helpless.html',
    'alerts/alert-b3.html', 
    'alerts/alert-b3.coffee', 
    'alerts/alert-b3.less',
    'modals/modalStage.html',
    'modals/modal-b3.html',
    'modals/modalStage.coffee',
    'modals/modalModel.coffee',
    'modals/modal-b3.coffee',
    'modals/modal-b3.less',
    'tooltips/tooltip-b3.html',
    'tooltips/tooltip-b3.coffee',
    ], ['client']);
    
    api.export(
        ['b3', 'bootbox']
        , ['client', 'server']);

});

