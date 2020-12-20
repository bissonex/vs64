/**
 *
 * VC65X Extension
 *
 */

//-----------------------------------------------------------------------------------------------//
// Check host environment
//-----------------------------------------------------------------------------------------------//

var VSCodePluginHost = null;
try {
    VSCodePluginHost = require("vscode");
} catch (e) { ; }

if (null == VSCodePluginHost) {
    console.log("running outside vscode is not supported.");
}

//-----------------------------------------------------------------------------------------------//
// Bind extension code
//-----------------------------------------------------------------------------------------------//

var Extension = require("./src/extension.js");

//-----------------------------------------------------------------------------------------------//
// Module exports
//-----------------------------------------------------------------------------------------------//

module.exports = {
    activate: Extension.activate,       // required entry point for vscode extension mode
    deactivate: Extension.deactivate    // required entry point for vscode extension mode
};
