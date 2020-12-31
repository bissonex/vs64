
// This script will be run within the webview itself
// It cannot access the main VS Code APIs directly.
(function () {

    const vscode = acquireVsCodeApi();

    let myElements = document.querySelectorAll(".hexfield");
    for (let i = 0; i < myElements.length; i++) {
        myElements[i].addEventListener('click', () => {
            let myElements = document.querySelectorAll(".hexfield");
            for (let i = 0; i < myElements.length; i++) {
                myElements[i].style.visibility = 'collapse';
            }
            myElements = document.querySelectorAll(".bitfield");
            for (let i = 0; i < myElements.length; i++) {
                myElements[i].style.visibility = 'visible';
            }
        });
    }

    myElements = document.querySelectorAll(".bitfield");
    for (let i = 0; i < myElements.length; i++) {
        myElements[i].addEventListener('click', () => {
            let myElements = document.querySelectorAll(".bitfield");
            for (let i = 0; i < myElements.length; i++) {
                myElements[i].style.visibility = 'collapse';
            }
            myElements = document.querySelectorAll(".hexfield");
            for (let i = 0; i < myElements.length; i++) {
                myElements[i].style.visibility = 'visible';
            }
        });
    }

    // Handle messages sent from the extension to the webview
    window.addEventListener('message', event => {
        const ZEROS = "0000000000000000000000000000000000000000";

        function fmt(n, digits, rightFill) {
            if (rightFill) {
                return (n.toString(16) + ZEROS).substr(0, digits).toUpperCase();
            } else {
                return (ZEROS + n.toString(16)).substr(-digits).toUpperCase();
            }
        }

        function formatByte(value) {
            //return "$" + Utils.fmt(value.toString(16), 2) + " (" + value.toString() + ")";
            return fmt(value.toString(16), 2);
        }

        function formatWord(value) {
            //return "$" + Utils.fmt(value.toString(16), 4) + " (" + value.toString() + ")";
            return fmt(value.toString(16), 4);
        }

        const message = event.data; // The json data that the extension sent
        switch (message.type) {
            case 'registers':
                {
                    document.getElementById("A").innerHTML = formatByte(message.value.registers.A);
                    for (let index = 0; index < 8; index++) {
                        document.getElementById("A"+index.toString()).innerHTML = (message.value.registers.A & (1 << index)?'1':'0');
                    }
                    document.getElementById("X").innerHTML = formatByte(message.value.registers.X);
                    for (let index = 0; index < 8; index++) {
                        document.getElementById("X"+index.toString()).innerHTML = (message.value.registers.X & (1 << index)?'1':'0');
                    }
                    document.getElementById("Y").innerHTML = formatByte(message.value.registers.Y);
                    for (let index = 0; index < 8; index++) {
                        document.getElementById("Y"+index.toString()).innerHTML = (message.value.registers.Y & (1 << index)?'1':'0');
                    }
                    document.getElementById("PCL").innerHTML = formatByte((message.value.PC & 0xFF));
                    document.getElementById("PCH").innerHTML = formatByte(((message.value.PC >> 8) & 0xFF));
                    for (let index = 0; index < 16; index++) {
                        document.getElementById("PC"+index.toString()).innerHTML = (message.value.PC & (1 << index)?'1':'0');
                    }
                    document.getElementById("S").innerHTML = formatByte(message.value.registers.S);
                    for (let index = 0; index < 8; index++) {
                        document.getElementById("S"+index.toString()).innerHTML = (message.value.registers.S & (1 << index)?'1':'0');
                    }
                    break;
                }

            case 'flags':
                {
                    var element = document.getElementById("Negative");
                    if (((element.classList.contains("flagSet")) && message.value.N == 0) ||
                        ((element.classList.contains("flagReset")) && message.value.N == 1)) {
                        element.classList.remove("flagNotChanged");
                        element.classList.add("flagChanged");
                        element.classList.add("highlight_it");
                    } else {
                        element.classList.remove("highlight_it");
                        element.classList.remove("flagChanged");
                        element.classList.add("flagNotChanged");
                    }
                    if (message.value.N == 1) {
                        element.classList.add("flagSet");
                        element.classList.remove("flagReset");
                    } else {
                        element.classList.remove("flagSet");
                        element.classList.add("flagReset");
                    }


                    var element = document.getElementById("Overflow");
                    if (((element.classList.contains("flagSet")) && message.value.V == 0) ||
                        ((element.classList.contains("flagReset")) && message.value.V == 1)) {
                        element.classList.remove("flagNotChanged");
                        element.classList.add("flagChanged");
                        element.classList.add("highlight_it");
                    } else {
                        element.classList.remove("highlight_it");
                        element.classList.remove("flagChanged");
                        element.classList.add("flagNotChanged");
                    }
                    if (message.value.V == 1) {
                        element.classList.add("flagSet");
                        element.classList.remove("flagReset");
                    } else {
                        element.classList.remove("flagSet");
                        element.classList.add("flagReset");
                    }

                    var element = document.getElementById("Break");
                    if (((element.classList.contains("flagSet")) && message.value.B == 0) ||
                        ((element.classList.contains("flagReset")) && message.value.B == 1)) {
                        element.classList.remove("flagNotChanged");
                        element.classList.add("flagChanged");
                        element.classList.add("highlight_it");
                    } else {
                        element.classList.remove("highlight_it");
                        element.classList.remove("flagChanged");
                        element.classList.add("flagNotChanged");
                    }
                    if (message.value.B == 1) {
                        element.classList.add("flagSet");
                        element.classList.remove("flagReset");
                    } else {
                        element.classList.remove("flagSet");
                        element.classList.add("flagReset");
                    }

                    var element = document.getElementById("Decimal");
                    if (((element.classList.contains("flagSet")) && message.value.D == 0) ||
                        ((element.classList.contains("flagReset")) && message.value.D == 1)) {
                        element.classList.remove("flagNotChanged");
                        element.classList.add("flagChanged");
                        element.classList.add("highlight_it");
                    } else {
                        element.classList.remove("highlight_it");
                        element.classList.remove("flagChanged");
                        element.classList.add("flagNotChanged");
                    }
                    if (message.value.D == 1) {
                        element.classList.add("flagSet");
                        element.classList.remove("flagReset");
                    } else {
                        element.classList.remove("flagSet");
                        element.classList.add("flagReset");
                    }

                    var element = document.getElementById("Irq");
                    if (((element.classList.contains("flagSet")) && message.value.I == 0) ||
                        ((element.classList.contains("flagReset")) && message.value.I == 1)) {
                        element.classList.remove("flagNotChanged");
                        element.classList.add("flagChanged");
                        element.classList.add("highlight_it");
                    } else {
                        element.classList.remove("highlight_it");
                        element.classList.remove("flagChanged");
                        element.classList.add("flagNotChanged");
                    }
                    if (message.value.I == 1) {
                        element.classList.add("flagSet");
                        element.classList.remove("flagReset");
                    } else {
                        element.classList.remove("flagSet");
                        element.classList.add("flagReset");
                    }

                    var element = document.getElementById("Zero");
                    if (((element.classList.contains("flagSet")) && message.value.Z == 0) ||
                        ((element.classList.contains("flagReset")) && message.value.Z == 1)) {
                        element.classList.remove("flagNotChanged");
                        element.classList.add("flagChanged");
                        element.classList.add("highlight_it");
                    } else {
                        element.classList.remove("highlight_it");
                        element.classList.remove("flagChanged");
                        element.classList.add("flagNotChanged");
                    }
                    if (message.value.Z == 1) {
                        element.classList.add("flagSet");
                        element.classList.remove("flagReset");
                    } else {
                        element.classList.remove("flagSet");
                        element.classList.add("flagReset");
                    }

                    var element = document.getElementById("Carry");
                    if (((element.classList.contains("flagSet")) && message.value.C == 0) ||
                        ((element.classList.contains("flagReset")) && message.value.C == 1)) {
                        element.classList.remove("flagNotChanged");
                        element.classList.add("flagChanged");
                        element.classList.add("highlight_it");
                    } else {
                        element.classList.remove("highlight_it");
                        element.classList.remove("flagChanged");
                        element.classList.add("flagNotChanged");
                    }
                    if (message.value.C == 1) {
                        element.classList.add("flagSet");
                        element.classList.remove("flagReset");
                    } else {
                        element.classList.remove("flagSet");
                        element.classList.add("flagReset");
                    }

                    break;
                }
        }
    });

}());
