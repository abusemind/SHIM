(function() {
    var cordovaRef = window.cordova;
    
    function MatrixCrypto() {}
    
    MatrixCrypto.prototype = {
        resetEncryptedCache: function() {
            cordovaRef.exec(null, null, 'MatrixCrypto', 'resetEncryptedCache', []);
        },
        wipeMasterKey: function() {
            cordovaRef.exec(null, null, 'MatrixCrypto', 'wipeMasterKey', []);
        },
        encrypt: function(key, value, callback) {
            cordovaRef.exec(callback, callback, 'MatrixCrypto', 'encrypt', [key, value]);
        },
        decrypt: function(key, callback) {
            var _callback = function(result) {
                callback(result.key, result.value);
        };
            
            cordovaRef.exec(_callback, _callback, 'MatrixCrypto', 'decrypt', [key]);
        },
        launchChangePassword: function(callback) {
            cordovaRef.exec(callback, callback, 'MatrixCrypto', 'launchChangePassword', []);
        },
        changePassword: function(oldPassword, newPassword, callback) {
            cordovaRef.exec(callback, callback, 'MatrixCrypto', 'changePassword', [oldPassword, newPassword]);
        },
        setPassword: function(password, callback) {
            cordovaRef.exec(callback, callback, 'MatrixCrypto', 'setPassword', [password]);
        },
        changeEncryptionKey: function(oldKey, newKey, callback) {
            cordovaRef.exec(callback, callback, 'MatrixCrypto', 'changeEncryptionKey', [oldKey, newKey]);
        },
        setEncryptionKey: function(key, callback) {
            cordovaRef.exec(callback, callback, 'MatrixCrypto', 'setEncryptionKey', [key]);
        }
    };
    
    MatrixCrypto.install = function() {
        if(!window.plugins) {
            window.plugins = {};
        }
        
        if(!window.plugins.matrixCrypto) {
            window.plugins.matrixCrypto = new MatrixCrypto();
        }
    };
    
    if(cordovaRef && cordovaRef.addConstructor) {
        cordovaRef.addConstructor(MatrixCrypto.install);
    }
})();