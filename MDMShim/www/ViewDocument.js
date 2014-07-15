(function() {
	var cordovaRef = window.cordova;
	
	function ViewDocument() {}
	
	ViewDocument.normaliseUrl = function(url) {
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
	
	ViewDocument.prototype = {
		loadDocument: function(loc, success, failure) {
			cordovaRef.exec(success, failure, 'ViewDocument', 'loadDocument', [ViewDocument.normaliseUrl(loc)]);
		},
		close: function() {
			cordovaRef.exec(null, null, 'ViewDocument', 'close', []);
		}
	};
	
	ViewDocument.install = function() {
		if(!window.plugins) {
			window.plugins = {};
		}
		
		if(!window.plugins.viewDocument) {
            window.plugins.viewDocument = new ViewDocument();
		}
    };
	
	if(cordovaRef && cordovaRef.addConstructor) {
		cordovaRef.addConstructor(ViewDocument.install);
	}
})();