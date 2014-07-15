(function() {
    var cordovaRef = window.cordova;
 
    function ShimNotificationCenter() {}

    ShimNotificationCenter.prototype = {
		//needs to be paired with a dismiss call later (async)
 		show: function(message){
 			cordovaRef.exec(null, null, 'ShimNotificationCenter', 'show', [message]);
 		},
 		
 		dismiss: function(){
 			cordovaRef.exec(null, null, 'ShimNotificationCenter', 'dismiss', []);
 		},
 		//auto dismiss
 		showSuccess: function(success){
 			cordovaRef.exec(null, null, 'ShimNotificationCenter', 'showSuccess', [success]);
 		},
 		//auto dismiss
 		showError: function(error){
 			cordovaRef.exec(null, null, 'ShimNotificationCenter', 'showError', [error]);
 		},
 		
 		/**
 		auto dismiss
 		Type: 
 		-1: error
 		0 : success
 		1 : information or warning
 		*/
 		alert: function(type, title, subtitle){
 			cordovaRef.exec(null, null, 'ShimNotificationCenter', 'alert', [type, title, subtitle]);
 		}
    }

    ShimNotificationCenter.install = function() {
        if(!window.plugins) {
            window.plugins = {};
        }
 
        if(!window.plugins.ShimNotificationCenter) {
        	console.log('ShimNotificationCenter plugin installed');
        
 			window.plugins.ShimNotificationCenter = new ShimNotificationCenter();
 
            window.ShimNotificationCenter = window.plugins.ShimNotificationCenter;
        }
    }
 
    if(cordovaRef && cordovaRef.addConstructor) {
        cordovaRef.addConstructor(ShimNotificationCenter.install);
    }
})();