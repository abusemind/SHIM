(function() { 
	var cordovaRef = window.cordova;
	function MatrixPortal() {}
 
    MatrixPortal.normaliseUrl = function(url) {
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
 
	MatrixPortal.prototype = {
        launchExternal: function(url) {
            cordovaRef.exec(null, null, 'MatrixPortal', 'launchExternal', [url]);
        },
        setMenuXY: function(x, y) {
            cordovaRef.exec(null, null, 'MatrixPortal', 'setMenuXY', [x, y]);
        },
		showWelcomeScreen: function() {
			cordovaRef.exec(null, null, 'MatrixPortal', 'showWelcomeScreen', []);
		},
		showMenuButton: function() {
            console.log('matrixPortal.showMenuButton is deprecated - please remove usage');
		},
		hideMenuButton: function() {
			cordovaRef.exec(null, null, 'MatrixPortal', 'hideMenuButton', []);
		},
		refreshOrientation: function() {
            var orientations = [0, 90, 180, 270];
            var supportedOrientations = [];
            if(window.shouldRotateToOrientation) {
                for(var i = 0; i < orientations.length; i++) {
                    if(window.shouldRotateToOrientation(orientations[i])) {
                        supportedOrientations.push(orientations[i]);
                    }
                }
            }
 
			cordovaRef.exec(null, null, 'MatrixPortal', 'refreshOrientation', supportedOrientations);
		},
        showPage: function() {
            cordovaRef.exec(null, null, 'MatrixPortal', 'showPage', []);
        },
        closeSplash: function() {
            cordovaRef.exec(null, null, 'MatrixPortal', 'closeSplash', []);
        },
		reauthSucceeded: function() {
			cordovaRef.exec(null, null, 'MatrixPortal', 'reauthSucceeded', []);
		},
		logout: function() {
			cordovaRef.exec(null, null, 'MatrixPortal', 'logout', []);
		},
		launchSubApplication: function(appUrl, appId, launchFromX, launchFromY, iconWidth, iconHeight) {
            this.putGlobalData('reauth.loaded.application.id', appId);
 
            appUrl = MatrixPortal.normaliseUrl(appUrl);
 
            if(typeof launchFromX != 'undefined' && typeof launchFromY != 'undefined' &&
                    typeof iconWidth != 'undefined' && typeof iconHeight != 'undefined') {
                cordovaRef.exec(null, null, 'MatrixPortal', 'launchSubApplication', [appUrl, appId, launchFromX, launchFromY, iconWidth, iconHeight]);
            } else {
                cordovaRef.exec(null, null, 'MatrixPortal', 'launchSubApplication', [appUrl, appId]);
            }
        },
		setKeepMeLoggedIn: function(value) {
			cordovaRef.exec(null, null, 'MatrixPortal', 'setKeepMeLoggedIn', [value ? 'true' : 'false']);
		},
		getKeepMeLoggedIn: function(callback) {
			cordovaRef.exec(callback, callback, 'MatrixPortal', 'getKeepMeLoggedIn', []);
		},
		putGlobalData: function(key, value) {
			cordovaRef.exec(null, null, 'MatrixPortal', 'putGlobalData', [key, value]);
		},
		getGlobalData: function(key, callback) {
			var _callback = function(result) {
				callback(result.key, result.value);
			};
			
			cordovaRef.exec(_callback, _callback, 'MatrixPortal', 'getGlobalData', [key]);
		},
		deleteGlobalData: function(key) {
			cordovaRef.exec(null, null, 'MatrixPortal', 'deleteGlobalData', [key]);
		},
        // Deprecated
        fireAppLoading: function() {
            console.log('matrixPortal.fireAppLoading is deprecated - please remove usage');
        },
        // Deprecated
        fireAppLoaded: function() {
            console.log('matrixPortal.fireAppLoaded is deprecated - please remove usage');
        },
        getShimVersion: function(callback) {
            cordovaRef.exec(callback, callback, 'MatrixPortal', 'getShimVersion', []);
        },
        getNotificationInfo: function(callback) {
            cordovaRef.exec(callback, callback, 'MatrixPortal', 'getNotificationInfo', []);
        },
        dismissSplash: function() {
            cordovaRef.exec(null, null, 'MatrixPortal', 'dismissSplash', []);
        }
	};
 
	MatrixPortal.install = function() {
		if(!window.plugins) {
			window.plugins = {};
		}
		
		if(!window.plugins.matrixPortal) {
			window.plugins.matrixPortal = new MatrixPortal();
			
			/*
			 * To be deprecated. These are here for backwards compatibility right now.
			 */
			window.matrixPortal = window.plugins.matrixPortal;
			window.MatrixPortal = window.plugins.matrixPortal;
		}
 
        window.plugins.matrixPortal.refreshOrientation();
	};
  
	if(cordovaRef && cordovaRef.addConstructor) {
		cordovaRef.addConstructor(MatrixPortal.install);
	}
})();