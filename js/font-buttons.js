(function () {
    function applyFontSize(size) {
        document.body.style.fontSize = size + 'em';
        localStorage.setItem('fontSize', size);
    }

    function increaseFontSize() {
        let currentSize = parseFloat(localStorage.getItem('fontSize')) || 1;
        if (currentSize < 2.5) {
            applyFontSize((currentSize + 0.1).toFixed(1));
        }
    }

    function decreaseFontSize() {
        let currentSize = parseFloat(localStorage.getItem('fontSize')) || 1;
        if (currentSize > 0.6) {
            applyFontSize((currentSize - 0.1).toFixed(1));
        }
    }

    window.addEventListener('DOMContentLoaded', () => {
        let storedSize = parseFloat(localStorage.getItem('fontSize')) || 1;
        applyFontSize(storedSize.toFixed(1));

        let div = document.createElement('div');
        div.id = 'font-controls';
        div.style.position = 'fixed';
        div.style.bottom = '48px';
        div.style.right = '10px';
        div.style.zIndex = '9999';
        div.style.background = '#fff';
        div.style.border = '1px solid #ccc';
        div.style.borderRadius = '5px';
        div.style.padding = '5px';
        div.style.boxShadow = '0 0 5px rgba(0,0,0,0.2)';
       // div.innerHTML = ` // this is white buttons // below is red/green buttons
            //<button id="font-decrease">A-</button>
            //<button id="font-increase">A+</button>
        div.innerHTML = `
            <button id="font-decrease" style="background-color:#4CAF50;color:white;border:none;padding:5px 10px;margin:2px;border-radius:4px;">A-</button>
            <button id="font-increase" style="background-color:#f44336;color:white;border:none;padding:5px 10px;margin:2px;border-radius:4px;">A+</button>
        `;

        document.body.appendChild(div);

        // Attach event listeners
        document.getElementById('font-decrease').addEventListener('click', decreaseFontSize);
        document.getElementById('font-increase').addEventListener('click', increaseFontSize);
    });
})();
