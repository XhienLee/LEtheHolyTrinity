<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Data Import</title>
    <link rel="stylesheet" href="addUser.css"> 
</head>
<body>
    <div class="container">
        <h1>User Management</h1>
        <div class="user-type-selector">
            <button class="type-btn active" data-type="student">Add Student</button>
            <button class="type-btn" data-type="instructor">Add Instructor</button>
            <button class="type-btn" data-type="staff">Add Staff</button>
        </div>
        <div class="user-section active" id="student-section">
            <div class="import-section">
                <div class="import-header">
                    <h2 class="import-title">Student Data</h2>
                    <div class="import-label">Import Data</div>
                </div>
                
                <div class="drop-area" id="student-drop-area">
                <div class="download-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                        <polyline points="7 10 12.0 15 17.0 10"></polyline>
                        <line x1="12.0" y1="15" x2="12.0" y2="3"></line>
                    </svg>
                </div>
                <p class="drop-text">Drag & drop your CSV file here or click to browse</p>
                <div class="file-info" style="display: none;">
                    <p>Selected file: <span class="filename">No file selected</span></p>
                </div>
                <input type="file" class="file-input" accept=".csv">
            </div>

                
                <div class="buttons">
                    <button type="button" class="btn btn-primary import-btn">Import</button>
                    <button type="button" class="btn btn-secondary manual-btn">Manual</button>
                </div>
                
                <div class="results-area" id="student-results-area">
                </div>
            </div>
        </div>
        
        <div class="user-section" id="instructor-section">
            <div class="import-section">
                <div class="import-header">
                    <h2 class="import-title">Instructor Data</h2>
                    <div class="import-label">Import Data</div>
                </div>
                
                <div class="drop-area" id="instructor-drop-area">
                    <div class="download-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                            <polyline points="7 10 12.0 15 17.0 10"></polyline>
                            <line x1="12.0" y1="15" x2="12.0" y2="3"></line>
                        </svg>
                    </div>
                    <p>Drag & drop your CSV file here or click to browse</p>
                    <div class="file-info" style="display: none;">
                        <p>Selected file: <span class="filename">No file selected</span></p>
                    </div>
                    <input type="file" class="file-input" accept=".csv">
                </div>
                
                <div class="buttons">
                    <button type="button" class="btn btn-primary import-btn">Import</button>
                    <button type="button" class="btn btn-secondary manual-btn">Manual</button>
                </div>
                
                <div class="results-area" id="instructor-results-area">
                </div>
            </div>
        </div>
        
        <div class="user-section" id="staff-section">
            <div class="import-section">
                <div class="import-header">
                    <h2 class="import-title">Staff Data</h2>
                    <div class="import-label">Import Data</div>
                </div>
                
                <div class="drop-area" id="staff-drop-area">
                    <div class="download-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                            <polyline points="7 10 12.0 15 17.0 10"></polyline>
                            <line x1="12.0" y1="15" x2="12.0" y2="3"></line>
                        </svg>
                    </div>
                    <p>Drag & drop your CSV file here or click to browse</p>
                    <div class="file-info" style="display: none;">
                        <p>Selected file: <span class="filename">No file selected</span></p>
                    </div>
                    <input type="file" class="file-input" accept=".csv">
                </div>
                
                <div class="buttons">
                    <button type="button" class="btn btn-primary import-btn">Import</button>
                    <button type="button" class="btn btn-secondary manual-btn">Manual</button>
                </div>
                
                <div class="results-area" id="staff-results-area">

                </div>
            </div>
        </div>
    </div>
    <script src="addUser.js"></script>
</body>
</html>