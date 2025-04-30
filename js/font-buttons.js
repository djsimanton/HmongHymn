document.addEventListener('DOMContentLoaded', function () {
  // Create font controls
  const fontControls = document.createElement('div');
  fontControls.style.position = 'fixed';
  fontControls.style.top = '10px';
  fontControls.style.right = '10px';
  fontControls.style.zIndex = '9999';
  fontControls.innerHTML = `
    <button id="font-increase" style="margin-right:5px;">A+</button>
    <button id="font-decrease">A−</button>
  `;
  document.body.appendChild(fontControls);

  const root = document.documentElement;
  let fontSize = parseFloat(localStorage.getItem('fontSize')) || 1.0;

  const applyFontSize = () => {
    root.style.fontSize = fontSize + 'em';
  };

  document.getElementById('font-increase').addEventListener('click', () => {
    fontSize = Math.min(fontSize + 0.1, 2.0);
    localStorage.setItem('fontSize', fontSize);
    applyFontSize();
  });

  document.getElementById('font-decrease').addEventListener('click', () => {
    fontSize = Math.max(fontSize - 0.1, 0.6);
    localStorage.setItem('fontSize', fontSize);
    applyFontSize();
  });

  applyFontSize(); // Apply on load
});
