(function () {
    // Apply stored font size
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

    // Wait for DOM to be ready
    window.addEventListener('DOMContentLoaded', () => {
        // Set initial font size
        let storedSize = parseFloat(localStorage.getItem('fontSize')) || 1;
        applyFontSize(storedSize.toFixed(1));

        // Create button container
        let div = document.createElement('div');
        div.id = 'font-controls';
        div.style.position = 'fixed';
        div.style.bottom = '10px';
        div.style.left = '10px'; // Now on bottom left
        div.style.zIndex = '9999';
        div.style.background = '#fff';
        div.style.border = '1px solid #ccc';
        div.style.borderRadius = '5px';
        div.style.padding = '5px';
        div.style.boxShadow = '0 0 5px rgba(0,0,0,0.2)';
        div.innerHTML = `
            <button onclick="(${decreaseFontSize.toString()})()">A-</button>
            <button onclick="(${increaseFontSize.toString()})()">A+</button>
        `;
        document.body.appendChild(div);
    });
})();
