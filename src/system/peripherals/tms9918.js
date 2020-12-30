const vscode = require('vscode');

var view = null;
var charCode = 0x20;
var loc = 0x00;
var hpos = 1;
var vpos = 1;
var lowByte = 0;
var highByte = 0;
var isLowByte = true;
var isLocOk = false;

const eraseScreen = () => {
  process.stdout.write('\x1b[2J');
}

const moveTo = (x, y) => {
  process.stdout.write(`\x1b[${y};${x}H`);
}

const setBold = () => {
  process.stdout.write('\x1b[1m');
}

const setRegular = () => {
  process.stdout.write('\x1b[0m');
}

const createVPUDevice = (session) => {
  var emulatorViewProvider = session._host._extension._uiView;
  return {
    getUint16: () => 0,
    getUint8: (address) => 0,
    setUint8: (address, data) => {
      switch (address) {
        case 0x00:
          charCode = data & 0x7F;
          if (isLocOk == true) {
            var emulatorViewProvider = session._host._extension._uiView;
            emulatorViewProvider._view.webview.postMessage({ type: 'drawChar', charCode: charCode, hpos: hpos, vpos: vpos });
            isLocOk = false;
          }
          break;

        case 0x01:
          if (isLowByte == true) {
            lowByte = data;
            isLowByte = false;
          } else {
            if ((data & 0xC0) == 0x40) {
              highByte = data & 0x3F;

              let temp = (highByte << 8) + lowByte;
              hpos = (temp % 40) + 1;
              vpos = (Math.floor(temp/40)) + 1;
              if (((hpos >= 1) && (hpos <=40)) && ((vpos >= 1) && (vpos <= 24))) {
                isLocOk = true;
              }
            }
            isLowByte = true;
          }

          break;

        default:
          break;
      }
    },
    setUint16: (address, data) => {
    }
  }
};

module.exports = createVPUDevice;