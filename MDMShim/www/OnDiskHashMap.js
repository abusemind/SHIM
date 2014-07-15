(function() {
    var cordovaRef = window.cordova;
 
    function OnDiskHashMap() {}

    OnDiskHashMap.prototype = {
		get: function(key, callback, error)
		{
            if(error == null || error == undefined){
            	cordovaRef.exec(callback, callback, 'OnDiskHashMap', 'get', [key]);
            }
            else{
            	cordovaRef.exec(callback, error, 'OnDiskHashMap', 'get', [key]);
            }
        },
 
 		put: function(key, value)
 		{
 			cordovaRef.exec(null, null, 'OnDiskHashMap', 'put', [key, value]);
 		}
    }

    OnDiskHashMap.install = function() {
        if(!window.plugins) {
            window.plugins = {};
        }
 
        if(!window.plugins.OnDiskHashMap) {
            window.plugins.OnDiskHashMap = new OnDiskHashMap();
 
            window.OnDiskHashMap = window.plugins.OnDiskHashMap;
        }
    }
 
    if(cordovaRef && cordovaRef.addConstructor) {
        cordovaRef.addConstructor(OnDiskHashMap.install);
    }
})();