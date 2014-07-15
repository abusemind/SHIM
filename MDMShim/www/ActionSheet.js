(function() {
    var cordovaRef = window.cordova;
 
    function PopUp() {}
    PopUp.prototype.createWithUrl = function(url, callback, options) {
        if(!options) {
            options = {};
        }
        var scope = options.scope || null;
        delete options.scope;
        var _callback = function(result) {
            callback.call(scope);
        };
        return cordova.exec(_callback, _callback, 'PopUp', 'createWithUrl', [url]);
    };

    PopUp.install = function() {
        if(!window.plugins) {
            window.plugins = {};
        }
 
        if(!window.plugins.popup) {
            window.plugins.popup = new PopUp();
        }
    }
 
    if(cordovaRef && cordovaRef.addConstructor) {
        cordovaRef.addConstructor(PopUp.install);
    }
})();