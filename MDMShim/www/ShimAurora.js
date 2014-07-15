this.ShimAurora = {};
this.ShimAurora.load=function(resources){
    var doc = document;
    // Format
    if(resources===''+resources){
        resources=[resources];
    }
    // Load resources
    for(var i = 0; i < resources.length; i++) {
        doc.write('<script src="/matrix/portal/docs/mobile/js/lib/cordova/ios/' + resources[i] + '.js"></script>');
    }
};
// always add cordova
document.write('<script src="/matrix/portal/docs/mobile/js/lib/cordova/ios/cordova.js"></script>');
/*document.write('if (navigator.userAgent === undefined) {
    navigator.__defineGetter__("userAgent", function() {
                               return("Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit");
                               });
}');*/