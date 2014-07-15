(function() {
	var cordovaRef = window.cordova;
	
	function ChildBrowser() {}
	
	ChildBrowser.normaliseUrl = function(url) {
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
	
	ChildBrowser.prototype = {
		showWebPage: function(loc) {
			loc = ChildBrowser.normaliseUrl(loc);
			cordovaRef.exec(null, null, 'ChildBrowser', 'showWebPage', [loc]);
		},
		close: function() {
			cordovaRef.exec(null, null, 'ChildBrowser', 'close', []);
		}
	};

	/*
	 * The following can be called from the shim:
	 *  - window.plugins.childBrowser.onClose();
	 *    // When user chooses the 'Done' button
	 *  - window.plugins.childBrowser.onOpenExternal();
	 *    // If URL passed in does not match whitelist and opens in Safari
	 */
	 
	ChildBrowser.install = function() {
		if(!window.plugins) {
			window.plugins = {};
		}
		
		if(!window.plugins.childBrowser) {
			window.plugins.childBrowser = new ChildBrowser();
		}
	};
	 
	if(cordovaRef && cordovaRef.addConstructor) {
		cordovaRef.addConstructor(ChildBrowser.install);
	}
})();