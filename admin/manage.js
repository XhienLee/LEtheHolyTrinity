document.addEventListener('DOMContentLoaded', function() {
    // Tab switching functionality
    const tabButtons = document.querySelectorAll('.tab-button');
    const tabPanes = document.querySelectorAll('.tab-pane');
    
    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Remove active class from all buttons and panes
            tabButtons.forEach(btn => btn.classList.remove('active'));
            tabPanes.forEach(pane => pane.classList.remove('active'));
            
            // Add active class to clicked button and corresponding pane
            this.classList.add('active');
            const tabId = this.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');
            
            // Load data for the selected tab
            loadData(tabId);
        });
    });
    
    // Search functionality
    document.getElementById('studentSearchBtn').addEventListener('click', function() {
        searchData('students', document.getElementById('studentSearch').value);
    });
    
    document.getElementById('instructorSearchBtn').addEventListener('click', function() {
        searchData('instructors', document.getElementById('instructorSearch').value);
    });
    
    document.getElementById('staffSearchBtn').addEventListener('click', function() {
        searchData('staff', document.getElementById('staffSearch').value);
    });
    
    // Enter key press for search
    document.getElementById('studentSearch').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            searchData('students', this.value);
        }
    });
    
    document.getElementById('instructorSearch').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            searchData('instructors', this.value);
        }
    });
    
    document.getElementById('staffSearch').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            searchData('staff', this.value);
        }
    });
    
    // Initial data load for the active tab
    loadData('students');
});

// Function to load data from the server
function loadData(category, searchTerm = '') {
    // Show loader
    document.getElementById('loader').style.display = 'block';
    
    // Create form data
    const formData = new FormData();
    formData.append('category', category);
    if (searchTerm) {
        formData.append('search', searchTerm);
    }
    
    // Fetch data
    fetch('load_data.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        // Hide loader
        document.getElementById('loader').style.display = 'none';
        
        // Display data
        displayData(category, data);
    })
    .catch(error => {
        console.error('Error loading data:', error);
        document.getElementById('loader').style.display = 'none';
        document.getElementById(`${category}Data`).innerHTML = 'Error loading data. Please try again.';
    });
}

// Search function
function searchData(category, searchTerm) {
    loadData(category, searchTerm);
}

// Display data in table format
function displayData(category, data) {
    const container = document.getElementById(`${category}Data`);
    
    if (data.length === 0) {
        container.innerHTML = `<p>No ${category} found.</p>`;
        return;
    }
    
    // Create table
    let html = '<table>';
    
    // Create headers based on first item keys
    html += '<thead><tr>';
    Object.keys(data[0]).forEach(key => {
        if (key !== 'id') { // Skip ID column if not needed for display
            html += `<th>${key.charAt(0).toUpperCase() + key.slice(1)}</th>`;
        }
    });
    html += '<th>Actions</th>';
    html += '</tr></thead>';
    
    // Create rows
    html += '<tbody>';
    data.forEach(item => {
        html += '<tr>';
        Object.keys(item).forEach(key => {
            if (key !== 'id') {
                html += `<td>${item[key]}</td>`;
            }
        });
        html += `<td>
            <button class="view-btn" data-id="${item.id}" data-category="${category}">View</button>
            <button class="edit-btn" data-id="${item.id}" data-category="${category}">Edit</button>
        </td>`;
        html += '</tr>';
    });
    html += '</tbody>';
    html += '</table>';
    
    container.innerHTML = html;
    
    // Add event listeners to action buttons
    addActionButtonListeners(category);
}

// Add event listeners to view and edit buttons
function addActionButtonListeners(category) {
    const viewButtons = document.querySelectorAll(`.view-btn[data-category="${category}"]`);
    const editButtons = document.querySelectorAll(`.edit-btn[data-category="${category}"]`);
    
    viewButtons.forEach(button => {
        button.addEventListener('click', function() {
            const id = this.getAttribute('data-id');
            alert(`View details for ${category} ID: ${id}`);
            // You can replace this with a modal or redirect to a details page
        });
    });
    
    editButtons.forEach(button => {
        button.addEventListener('click', function() {
            const id = this.getAttribute('data-id');
            alert(`Edit ${category} ID: ${id}`);
            // You can replace this with a modal or redirect to an edit page
        });
    });
}