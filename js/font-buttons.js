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

    // Optional: Add buttons dynamically if not in HTML
    if (!document.getElementById('font-controls')) {
        let div = document.createElement('div');
        div.id = 'font-controls';
        div.style.position = 'fixed';
        div.style.bottom = '10px';
        div.style.right = '10px';
        div.style.zIndex = '9999';
        div.innerHTML = `
            <button onclick="decreaseFontSize()">A-</button>
            <button onclick="increaseFontSize()">A+</button>
        `;
        document.body.appendChild(div);
    }
});
