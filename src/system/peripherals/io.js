const vscode = require('vscode');
const { keys } = require('../../../roms/1541');

var view = null;
var charCode = 0x20;
var loc = 0x00;
var hpos = 1;
var vpos = 1;
var lowByte = 0;
var highByte = 0;
var isLowByte = true;
var isLocOk = false;
var cra = 1;
var crb = 1;

var buffer = [];
var emulatorViewProvider = null;

var keyboard=[];

keyboard[0x0D] = [0x02, 0x00];				//	CR
keyboard[0x20] = [0x02, 0x03];				//	SPACE
// keyboard[0x21] = [0x00, 0x01];				//	!
// keyboard[0x22] = [0x00, 0x01];				//	"
// keyboard[0x23] = [0x00, 0x01];				//	#
// keyboard[0x24] = [0x00, 0x01];				//	$
// keyboard[0x25] = [0x00, 0x01];				//	%
// keyboard[0x26] = [0x00, 0x01];				//	@
// keyboard[0x27] = [0x00, 0x01];				//	'
// keyboard[0x28] = [0x00, 0x01];				//	(
// keyboard[0x29] = [0x00, 0x01];				//	)
// keyboard[0x2A] = [0x00, 0x01];				//	*
// keyboard[0x2B] = [0x00, 0x01];				//	+
// keyboard[0x2C] = [0x00, 0x01];				//	,
// keyboard[0x2D] = [0x00, 0x01];				//	-
// keyboard[0x2E] = [0x00, 0x01];				//	.
// keyboard[0x2F] = [0x00, 0x01];				//	/

keyboard[0x30] = [0x00, 0x01];				//	0
keyboard[0x31] = [0x00, 0x05];				//	1
keyboard[0x32] = [0x03, 0x05];				//	2
keyboard[0x33] = [0x04, 0x05];				//	3
keyboard[0x34] = [0x05, 0x05];				//	4
keyboard[0x35] = [0x01, 0x05];				//	5
keyboard[0x36] = [0x01, 0x01];				//	6
keyboard[0x37] = [0x05, 0x01];				//	7
keyboard[0x38] = [0x04, 0x01];				//	8
keyboard[0x39] = [0x03, 0x01];				//	9

// keyboard[0x3A] = [0x00, 0x01];				//	:
keyboard[0x3B] = [0x00, 0x03];				//	;
keyboard[0x3C] = [0x04, 0x04];				//	<
keyboard[0x3D] = [0x02, 0x04];				//	=
keyboard[0x3E] = [0x03, 0x04];				//	>
// keyboard[0x3F] = [0x00, 0x01];				//	?

keyboard[0x40] = [0x00, 0x01];				//	@
keyboard[0x41] = [0x00, 0x02];				//	A
keyboard[0x42] = [0x01, 0x07];				//	B
keyboard[0x43] = [0x04, 0x07];				//	C
keyboard[0x44] = [0x04, 0x02];				//	D
keyboard[0x45] = [0x04, 0x06];				//	E
keyboard[0x46] = [0x05, 0x02];				//	F
keyboard[0x47] = [0x01, 0x02];				//	G
keyboard[0x48] = [0x01, 0x03];				//	H
keyboard[0x49] = [0x04, 0x00];				//	I
keyboard[0x4A] = [0x05, 0x03];				//	J
keyboard[0x4B] = [0x04, 0x03];				//	K
keyboard[0x4C] = [0x03, 0x03];				//	L
keyboard[0x4D] = [0x05, 0x04];				//	M
keyboard[0x4E] = [0x01, 0x04];				//	N
keyboard[0x4F] = [0x03, 0x00];				//	O
keyboard[0x50] = [0x00, 0x00];				//	P
keyboard[0x51] = [0x00, 0x06];				//	Q
keyboard[0x52] = [0x05, 0x06];				//	R
keyboard[0x53] = [0x03, 0x02];				//	S
keyboard[0x54] = [0x01, 0x06];				//	T
keyboard[0x55] = [0x05, 0x00];				//	U
keyboard[0x56] = [0x05, 0x07];				//	V
keyboard[0x57] = [0x03, 0x06];				//	W
keyboard[0x58] = [0x03, 0x07];				//	X
keyboard[0x59] = [0x01, 0x00];				//	Y
keyboard[0x5A] = [0x00, 0x07];				//	Z

// keyboard[0x5B] = [0x00, 0x01];				//	[
// keyboard[0x5C] = [0x00, 0x01];				//	\
// keyboard[0x5D] = [0x00, 0x01];				//	]
// keyboard[0x5E] = [0x00, 0x01];				//	^
// keyboard[0x5F] = [0x00, 0x01];				//	_
// keyboard[0x60] = [0x00, 0x01];				//	`

const createIOPort = (session) => {
  // var emulatorViewProvider = session._host._extension._uiView;

  // emulatorViewProvider.webview.onDidReceiveMessage(data => {
  //   switch (data.type) {
  //     case 'keyPressed':
  //       {
  //         buffer.push(data.value);
  //       }
  //   }
  // });

  return {

    getUint16: () => 0,
    getUint8: (address) => {
      if (emulatorViewProvider == null) {
        emulatorViewProvider = session._host._extension._uiView;
        emulatorViewProvider._view.webview.onDidReceiveMessage(data => {
          switch (data.type) {
            case 'keyPressed':
              {
                buffer.push(data.value);
              }
          }
        });
      }
      var regVal;
      switch (address) {
        case 0x00:    // PORTA_DDRA
          if (cra == 0x04) {
            if (buffer.length > 0) {
              regVal = buffer.pop();
              regVal = (~(1 << keyboard[regVal][1])) & 0xFF;
            } else {
              regVal = 0xFF;
            }
          }
          break;

        case 0x01:    // CRA
          break;

        case 0x02:    // PORTB_DDRB
        if (crb == 0x04) {
          if (buffer.length > 0) {
            regVal = buffer[buffer.length - 1];
            regVal = (~(1 << keyboard[regVal][0])) & 0xFF;
          } else {
            regVal = 0xFF;
          }
        }
          break;

        case 0x03:    // CRB
          break;

        default:
          break;
      }
      return regVal;
    },
    setUint8: (address, data) => {
      switch (address) {
        case 0x01:
          cra = data;
          break;

        case 0x03:
          crb = data;
          break;

        default:
          break;
      }
    },
    setUint16: (address, data) => {
    }
  }
};

module.exports = createIOPort;