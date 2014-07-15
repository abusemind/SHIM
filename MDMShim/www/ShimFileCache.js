(function() {
    var cordovaRef = window.cordova;
 
    function ShimFileCache() {}

    ShimFileCache.prototype = {
		exists: function(docId, etag, callback){
 			cordovaRef.exec(callback, callback, 'ShimFileCache', 'exists', [docId, etag]);
 		},
 		
 		getCacheManifest: function(callback){
 			cordovaRef.exec(callback, callback, 'ShimFileCache', 'getCacheManifest', []);
 		},
 
        cacheFile: function(docId, etag, url, success, fail){
            cordovaRef.exec(success, fail, 'ShimFileCache', 'cacheFile', [docId, etag, url]);
        }
    }

    ShimFileCache.install = function() {
        if(!window.plugins) {
            window.plugins = {};
        }
 
        if(!window.plugins.ShimFileCache) {
 
            window.plugins.ShimFileCache = new ShimFileCache();
 
            window.ShimFileCache = window.plugins.ShimFileCache;
        }
    }
 
    if(cordovaRef && cordovaRef.addConstructor) {
        cordovaRef.addConstructor(ShimFileCache.install);
    }
})();