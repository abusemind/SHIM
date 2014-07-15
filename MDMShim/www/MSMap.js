(function() {
	var cordovaRef = window.cordova;
	
	function msMap() {}
	
	msMap.prototype = {
		init: function() {
			cordovaRef.exec(null, null, 'MSMap', 'init', []);
		},
        launch: function() {
            cordovaRef.exec(null, null, 'MSMap', 'launch', []);
        },
        animateToCurrentLocation: function() {
            cordovaRef.exec(null, null, 'MSMap', 'animateToCurrentLocation', []);
        },
        setFrame: function(frame) {
            cordovaRef.exec(null, null, 'MSMap', 'setFrame', [frame]);
        },
        isAuthorized: function(callback) {
            cordovaRef.exec(callback, null, 'MSMap', 'isAuthorized', []);
        },
        getCurrentPosition: function(callback) {
            cordovaRef.exec(callback, null, 'MSMap', 'getCurrentPosition', []);
        },
        setCamera: function(location) {
            cordovaRef.exec(null, null, 'MSMap', 'setCamera', [location]);
        },
        getCamera: function(callback) {
            cordovaRef.exec(callback, null, 'MSMap', 'getCamera', []);
        },
        getDistance: function(callback) {
            cordovaRef.exec(callback, null, 'MSMap', 'getDistance', []);
        },
        setMarkers: function(markers) {
            cordovaRef.exec(null, null, 'MSMap', 'setMarkers', [markers]);
        },
        close: function() {
            cordovaRef.exec(null, null, 'MSMap', 'close', []);
        },
        reset: function() {
            cordovaRef.exec(null, null, 'MSMap', 'reset', []);
        },
        launchNativeMaps: function(url) {
            cordovaRef.exec(null, null, 'MSMap', 'launchNativeMaps', [url]);
        },
        clear: function() {
            cordovaRef.exec(null, null, 'MSMap', 'clear', []);
        }
	};
	
	msMap.install = function() {
		if(!window.plugins) {
			window.plugins = {};
		}
		
		if(!window.plugins.msMap) {
			window.plugins.msMap = new msMap();
		}
	};
	
	if(cordovaRef && cordovaRef.addConstructor) {
		cordovaRef.addConstructor(msMap.install);
	}
})();