(function() {
    var cordovaRef = window.cordova;
 
    function ShimSecureFileViewer() {}

    ShimSecureFileViewer.prototype = {
		openFile: function(docId, etag, title, failureCB){
            cordovaRef.exec(null, failureCB, 'ShimSecureFileViewer', 'openFile', [docId, etag, title]);
		}
    }

    ShimSecureFileViewer.install = function() {
        if(!window.plugins) {
            window.plugins = {};
        }
 
        if(!window.plugins.ShimSecureFileViewer) {
 
            window.plugins.ShimSecureFileViewer = new ShimSecureFileViewer();
 
            window.ShimSecureFileViewer = window.plugins.ShimSecureFileViewer;
        }
    }
 
    if(cordovaRef && cordovaRef.addConstructor) {
        cordovaRef.addConstructor(ShimSecureFileViewer.install);
    }
})();