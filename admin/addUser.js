document.addEventListener('DOMContentLoaded', () => {
    const typeButtons = document.querySelectorAll('.type-btn');
    const userSections = document.querySelectorAll('.user-section');

    typeButtons.forEach(button => {
        button.addEventListener('click', () => {
            typeButtons.forEach(btn => btn.classList.remove('active'));
            userSections.forEach(section => section.classList.remove('active'));
            button.classList.add('active');
            const type = button.getAttribute('data-type');
            document.getElementById(`${type}-section`).classList.add('active');
        });
    });

    const dropAreas = document.querySelectorAll('.drop-area');
    dropAreas.forEach(dropArea => {
        const fileInput = dropArea.querySelector('.file-input');
        const fileInfo = dropArea.querySelector('.file-info');
        const filename = dropArea.querySelector('.filename');
        const dropText = dropArea.querySelector('.drop-text');
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            dropArea.addEventListener(eventName, preventDefaults, false);
        });
        
        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }
        ['dragenter', 'dragover'].forEach(eventName => {
            dropArea.addEventListener(eventName, () => {
                dropArea.classList.add('highlight');
            }, false);
        });
        
        ['dragleave', 'drop'].forEach(eventName => {
            dropArea.addEventListener(eventName, () => {
                dropArea.classList.remove('highlight');
            }, false);
        });
        dropArea.addEventListener('drop', (e) => {
            const dt = e.dataTransfer;
            const files = dt.files;
            if (files.length > 0) {
                fileInput.files = files;
                fileInfo.style.display = 'block';
                filename.textContent = files[0].name;
            }
        }, false);
        dropArea.addEventListener('click', () => {
            fileInput.click();
        });
        fileInput.addEventListener('change', () => {
            if (fileInput.files.length > 0) {
                fileInfo.style.display = 'block';
                filename.textContent = fileInput.files[0].name;
            } else {
                fileInfo.style.display = 'none';
            }
        });
    });

    const manualButtons = document.querySelectorAll('.manual-btn');
    manualButtons.forEach(button => {
        button.addEventListener('click', () => {
            const section = button.closest('.user-section');
            const type = section.id.split('-')[0];
            const resultsArea = section.querySelector('.results-area');
            
            let formFields = '';
            formFields += `
                <div class="form-group">
                    <label for="${type}-name">Name:</label>
                    <input type="text" id="${type}-name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="${type}-id">ID:</label>
                    <input type="text" id="${type}-id" name="id" required>
                </div>
                <div class="form-group">
                    <label for="${type}-email">Email:</label>
                    <input type="email" id="${type}-email" name="email" required>
                </div>
            `;
            if (type === 'student') {
                formFields += `
                    <div class="form-group">
                        <label for="student-class">Class:</label>
                        <input type="text" id="student-class" name="class" required>
                    </div>
                `;
            } else if (type === 'instructor') {
                formFields += `
                    <div class="form-group">
                        <label for="instructor-department">Department:</label>
                        <input type="text" id="instructor-department" name="department" required>
                    </div>
                    <div class="form-group">
                        <label for="instructor-title">Title:</label>
                        <input type="text" id="instructor-title" name="title" required>
                    </div>
                `;
            } else if (type === 'staff') {
                formFields += `
                    <div class="form-group">
                        <label for="staff-department">Department:</label>
                        <input type="text" id="staff-department" name="department" required>
                    </div>
                    <div class="form-group">
                        <label for="staff-position">Position:</label>
                        <input type="text" id="staff-position" name="position" required>
                    </div>
                `;
            }
            resultsArea.innerHTML = `
                <form id="${type}-manual-form" class="manual-form">
                    <h3>Manual ${type.charAt(0).toUpperCase() + type.slice(1)} Entry</h3>
                    ${formFields}
                    <button type="submit" class="btn btn-primary">Add ${type.charAt(0).toUpperCase() + type.slice(1)}</button>
                </form>
            `;
            const manualForm = document.getElementById(`${type}-manual-form`);
            manualForm.addEventListener('submit', (e) => {
                e.preventDefault();
                const formData = new FormData(manualForm);
                const userData = {};
                formData.forEach((value, key) => {
                    userData[key] = value;
                });
                userData.type = type;
                displayResults(resultsArea, {
                    success: true,
                    message: `${type.charAt(0).toUpperCase() + type.slice(1)} added successfully`,
                    users: [userData]
                });
            });
        });
    });

    const importButtons = document.querySelectorAll('.import-btn');
    importButtons.forEach(button => {
        button.addEventListener('click', () => {
            const section = button.closest('.user-section');
            const type = section.id.split('-')[0];
            const resultsArea = section.querySelector('.results-area');
            const fileInput = section.querySelector('.file-input');
            if (!fileInput.files || fileInput.files.length === 0) {
                displayError(resultsArea, 'Please select a file to import.');
                return;
            }
            const file = fileInput.files[0];
            if (!file.name.toLowerCase().endsWith('.csv')) {
                displayError(resultsArea, 'Please select a CSV file.');
                return;
            }
            processCSVFile(file, resultsArea, type);
        });
    });
    function setupDragAndDrop() {
        const dropAreas = document.querySelectorAll('.drop-area');  
        dropAreas.forEach(dropArea => {
            const section = dropArea.closest('.user-section');
            const fileInput = section.querySelector('.file-input');
            ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
                dropArea.addEventListener(eventName, preventDefaults, false);
            });
            function preventDefaults(e) {
                e.preventDefault();
                e.stopPropagation();
            }
            ['dragenter', 'dragover'].forEach(eventName => {
                dropArea.addEventListener(eventName, highlight, false);
            });
            ['dragleave', 'drop'].forEach(eventName => {
                dropArea.addEventListener(eventName, unhighlight, false);
            });
            function highlight() {
                dropArea.classList.add('highlight');
            }
            function unhighlight() {
                dropArea.classList.remove('highlight');
            }
            dropArea.addEventListener('drop', handleDrop, false);
            function handleDrop(e) {
                const dt = e.dataTransfer;
                const files = dt.files;
                if (files.length > 0) {
                    fileInput.files = files;
                    updateFileInfo(section, files[0]);
                }
            }
        });
    }
    function updateFileInfo(section, file) {
        const fileInfoElement = section.querySelector('.file-info');
        if (fileInfoElement) {
            fileInfoElement.innerHTML = `Selected file: <span class="filename">${file.name}</span> (${formatFileSize(file.size)})`;
            fileInfoElement.style.display = 'block';
        }
    }
    function formatFileSize(bytes) {
        if (bytes < 1024) {
            return bytes + ' bytes';
        } else if (bytes < 1048576) {
            return (bytes / 1024).toFixed(1) + ' KB';
        } else {
            return (bytes / 1048576).toFixed(1) + ' MB';
        }
    }
    setupDragAndDrop();
    document.querySelectorAll('.file-input').forEach(input => {
        input.addEventListener('change', function() {
            if (this.files && this.files.length > 0) {
                const section = this.closest('.user-section');
                updateFileInfo(section, this.files[0]);
            }
        });
    });
});


function processCSVFile(file, resultsArea, type) {
    displayMessage(resultsArea, 'Processing CSV file...', 'info-message');
    const reader = new FileReader();
    reader.onload = function(event) {
        try {
            const csvData = event.target.result;
            const parsedData = parseCSV(csvData);
            if (parsedData.length < 2) {
                throw new Error('CSV file appears to be empty or invalid');
            }
            const headers = parsedData[0];
            const dataRows = parsedData.slice(1).filter(row => row.some(cell => cell.trim() !== ''));
            validateHeaders(headers, type);
            const processedData = processData(dataRows, headers, type);
        
            displayResults(resultsArea, {
                success: true,
                message: `Successfully imported ${dataRows.length} ${type}${dataRows.length !== 1 ? 's' : ''}`,
                users: processedData
            });
        } catch (error) {
            displayError(resultsArea, `Error processing CSV: ${error.message}`);
        }
    };
    reader.onerror = function() {
        displayError(resultsArea, 'Error reading file');
    };
    reader.readAsText(file);
}

function parseCSV(csvText) {
    const result = [];
    const lines = csvText.split(/\r?\n/);
    for (const line of lines) {
        const regex = /(".*?"|[^",]+)(?=\s*,|\s*$)/g;
        const values = [];
        let match;
        while ((match = regex.exec(line)) !== null) {
            let value = match[1];
            if (value.startsWith('"') && value.endsWith('"')) {
                value = value.substring(1, value.length - 1);
            }
            values.push(value.trim());
        }
        if (values.length > 0 && values.some(v => v.trim() !== '')) {
            result.push(values);
        }
    }
    return result;
}

function validateHeaders(headers, type) {
    let requiredHeaders = [];
    if (type === 'student') {
        requiredHeaders = ['name', 'email', 'class'];
    } else if (type === 'instructor') {
        requiredHeaders = ['name', 'email', 'department', 'title'];
    } else if (type === 'staff') {
        requiredHeaders = ['name', 'email', 'department', 'position'];
    }
    const lowercaseHeaders = headers.map(h => h.toLowerCase());
    for (const required of requiredHeaders) {
        if (!lowercaseHeaders.includes(required.toLowerCase())) {
            throw new Error(`Missing required column: ${required}`);
        }
    }
}

function processData(dataRows, headers, type) {
    const processedData = [];
    const lowercaseHeaders = headers.map(h => h.toLowerCase());
    for (let i = 0; i < dataRows.length; i++) {
        const row = dataRows[i];
        const userData = {};
        if (type === 'student') {
            userData.id = `1${String(i + 1).padStart(3, '0')}`;
        } else if (type === 'instructor') {
            userData.id = `2${String(i + 1).padStart(3, '0')}`;
        } else if (type === 'staff') {
            userData.id = `3${String(i + 1).padStart(3, '0')}`;
        }
        for (let j = 0; j < Math.min(headers.length, row.length); j++) {
            const header = lowercaseHeaders[j];
            const value = row[j] || '';
            if (value.trim() === ''){
                continue;
            }
            userData[header] = value;
        }
        validateRequiredFields(userData, type);
        processedData.push(userData);
    }
    return processedData;
}

function validateRequiredFields(userData, type) {
    let requiredFields = ['name', 'email'];
    if (type === 'student') {
        requiredFields.push('class');
    } else if (type === 'instructor') {
        requiredFields.push('department', 'title');
    } else if (type === 'staff') {
        requiredFields.push('department', 'position');
    }
    
    for (const field of requiredFields) {
        if (!userData[field] || userData[field].trim() === '') {
            throw new Error(`Row missing required field: ${field}`);
        }
    }
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(userData.email)) {
        throw new Error(`Invalid email format: ${userData.email}`);
    }
}

function displayResults(resultsArea, data) {
    if (!data.success) {
        displayError(resultsArea, data.message);
        return;
    }
    let html = `<div class="success-message">${data.message}</div>`;
    if (data.users && data.users.length > 0) {
        html += '<table>';
        html += '<thead><tr>';
        const headers = Object.keys(data.users[0]);
        headers.forEach(header => {
            html += `<th>${header}</th>`;
        });
        
        html += '</tr></thead><tbody>';
        data.users.forEach(user => {
            html += '<tr>';
            headers.forEach(header => {
                html += `<td>${user[header] || ''}</td>`;
            });
            html += '</tr>';
        });
        
        html += '</tbody></table>';
    }
    
    resultsArea.innerHTML = html;
}

function displayError(resultsArea, message) {
    resultsArea.innerHTML = `<div class="error-message">${message}</div>`;
}

function displayMessage(resultsArea, message, className) {
    resultsArea.innerHTML = `<div class="${className}">${message}</div>`;
}
function displayResults(resultsArea, data) {
    if (!data.success) {
        displayError(resultsArea, data.message);
        return;
    }
    const type = getTypeFromResultsArea(resultsArea);
    let html = `<div class="success-message">${data.message}</div>`;
    if (data.users && data.users.length > 0) {
        data.users.forEach(user => {
            if (!user.type) {
                user.type = type;
            }
        });
        html += '<table>';
        html += '<thead><tr>';
        const headers = Object.keys(data.users[0]);
        headers.forEach(header => {
            html += `<th>${header}</th>`;
        });
        
        html += '</tr></thead><tbody>';
        data.users.forEach(user => {
            html += '<tr>';
            headers.forEach(header => {
                html += `<td>${user[header] || ''}</td>`;
            });
            html += '</tr>';
        });
        html += '</tbody></table>';
        html += `
            <div class="action-buttons" data-type="${type}">
                <button type="button" class="btn btn-secondary cancel-btn">Cancel</button>
                <button type="button" class="btn btn-primary save-btn">Save ${type.charAt(0).toUpperCase() + type.slice(1)}s</button>
            </div>
        `;
    }
    resultsArea.innerHTML = html;
    const cancelBtn = resultsArea.querySelector('.cancel-btn');
    if (cancelBtn) {
        cancelBtn.addEventListener('click', () => {
            resultsArea.innerHTML = '';
        });
    }
    
    const saveBtn = resultsArea.querySelector('.save-btn');
    if (saveBtn) {
        saveBtn.addEventListener('click', () => {
            displayMessage(resultsArea, `Saving ${type} data...`, 'info-message');
            const requestData = {
                users: data.users,
                type: type
            };
            fetch('save.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(requestData)
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    displayMessage(resultsArea, result.message || `${type.charAt(0).toUpperCase() + type.slice(1)}s saved successfully!`, 'success-message');
                } else {
                    displayError(resultsArea, result.message || 'Error saving data');
                }
            })
            .catch(error => {
                displayError(resultsArea, 'Network error: ' + error.message);
            });
        });
    }
}

function getTypeFromResultsArea(resultsArea) {
    const section = resultsArea.closest('.user-section');
    if (section) {
        return section.id.split('-')[0];
    }
    return '';
}