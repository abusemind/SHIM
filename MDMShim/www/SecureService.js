(function() {
    var cordovaRef = window.cordova;
 
    function SecureService() {}

    SecureService.prototype = {
		getEncryptionKey: function(callback){
            cordovaRef.exec(callback, callback, 'SecureService', 'getEncryptionKey', []);
		}
    }

    SecureService.install = function() {
        if(!window.plugins) {
            window.plugins = {};
        }
 
        if(!window.plugins.SecureService) {
 
            window.plugins.SecureService = new SecureService();
 
            window.SecureService = window.plugins.SecureService;
        }
    }
 
    if(cordovaRef && cordovaRef.addConstructor) {
        cordovaRef.addConstructor(SecureService.install);
    }
})();