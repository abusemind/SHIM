(function() {
    var cordovaRef = window.cordova;
 
    function ShimMap() {}

    ShimMap.prototype = {
		openAddress: function(address, success, error){
        	cordovaRef.exec(success, error, 'ShimMap', 'openAddress', [address]);
        }
    }

    ShimMap.install = function() {
        if(!window.plugins) {
            window.plugins = {};
        }
 
        if(!window.plugins.ShimMap) {
 
            window.plugins.ShimMap = new ShimMap();
 
            window.ShimMap = window.plugins.ShimMap;
        }
    }
 
    if(cordovaRef && cordovaRef.addConstructor) {
        cordovaRef.addConstructor(ShimMap.install);
    }
})();