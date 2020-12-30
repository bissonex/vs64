//
// VS64 Extension
//

const path = require('path');
const fs = require('fs');

const { spawn } = require('child_process');
const vscode = require('vscode');

//-----------------------------------------------------------------------------------------------//
// Init module and lookup path
//-----------------------------------------------------------------------------------------------//

global._sourcebase = path.resolve(__dirname, "..");
global.BIND = function(_module) {
    _module.paths.push(global._sourcebase);
};

// eslint-disable-next-line
BIND(module);

//-----------------------------------------------------------------------------------------------//
// Required Modules
//-----------------------------------------------------------------------------------------------//
var Constants = require('src/constants');
var Utils = require('src/utils');
var DiagnosticProvider = require('src/diagnostic_provider');
var Debugger = require('src/debugger');

//-----------------------------------------------------------------------------------------------//
// Extension
//-----------------------------------------------------------------------------------------------//

class EmulatorViewProvider {

    constructor(_extensionUri) {
        this._extensionUri = _extensionUri;
    }

    resolveWebviewView(webviewView, context, _token) {
        this._view = webviewView;
        webviewView.webview.options = {
            // Allow scripts in the webview
            enableScripts: true,
            localResourceRoots: [
                this._extensionUri
            ]
        };
        webviewView.webview.html = this._getHtmlForWebview(webviewView.webview);
        // webviewView.webview.onDidReceiveMessage(data => {
        //     switch (data.type) {
        //         case 'keyPressed':
        //             {
        //                 //vscode.window.activeTextEditor?.insertSnippet(new vscode.SnippetString(`#${data.value}`));
        //                 this._view.webview.postMessage({ type: 'drawChar', charCode: data.value, hpos: 1, vpos: 20 });
        //                 break;
        //             }
        //     }
        // });
    }

    start() {
        var _a, _b;
        if (this._view) {
            (_b = (_a = this._view).show) === null || _b === void 0 ? void 0 : _b.call(_a, true); // `show` is not implemented in 1.49 but is for 1.50 insiders
            this._view.webview.postMessage({ type: 'startEmulation' });
        }
    }

	// public clearColors() {
	// 	if (this._view) {
	// 		this._view.webview.postMessage({ type: 'clearColors' });
	// 	}
	// }

    _getHtmlForWebview(webview) {
        // Get the local path to main script run in the webview, then convert it to a uri we can use in the webview.
        const scriptUri = webview.asWebviewUri(vscode.Uri.joinPath(this._extensionUri, 'media', 'main2.js'));
        // Do the same for the stylesheet.
        // const styleResetUri = webview.asWebviewUri(vscode.Uri.joinPath(this._extensionUri, 'media', 'reset.css'));
        const styleVSCodeUri = webview.asWebviewUri(vscode.Uri.joinPath(this._extensionUri, 'media', 'vscode.css'));
        const styleMainUri = webview.asWebviewUri(vscode.Uri.joinPath(this._extensionUri, 'media/css', 'apple2.css'));
        // Use a nonce to only allow a specific script to be run.
        const nonce = getNonce();
        return `<!DOCTYPE html>
		<html lang="en">
		<head>
			<meta charset="UTF-8">

			<!--
				Use a content security policy to only allow loading images from https or from our extension directory,
				and only allow scripts that have a specific nonce.
			-->
			<meta http-equiv="Content-Security-Policy" content="default-src 'none'; style-src ${webview.cspSource}; script-src 'nonce-${nonce}';">

			<meta name="viewport" content="width=device-width, initial-scale=1.0">

			<link href="${styleVSCodeUri}" rel="stylesheet">
			<link href="${styleMainUri}" rel="stylesheet">

			<title>Emulator</title>
		</head>
		<body class="apple2">
			<div class="outer">
				<div id="display">
					<div class="overscan">
						<canvas id="screen" width="560" height="384"></canvas>
					</div>
				</div>
				<div class="inset">
					<div style="margin: 0 10px">
						<div id="keyboard"></div>
					</div>
				</div>
			</div>

			<script type="module" nonce="${nonce}" src="${scriptUri}"></script>
		</body>
		</html>`;
    }
}

EmulatorViewProvider.viewType = 'vc65x.uiView';

class Extension {

    /**
     * @param {vscode.ExtensionContext} context
     */
    constructor(context) {
        this._context = context;
        this._output = null;
        this._settings = {};
        this._debugger = null;
        this._uiView = null;

        this._state = {
            assemblerProcess: null,
            emulatorProcess: null
        };
    }

    get settings() {
        return this._settings;
    }

    hasWorkspace() {
        return (null != vscode.workspace.rootPath);
    }

    activate() {

        var thisInstance = this;
        var context = this._context;
        var settings = this._settings;
        var state = this._state;
        var hasWorkspace = this.hasWorkspace();

        {
            this._uiView = new EmulatorViewProvider(context.extensionUri);
            context.subscriptions.push(vscode.window.registerWebviewViewProvider(EmulatorViewProvider.viewType, this._uiView));
            // context.subscriptions.push(vscode.commands.registerCommand('systemEmulator.start', () => {
            //     provider.start();
            // }));
        }

        { // load settings
            settings.extensionPath = context.extensionPath;
            this.updateSettings();

            let disposable = vscode.workspace.onDidChangeConfiguration(function(e) {
                thisInstance.updateSettings();
            });

            context.subscriptions.push(disposable);
        }

        { // create output channel
            this._output = vscode.window.createOutputChannel("VC65X");
        }

        var output = this._output;

        { // register command: build
            let disposable = vscode.commands.registerCommand('vc65x.build', function() {

                if (!hasWorkspace) {
                    vscode.window.showErrorMessage("No folder open in workspace");
                    return;
                }

                if (Constants.AlwaysShowOutputChannel) output.show(true);
                output.clear();
                thisInstance.commandBuild();
            });
            context.subscriptions.push(disposable);
        }

        { // register command: run
            let disposable = vscode.commands.registerCommand('vc65x.run', function() {

                if (!hasWorkspace) {
                    vscode.window.showErrorMessage("No folder open in workspace");
                    return;
                }

                if (Constants.AlwaysShowOutputChannel) output.show(true);
                output.clear();
                if (true == settings.autoBuild) {
                    thisInstance.commandBuild(thisInstance.commandRun.bind(thisInstance));
                } else {
                    thisInstance.commandRun();
                }
            });
            context.subscriptions.push(disposable);
        }

        { // register command: debug
            let disposable = vscode.commands.registerCommand('vc65x.debug', function() {

                if (!hasWorkspace) {
                    vscode.window.showErrorMessage("No folder open in workspace");
                    return;
                }

                if (Constants.AlwaysShowOutputChannel) output.show(true);
                output.clear();
                if (true == settings.autoBuild) {
                    thisInstance.commandBuild(thisInstance.commandDebug.bind(thisInstance));
                } else {
                    thisInstance.commandDebug();
                }
            });
            context.subscriptions.push(disposable);
        }

        { // create diagnostic provider
            this._diagnostics = new DiagnosticProvider(this);
        }

        // listen to changes between documents
        vscode.window.onDidChangeActiveTextEditor(function (e) {
            if (null == e) {
                thisInstance.clear();
            } else {
                thisInstance.update();
            }
        });

        // listen do document content changes
        vscode.workspace.onDidChangeTextDocument(function (e) {

            if (null == e || null == e.document || null == vscode.window.activeTextEditor) {
                thisInstance.clear();
                return;
            }

            if (e.document.languageId !== Constants.AssemblerLanguageId) {
                return;
            }

            if (e.document === vscode.window.activeTextEditor.document) {
                var textDocument = e.document;
                var isDirty = textDocument.isDirty;
                if (isDirty) {
                    thisInstance.update();
                } else {
                    thisInstance.onSave(textDocument);
                }
            }
        });

        if (this.hasWorkspace()) {

            if (this._settings.backgroundBuild) {
                this.commandBuild();
            }

            // start debugger adapter
            {
                this._debugger = new Debugger(this);
                this._debugger.start();
            }

            vscode.debug.onDidStartDebugSession(function(debugSession) {
                thisInstance.onDidStartDebugSession(debugSession);
            });

            vscode.window.onDidChangeActiveTextEditor(function(textEditor) {
                thisInstance.onDidChangeActiveTextEditor(textEditor);
            });

        }

    }

    onDidChangeActiveTextEditor(textEditor) {
        if (null == textEditor || null == textEditor.document) {
            return;
        }

        if (textEditor.document.languageId !== Constants.AssemblerLanguageId) {
            return;
        }

        if (this._settings.backgroundBuild) {
            this.commandBuild();
        }
    }

    onDidStartDebugSession(debugSession) {
    }

    clear() {
    }

    update() {
    }

    onSave(textDocument) {
        if (!this.hasWorkspace()) return;
        if (this._settings.backgroundBuild) {
            this.commandBuild();
        }
    }

    clearDiagnostics() {
        this._diagnostics.clear();
    }

    updateDiagnostics(procInfo) {
        this._diagnostics.update(procInfo);
    }

    deactivate() {
        if (null != this._debugger) {
            this._debugger.stop();
            this._debugger = null;
        }
    }

    getSessionState() {

        var settings = this._settings;
        var state = this._state;

        var s = {};

        if (state.assemblerProcess != null && true != state.assemblerProcess.exited) {
            s.assemblerRunning = true;
        }

        if (false == settings.assemblerEnabled) {
            s.assemblerDisabled = true;
        }

        if (state.emulatorProcess != null && true != state.emulatorProcess.exited) {
            s.emulatorRunning = true;
        }

        if (false == settings.emulatorEnabled) {
            s.emulatorDisabled = true;
        }

        if (state.debuggerProcess != null && true != state.debuggerProcess.exited) {
            s.debuggerRunning = true;
        }

        s.filename = Utils.getCurrentAsmFile();
        if (null == s.filename) {
            s.noSource = true;
            s.filename = "";
            s.prgfilename = "";
            s.reportFilename = "";
            s.labelsFilename = "";
        } else {
            s.prgfilename = Utils.getOutputFilename(s.filename, "bin");
            s.reportFilename = Utils.getOutputFilename(s.filename, "report");
            s.labelsFilename = Utils.getOutputFilename(s.filename, "labels");

            if (Utils.compareFileTime(s.filename, s.prgfilename) >= 0 &&
                Utils.compareFileTime(s.filename, s.reportFilename) >= 0 &&
                Utils.compareFileTime(s.filename, s.labelsFilename) >= 0) {
                s.noBuildNeeded = true;
            }
        }

        return s;
    }

    isBuildRequired() {
        var sessionState = this.getSessionState();
        if (null == sessionState) return false;
        if (sessionState.noBuildNeeded) return false;
        return true;
    }

    commandBuild(successFunction) {

        var settings = this._settings;
        var state = this._state;
        var output = this._output;

        var sessionState = this.getSessionState();

        if (sessionState.assemblerDisabled) {
            output.appendLine("please revise your assembler executable settings");
            return;
        }

        if (sessionState.assemblerRunning) {
            output.appendLine("assembler already running...");
            return;
        }

        if (sessionState.noSource) {
            output.appendLine("no source");
            return;
        }

        if (sessionState.noBuildNeeded) {
            output.appendLine("no need to build " + path.basename(sessionState.filename));
            if (null != successFunction) {
                successFunction();
            }
            return;
        }

        this.clearDiagnostics();

        output.appendLine("building " + path.basename(sessionState.filename));

        var sourceDir = path.dirname(sessionState.filename);

        var searchDirs = null;

        if (null != settings.assemblerSearchPath) {
            searchDirs = [];
            var dirs = settings.assemblerSearchPath.split(",").map(item => item.trim());
            for (var i=0, dir; dir=dirs[i]; i++) {
                if (path.isAbsolute(dir)) {
                    searchDirs.push(dir);
                } else {
                    searchDirs.push(path.resolve(sourceDir, dir));
                }
            }
        } else {
            searchDirs = [ sourceDir ];
        }

        var outDir = path.dirname(sessionState.prgfilename);
        Utils.mkdirRecursive(outDir);

        var executable = Utils.getAbsoluteFilename(settings.assemblerPath);
        var args = [
            "-f", "plain",
            "-o", sessionState.prgfilename,
            "-r", sessionState.reportFilename,
            "--vicelabels", sessionState.labelsFilename
        ];

        if (settings.definitions) {
            var defs = settings.definitions.split(",");
            if (defs.length > 0) {
                for (var i = 0; i < defs.length; i++) {
                    args.push("-D" + defs[i].trim());
                }
            }
        }

        for (var i=0, searchDir; searchDir=searchDirs[i]; i++) {
            args.push("-I");
            args.push(searchDir);
        }

        args.push(... Utils.splitQuotedString(settings.assemblerArgs));

        args.push(sessionState.filename);

        if (settings.verbose) {
            var cmd = executable + " " + args.join(" ");
            output.appendLine(cmd);
        }

        var thisInstance = this;

        state.assemblerProcess = this.exec(
            executable, args,
            function(procInfo) { // success function
                thisInstance.updateDiagnostics(procInfo);
                if (null != successFunction) {
                    successFunction();
                }
            },
            function(procInfo) { // error function
                if (procInfo.errorInfo) {
                    thisInstance._state.assemblerProcess = null;
                    output.appendLine("failed to start assembler - please check your settings!");
                    vscode.window.showErrorMessage("Failed to start assembler. Please check your settings!");
                } else {
                    thisInstance.updateDiagnostics(procInfo);
                }
            }
        );
    }

    commandRun() {

        var settings = this._settings;
        var state = this._state;
        var output = this._output;

        var sessionState = this.getSessionState();

        if (sessionState.emulatorDisabled) {
            output.appendLine("please revise your emulator executable settings");
            return;
        }

        if (sessionState.emulatorRunning) {
            output.appendLine("emulator already running...");
            return;
        }

        if (sessionState.noSource) {
            output.appendLine("no source");
            return;
        }

        output.appendLine("running " + path.basename(sessionState.prgfilename));

        var executable = Utils.getAbsoluteFilename(settings.emulatorPath);
        var args = [];
        args.push(...Utils.splitQuotedString(settings.emulatorArgs));
        args.push(sessionState.prgfilename);

        if (settings.verbose) {
            var cmd = executable + " " + args.join(" ");
            output.appendLine(cmd);
        }

        state.emulatorProcess = this.exec(executable, args);

    }

    commandDebug() {

        var settings = this._settings;
        var state = this._state;
        var output = this._output;

        if (true != settings.debuggerEnabled || settings.debuggerPath == "") {
            this.commandRun();
            return;
        }

        var sessionState = this.getSessionState();

        if (sessionState.noSource) {
            output.appendLine("no source");
            return;
        }

        output.appendLine("debugging " + path.basename(sessionState.prgfilename));

        var executable = Utils.getAbsoluteFilename(settings.debuggerPath);

        if (false == sessionState.debuggerRunning) {

            let args = [
                sessionState.prgfilename
            ];

            if (settings.verbose) {
                let cmd = executable + " " + args.join(" ");
                output.appendLine(cmd);
            }

            state.debuggerProcess = this.exec(executable, args);

        } else {

            output.appendLine("injecting program to running debugger");

            let args = [
                "-pass",
                "-symbols", sessionState.labelsFilename,
                "-prg", sessionState.prgfilename,
                "-autojmp"
            ];

            args.push(...Utils.splitQuotedString(settings.debuggerArgs));

            if (settings.verbose) {
                let cmd = executable + " " + args.join(" ");
                output.appendLine(cmd);
            }

            this.exec(executable, args);

        }

    }

    exec(executable, args, successFunction, errorFunction) {

        var cmd = executable + " " + args.join(" ");

        var output = this._output;

        const proc = spawn(executable, args);

        var procInfo = {
            process: proc,
            exited: false,
            stdout: [],
            stderr: [],
            errorInfo: null
        };

        proc.stdout.on('data', (data) => {
            var lines = (data+"").split('\n');
            for (var i=0, line; (line=lines[i]); i++) {
                if (null == line) continue;
                if (line.trim().length > 0) {
                    output.appendLine(line);
                    procInfo.stdout.push(line);
                }
            }
        });

        proc.stderr.on('data', (data) => {
            var lines = (data+"").split('\n');
            for (var i=0, line; (line=lines[i]); i++) {
                if (null == line) continue;
                if (line.trim().length > 0) {
                    output.appendLine(line);
                    procInfo.stderr.push(line);
                }
            }
        });

        proc.on('error', (err) => {
            procInfo.exited = true;
            procInfo.errorInfo = err;
            if (null != errorFunction) {
                errorFunction(procInfo);
            } else {
                output.appendLine(`failed to start ${executable}`);
                vscode.window.showErrorMessage("failed to start '" + executable + "'");
            }
        });

        proc.on('exit', (code) => {
            procInfo.exited = true;
            procInfo.exitCode = code;
            if (0 == code) {
                if (null != successFunction) {
                    successFunction(procInfo);
                } else {
                    output.appendLine('done');
                }
            } else {
                if (null != errorFunction) {
                    errorFunction(procInfo);
                } else {
                    output.appendLine(`child process exited with code ${code}`);
                    vscode.window.showInformationMessage("failed: '" + cmd + "'");
                }
            }
        });

        return procInfo;
    }

    getExecutableState(filename) {

        if (null == filename || filename == "") return " [NOT SET]";

        var path = Utils.getAbsoluteFilename(filename);

        if (null == path || path == "") return " [INVALID]";

        try {
            var stat = fs.lstatSync(path);
            if (stat.isDirectory()) {
                return " [MISMATCH: directory instead of file name specified]";
            }
        } catch (err) {
            if (err.code == 'ENOENT') {
                return " [ERROR: file not found]";
            }
            return " [" + err.message + "]";
        }

        try {
            fs.accessSync(path, fs.constants.X_OK);
        } catch (err) {
            return " [" + err.message + "]";
        }

        return null;
    }

    logExecutableState(filename, format) {

        var state = this.getExecutableState(filename);
        if (null == state) {
            console.log(format + " [OK]");
            return;
        }

        console.error(format + state);
    }

    updateSettings() {

        let settings = this._settings;

        let workspaceConfig = vscode.workspace.getConfiguration();

        settings.verbose = workspaceConfig.get("vc65x.verbose")||false;

        if (true == settings.verbose) {
            console.log("[VC65X] extension verbose mode enabled");
        }

        settings.autoBuild = workspaceConfig.get("vc65x.autoBuild")||true;
        if (true == settings.verbose && true == settings.autoBuild) {
            console.log("[VC65X] auto build enabled");
        }

        settings.definitions = workspaceConfig.get("vc65x.definitions") || "";

        settings.backgroundBuild = workspaceConfig.get("vc65x.backgroundBuild")||true;
        if (true == settings.verbose && true == settings.backgroundBuild) {
            console.log("[VC65X] background build enabled");
        }

        settings.assemblerPath = Utils.findExecutable(workspaceConfig.get("vc65x.assemblerPath")||"");
        settings.assemblerArgs = workspaceConfig.get("vc65x.assemblerArgs")||"";
        settings.assemblerSearchPath = workspaceConfig.get("vc65x.assemblerSearchPath");
        settings.assemblerEnabled = (settings.assemblerPath != "");

        if (true == settings.verbose) {
            this.logExecutableState(settings.assemblerPath, "[VC65X] assembler path: " + settings.assemblerPath);
        }

        settings.emulatorPath = Utils.findExecutable(workspaceConfig.get("vc65x.emulatorPath")||"");
        settings.emulatorArgs = workspaceConfig.get("vc65x.emulatorArgs")||"";
        settings.emulatorEnabled = (settings.emulatorPath != "");

        if (true == settings.verbose) {
            this.logExecutableState(settings.emulatorPath, "[VC65X] emulator path: " + settings.emulatorPath);
        }

        settings.debuggerEnabled = workspaceConfig.get("vc65x.debuggerEnabled")||false;
        settings.debuggerPath = Utils.findExecutable(workspaceConfig.get("vc65x.debuggerPath")||"");
        settings.debuggerArgs = workspaceConfig.get("vc65x.debuggerArgs")||"";
        if (settings.debuggerPath == "") {
            settings.debuggerEnabled = false;
        }

        if (true == settings.verbose) {
            if (settings.debuggerEnabled) {
                this.logExecutableState(settings.debuggerPath, "[VC65X] debugger path: " + settings.debuggerPath);
            } else {
                console.log("[VC65X] using emulator for debugging (vc65x debugger disabled)");
            }
        }
    }
}

//-----------------------------------------------------------------------------------------------//
// Extension Entry Point
//-----------------------------------------------------------------------------------------------//

var extensionInstance = null;

/**
 * @param {vscode.ExtensionContext} context
 */
function activate(context) {

    return new Promise(function(resolve /*, reject*/) {
        if (null == extensionInstance) {
            extensionInstance = new Extension(context);
            extensionInstance.activate();
        }
        resolve();
    });
}

function deactivate() {
    return new Promise(function(resolve /*, reject*/) {
        if (null == extensionInstance) {
            extensionInstance.deactivate();
            extensionInstance = null;
        }
        resolve();
    });
}

function getNonce() {
	let text = '';
	const possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
	for (let i = 0; i < 32; i++) {
		text += possible.charAt(Math.floor(Math.random() * possible.length));
	}
	return text;
}

//-----------------------------------------------------------------------------------------------//
// Module Exports
//-----------------------------------------------------------------------------------------------//

module.exports = {
    activate: activate,
    deactivate: deactivate
};
