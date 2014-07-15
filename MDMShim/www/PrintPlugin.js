(function() {
	var cordovaRef = window.cordova;
	
	function PrintPlugin() {}
	
	PrintPlugin.prototype = {
		print: function(printHTML, success, fail, options) {
			if(typeof printHTML != 'string') {
				console.log('Print function requires an HTML string. Not an object.');
				return;
			}
			
			var dialogLeftPos = 0;
			var dialogTopPos = 0;
			if(options) {
				if(options.dialogOffset) {
					if(options.dialogOffset.left) {
						dialogLeftPos = options.dialogOffset.left;
						if(isNaN(dialogLeftPos)) {
							dialogLeftPos = 0;
						}
					}
					
					if(options.dialogOffset.top) {
						dialogTopPos = options.dialogOffset.top;
						if(isNaN(dialogTopPos)) {
							dialogTopPos = 0;
						}
					}
				}
			}
			
			var _callback = function(result) {
				if(result.success) {
					success(result);
				} else {
					fail(result);
				}
			};
			
			cordova.exec(_callback, _callback, 'PrintPlugin', 'print', [printHTML, dialogLeftPos, dialogTopPos]);
		},
		isPrintingAvailable: function(callback) {
			cordova.exec(callback, callback, 'PrintPlugin', 'isPrintingAvailable', []);
		}
	};
	
	PrintPlugin.install = function() {
		if(!window.plugins) {
			window.plugins = {};
		}
		
		if(!window.plugins.printPlugin) {
			window.plugins.printPlugin = new PrintPlugin();
		}
	};
	
	if(cordovaRef && cordovaRef.addConstructor) {
		cordovaRef.addConstructor(PrintPlugin.install);
	}
})();