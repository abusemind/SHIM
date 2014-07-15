cordova.define('cordova/plugin_list', function(require, exports, module) {
               module.exports = [
                                 {
                                 "file": "plugins/org.apache.cordova.geolocation/www/Coordinates.js",
                                 "id": "org.apache.cordova.geolocation.Coordinates",
                                 "clobbers": [
                                              "Coordinates"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.geolocation/www/PositionError.js",
                                 "id": "org.apache.cordova.geolocation.PositionError",
                                 "clobbers": [
                                              "PositionError"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.geolocation/www/Position.js",
                                 "id": "org.apache.cordova.geolocation.Position",
                                 "clobbers": [
                                              "Position"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.geolocation/www/geolocation.js",
                                 "id": "org.apache.cordova.geolocation.geolocation",
                                 "clobbers": [
                                              "navigator.geolocation"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.network-information/www/network.js",
                                 "id": "org.apache.cordova.network-information.network",
                                 "clobbers": [
                                              "navigator.connection",
                                              "navigator.network.connection"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.network-information/www/Connection.js",
                                 "id": "org.apache.cordova.network-information.Connection",
                                 "clobbers": [
                                              "Connection"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.dialogs/www/notification.js",
                                 "id": "org.apache.cordova.dialogs.notification",
                                 "merges": [
                                            "navigator.notification"
                                            ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.vibration/www/vibration.js",
                                 "id": "org.apache.cordova.vibration.notification",
                                 "merges": [
                                            "navigator.notification"
                                            ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.console/www/console-via-logger.js",
                                 "id": "org.apache.cordova.console.console",
                                 "clobbers": [
                                              "console"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.console/www/logger.js",
                                 "id": "org.apache.cordova.console.logger",
                                 "clobbers": [
                                              "cordova.logger"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.contacts/www/contacts.js",
                                 "id": "org.apache.cordova.contacts.contacts",
                                 "clobbers": [
                                              "navigator.contacts"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.contacts/www/Contact.js",
                                 "id": "org.apache.cordova.contacts.Contact",
                                 "clobbers": [
                                              "Contact"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.contacts/www/ContactAddress.js",
                                 "id": "org.apache.cordova.contacts.ContactAddress",
                                 "clobbers": [
                                              "ContactAddress"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.contacts/www/ContactError.js",
                                 "id": "org.apache.cordova.contacts.ContactError",
                                 "clobbers": [
                                              "ContactError"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.contacts/www/ContactField.js",
                                 "id": "org.apache.cordova.contacts.ContactField",
                                 "clobbers": [
                                              "ContactField"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.contacts/www/ContactFindOptions.js",
                                 "id": "org.apache.cordova.contacts.ContactFindOptions",
                                 "clobbers": [
                                              "ContactFindOptions"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.contacts/www/ContactName.js",
                                 "id": "org.apache.cordova.contacts.ContactName",
                                 "clobbers": [
                                              "ContactName"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.contacts/www/ContactOrganization.js",
                                 "id": "org.apache.cordova.contacts.ContactOrganization",
                                 "clobbers": [
                                              "ContactOrganization"
                                              ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.contacts/www/ios/contacts.js",
                                 "id": "org.apache.cordova.contacts.contacts-ios",
                                 "merges": [
                                            "navigator.contacts"
                                            ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.contacts/www/ios/Contact.js",
                                 "id": "org.apache.cordova.contacts.Contact-iOS",
                                 "merges": [
                                            "Contact"
                                            ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.contacts/www/em/contacts.js",
                                 "id": "org.apache.cordova.contacts.contacts-em",
                                 "merges": [
                                            "navigator.contacts"
                                            ]
                                 }
                                 ]
               });