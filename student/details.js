// Open the side overlay
document.querySelector('.circle-btn').addEventListener('click', () => {
    document.getElementById('sideOverlay').classList.add('open');
});

// Close the side overlay
function closeOverlay() {
    document.getElementById('sideOverlay').classList.remove('open');
}

// Collapsible functionality
document.querySelectorAll('.collapsible-btn').forEach(button => {
    button.addEventListener('click', () => {
        button.classList.toggle('active');
        const content = button.nextElementSibling;
        content.style.display = content.style.display === 'block' ? 'none' : 'block';
    });
});
// Tab functionality
document.querySelectorAll('.tab-btn').forEach(button => {
    button.addEventListener('click', () => {
        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
        button.classList.add('active');
        document.getElementById(button.dataset.tab).classList.add('active');
    });
});

// Collapsible functionality
document.querySelectorAll('.collapsible-btn').forEach(button => {
    button.addEventListener('click', () => {
        button.classList.toggle('active');
        const content = button.nextElementSibling;
        content.style.display = content.style.display === 'block' ? 'none' : 'block';
    });
});
