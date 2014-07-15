(function() {
	var cordovaRef = window.cordova;
	
    function MatrixPortalApplicationCache() {}
	
	MatrixPortalApplicationCache.normaliseUrl = function(url) {
		if(url.indexOf('/') === 0) {
			url = window.location.origin + url;
		} else {
			if (!((/^http:/.test(url)) || (/^https:/.test(url)))) {
				var location = window.location.toString().replace(window.location.hash, '');
				url = location.substring(0, location.lastIndexOf('/')) + '/' + url;
			}
		}
		
		return url;
	};
	
	MatrixPortalApplicationCache.prototype = {
		setManifest: function(url, zipped) {
		},
		update: function() {
            console.log('matrixPortalApplicationCache.update is deprecated - please remove usage');
            if(matrixPortalApplicationCache.onnoupdate) {
                matrixPortalApplicationCache.onnoupdate();
            }
		},
		incrementalUpdate: function(url, referer) {
            if(matrixPortalApplicationCache.onnoupdate) {
                matrixPortalApplicationCache.onnoupdate();
            }
		},
		swapCache: function() {
            console.log('matrixPortalApplicationCache.swapCache is deprecated - please remove usage');
            var referer = MatrixPortalApplicationCache.referer;
            if(referer) {
                cordovaRef.exec(null, null, 'MatrixPortalApplicationCache', 'swapCacheManifest', [referer]);
            } else {
                cordovaRef.exec(null, null, 'MatrixPortalApplicationCache', 'swapCacheManifest', []);
            }
		},
		cacheUrlOnDisk: function(url, success, fail) {
			cordovaRef.exec(success, fail, 'MatrixPortalApplicationCache', 'cacheUrlOnDisk', [url]);
		},
		removeUrlFromDisk: function(url, success, fail) {
			cordovaRef.exec(success, fail, 'MatrixPortalApplicationCache', 'removeUrlFromDisk', [url]);
		},
		hasUrlOnDisk: function(url, callback) {
			cordovaRef.exec(callback, null, 'MatrixPortalApplicationCache', 'hasUrlOnDisk', [url]);
		},
        getCachedVersionForReferer: function(url, callback) {
            console.log('matrixPortalApplicationCache.getCachedVersionForReferer is deprecated - please remove usage');
        },
        setIntegrityHashForReferer: function(referer, hashes, callback) {
            console.log('matrixPortalApplicationCache.setIntegrityHashForReferer is deprecated - please remove usage');
        }
	};
	
	MatrixPortalApplicationCache.install = function() {
		if(!window.plugins) {
			window.plugins = {};
		}
		
		if(!window.plugins.matrixPortalApplicationCache) {
			window.plugins.matrixPortalApplicationCache = new MatrixPortalApplicationCache();
			window.matrixPortalApplicationCache = window.plugins.matrixPortalApplicationCache;
		}
	};
    
    if(cordovaRef && cordovaRef.addConstructor) {
        cordovaRef.addConstructor(MatrixPortalApplicationCache.install);
    }
})();