(function() {
	var cordovaRef = window.cordova;
	
	function EmailComposer() {}
	
	EmailComposer.ComposeResultType = {
		Cancelled:0,
		Saved:1,
		Sent:2,
		Failed:3,
		NotSent:4
	};
	
	EmailComposer.prototype = {
		showEmailComposer: function(subject, body, toRecipients, ccRecipients, bccRecipients, bIsHTML) {
			var args = {};
			if(subject) {
				args.subject = subject;
			}
			
			if(body) {
				args.body = body;
			}
			
			if(toRecipients) {
				args.toRecipients = toRecipients;
			}
			
			if(ccRecipients) {
				args.ccRecipients = ccRecipients;
			}
			
			if(bccRecipients) {
				args.bccRecipients = bccRecipients;
			}
			
			if(bIsHTML) {
				args.bIsHTML = bIsHTML;
			}
			
			cordovaRef.exec(null, null, 'EmailComposer', 'showEmailComposer', [args]);
		},
		showEmailComposerWithCB: function(cbFunction, subject, body, toRecipients, ccRecipients, bccRecipients, bIsHTML) {
			EmailComposer.resultCallback = cbFunction;
			showEmailComposer(subject, body, toRecipients, ccRecipients, bccRecipients, bIsHTML);
		},
		_didFinishWithResult: function(res) {
			if(EmailComposer.resultCallback) {
				EmailComposer.resultCallback(res);
			}
		}
	};
	
	EmailComposer.install = function() {
		if(!window.plugins) {
			window.plugins = {};
		}
		
		if(!window.plugins.emailComposer) {
			window.plugins.emailComposer = new EmailComposer();
		}
	};
	
	if(cordovaRef && cordovaRef.addConstructor) {
		cordovaRef.addConstructor(EmailComposer.install);
	}
})();