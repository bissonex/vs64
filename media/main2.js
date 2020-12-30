
import Display from './ui/display.js';
import KeyBoard from './ui/keyboard.js';

// This script will be run within the webview itself
// It cannot access the main VS Code APIs directly.
(function () {
	var keyboard;
	var display;
	var focused = false;
	var canvas1 = document.getElementById('screen');

	var options = {
		screen: [],
		multiScreen: false,
		e: false,
		enhanced: false,
		cards: [],
	};

	const vscode = acquireVsCodeApi();
	// const oldState = vscode.getState() || { colors: [] };

	// /** @type {Array<{ value: string }>} */
	// let colors = oldState.colors;

	// updateColorList(colors);

	// document.querySelector('.add-color-button').addEventListener('click', () => {
	// 	addColor();
	// });

	// // Handle messages sent from the extension to the webview
	// window.addEventListener('message', event => {
	// 	const message = event.data; // The json data that the extension sent
	// 	switch (message.type) {
	// 		case 'addColor':
	// 			{
	// 				addColor();
	// 				break;
	// 			}
	// 		case 'clearColors':
	// 			{
	// 				colors = [];
	// 				updateColorList(colors);
	// 				break;
	// 			}

	// 	}
	// });

	// Handle messages sent from the extension to the webview
	window.addEventListener('message', event => {
		const message = event.data; // The json data that the extension sent
		switch (message.type) {
			case 'drawChar':
				{
					display.drawChar(message.charCode, message.hpos, message.vpos);
					break;
				}
		}
	});

	/*
	 * Input Handling
	 */

	window.addEventListener('keydown', _keydown);
	window.addEventListener('keyup', _keyup);

	// window.addEventListener('keydown', audio.autoStart);
	// if (window.ontouchstart !== undefined) {
	//     window.addEventListener('touchstart', audio.autoStart);
	// }
	// window.addEventListener('mousedown', audio.autoStart);

	// window.addEventListener('paste', (event) => {
	//     var paste = (event.clipboardData || window.clipboardData).getData('text');
	//     io.setKeyBuffer(paste);
	//     event.preventDefault();
	// });

	// window.addEventListener('copy', (event) => {
	//     event.clipboardData.setData('text/plain', vm.getText());
	//     event.preventDefault();
	// });

	const scanlines = true;
	// const green = true;
	var overscan = document.querySelector('.overscan');
	// var screen = document.querySelector('#screen');

    if (scanlines) {
        overscan.classList.add('scanlines');
    } else {
        overscan.classList.remove('scanlines');
    }
    // if (green) {
    //     screen.classList.add('green');
    // } else {
    //     screen.classList.remove('green');
	// }

	keyboard = new KeyBoard(vscode);
	keyboard.create('#keyboard');

	display = new Display(vscode);
	display.create('screen');

	display.setColor0(1);
	display.setColor1(12);
	display.init(canvas1.getContext('2d'));

	display.drawChar("R".charCodeAt(0), 1, 1);
	display.drawChar("E".charCodeAt(0), 2, 1);
	display.drawChar('A'.charCodeAt(0), 3, 1);
	display.drawChar('D'.charCodeAt(0), 4, 1);
	display.drawChar('Y'.charCodeAt(0), 5, 1);
	display.drawChar('!'.charCodeAt(0), 6, 1);
	display.drawChar(']'.charCodeAt(0), 1, 2);

	/*
	 * Keyboard/Gamepad routines
	 */

	function _keydown(evt) {
		if (!focused && (!evt.metaKey || evt.ctrlKey || window.e)) {
			evt.preventDefault();

			var key = keyboard.mapKeyEvent(evt);
			if (key != 0xff) {
				// io.keyDown(key);
				vscode.postMessage({ type: 'keyPressed', value: key});
			}
		}
		if (evt.keyCode === 112) { // F1 - Reset
			// cpu.reset();
			evt.preventDefault(); // prevent launching help
		} else if (evt.keyCode === 113) { // F2 - Full Screen
			var elem = document.getElementById('screen');
			if (evt.shiftKey) { // Full window, but not full screen
				document.body.classList.toggle('full-page');
			} else if (document.webkitCancelFullScreen) {
				if (document.webkitIsFullScreen) {
					document.webkitCancelFullScreen();
				} else {
					if (Element.ALLOW_KEYBOARD_INPUT) {
						elem.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
					} else {
						elem.webkitRequestFullScreen();
					}
				}
			} else if (document.mozCancelFullScreen) {
				if (document.mozIsFullScreen) {
					document.mozCancelFullScreen();
				} else {
					elem.mozRequestFullScreen();
				}
			}
		} else if (evt.keyCode === 114) { // F3
			// io.keyDown(0x1b);
			vscode.postMessage({ type: 'keyPressed', value: 0x1b });
		} else if (evt.keyCode === 117) { // F6 Quick Save
			// _apple2.getState();
		} else if (evt.keyCode === 120) { // F9 Quick Restore
			// _apple2.setState();
		} else if (evt.keyCode == 16) { // Shift
			keyboard.shiftKey(true);
		} else if (evt.keyCode == 20) { // Caps lock
			keyboard.capslockKey();
		} else if (evt.keyCode == 17) { // Control
			keyboard.controlKey(true);
		} else if (evt.keyCode == 91 || evt.keyCode == 93) { // Command
			keyboard.commandKey(true);
		} else if (evt.keyCode == 18) { // Alt
			if (evt.location == 1) {
				keyboard.commandKey(true);
			} else {
				keyboard.optionKey(true);
			}
		}
	}

	function _keyup(evt) {
		if (!focused)
			// io.keyUp();

			if (evt.keyCode == 16) { // Shift
				keyboard.shiftKey(false);
			} else if (evt.keyCode == 17) { // Control
				keyboard.controlKey(false);
			} else if (evt.keyCode == 91 || evt.keyCode == 93) { // Command
				keyboard.commandKey(false);
			} else if (evt.keyCode == 18) { // Alt
				if (evt.location == 1) {
					keyboard.commandKey(false);
				} else {
					keyboard.optionKey(false);
				}
			}
	}
}());


