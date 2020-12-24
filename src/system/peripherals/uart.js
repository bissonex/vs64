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

const createUartDevice = () => {
  return {
    getUint16: () => 0,
    getUint8: (address) => 0,
    setUint8: (address, data) => {
      const characterValue = data;
      const character = String.fromCharCode(characterValue);
      process.stdout.write(character);
    },
    setUint16: (address, data) => {
    }
  }
};

module.exports = createUartDevice;