(function() {
	var cordovaRef = window.cordova;
	
	function AppData() {}
	
	AppData.prototype = {
		setItem: function(key, value, callback) {
			cordovaRef.exec(callback, callback, 'AppData', 'setItem', [key, value]);
		},
		getItem: function(key, callback) {
			var _callback = function(result) {
				callback(result.key, result.value);
			};
			
			cordovaRef.exec(_callback, _callback, 'AppData', 'getItem', [key]);
		},
		removeItem: function(key, callback) {
			cordovaRef.exec(callback, callback, 'AppData', 'removeItem', [key]);
		},
		clear: function() {
			cordovaRef.exec(null, null, 'AppData', 'clear', []);
		},
		getKeys: function(callback) {
			cordovaRef.exec(callback, callback, 'AppData', 'getKeys', []);
		}
	};
	
	AppData.install = function() {
		if(!window.plugins) {
			window.plugins = {};
		}
		
		if(!window.plugins.appData) {
			window.plugins.appData = new AppData();
		}
	};
	
	if(cordovaRef && cordovaRef.addConstructor) {
		cordovaRef.addConstructor(AppData.install);
	}
})();