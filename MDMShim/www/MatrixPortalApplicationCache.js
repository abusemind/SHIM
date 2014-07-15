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
			MatrixPortalApplicationCache.cacheManifestUrl = MatrixPortalApplicationCache.normaliseUrl(url);
			MatrixPortalApplicationCache.zipped = !!zipped;
		},
		update: function() {
			cordovaRef.exec(null, null, 'MatrixPortalApplicationCache', 'downloadCacheManifest', [MatrixPortalApplicationCache.cacheManifestUrl, MatrixPortalApplicationCache.zipped]);
		},
		incrementalUpdate: function(url, referer) {
            url = MatrixPortalApplicationCache.normaliseUrl(url);
            if(referer) {
                MatrixPortalApplicationCache.referer = referer = MatrixPortalApplicationCache.normaliseUrl(referer);
                cordovaRef.exec(null, null, 'MatrixPortalApplicationCache', 'incrementalUpdate', [url, referer]);
            } else {
                cordovaRef.exec(null, null, 'MatrixPortalApplicationCache', 'incrementalUpdate', [url]);
            }
		},
		swapCache: function() {
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
            url = MatrixPortalApplicationCache.normaliseUrl(url);
            cordovaRef.exec(callback, null, 'MatrixPortalApplicationCache', 'getCachedVersionForReferer', [url]);
        },
        setIntegrityHashForReferer: function(referer, hashes, callback) {
            referer = MatrixPortalApplicationCache.normaliseUrl(referer);
            cordovaRef.exec(callback, null, 'MatrixPortalApplicationCache', 'setIntegrityHashForReferer', [referer, hashes]);
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