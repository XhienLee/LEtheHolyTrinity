<?php
// load_data.php - Script to load data from CSV files

// Set headers for JSON response
header('Content-Type: application/json');

// Get request parameters
$category = isset($_POST['category']) ? $_POST['category'] : '';
$search = isset($_POST['search']) ? $_POST['search'] : '';

// Validate category
if (!in_array($category, ['students', 'instructors', 'staff'])) {
    echo json_encode(['error' => 'Invalid category']);
    exit;
}

// Define file paths
$file_path = "data/{$category}.csv";

// Check if file exists
if (!file_exists($file_path)) {
    // Create sample data if file doesn't exist
    createSampleData($category);
}

// Read the CSV file
$data = [];
if (($handle = fopen($file_path, "r")) !== FALSE) {
    // Get headers from first row
    $headers = fgetcsv($handle, 1000, ",");
    
    // Read data rows
    while (($row = fgetcsv($handle, 1000, ",")) !== FALSE) {
        $record = [];
        foreach ($headers as $index => $header) {
            $record[$header] = $row[$index];
        }
        
        // Apply search filter if provided
        if (empty($search) || containsSearchTerm($record, $search)) {
            $data[] = $record;
        }
    }
    fclose($handle);
}

// Return the data as JSON
echo json_encode($data);
exit;

// Function to check if record contains search term
function containsSearchTerm($record, $search) {
    $search = strtolower($search);
    foreach ($record as $value) {
        if (strpos(strtolower($value), $search) !== false) {
            return true;
        }
    }
    return false;
}

// Function to create sample data files
function createSampleData($category) {
    $file_path = "data/{$category}.csv";
    
    // Create directory if it doesn't exist
    if (!is_dir('data')) {
        mkdir('data', 0755, true);
    }
    
    // Create file with headers and sample data
    $handle = fopen($file_path, "w");
    
    switch ($category) {
        case 'students':
            fputcsv($handle, ['id', 'name', 'email', 'course', 'enrollment_date', 'status']);
            fputcsv($handle, ['1', 'John Doe', 'john.doe@example.com', 'Cybersecurity Basics', '2024-01-15', 'Active']);
            fputcsv($handle, ['2', 'Jane Smith', 'jane.smith@example.com', 'Network Security', '2024-02-20', 'Active']);
            fputcsv($handle, ['3', 'Robert Johnson', 'robert.j@example.com', 'Ethical Hacking', '2023-11-10', 'Completed']);
            fputcsv($handle, ['4', 'Lisa Brown', 'lisa.brown@example.com', 'Data Protection', '2024-03-05', 'Active']);
            fputcsv($handle, ['5', 'Michael Chen', 'michael.c@example.com', 'Cryptography', '2023-09-18', 'On Hold']);
            break;
            
        case 'instructors':
            fputcsv($handle, ['id', 'name', 'email', 'specialty', 'hire_date', 'courses_taught']);
            fputcsv($handle, ['1', 'Dr. Sarah Wilson', 'sarah.wilson@example.com', 'Network Security', '2022-06-10', '3']);
            fputcsv($handle, ['2', 'Prof. James Taylor', 'james.taylor@example.com', 'Ethical Hacking', '2021-04-15', '4']);
            fputcsv($handle, ['3', 'Dr. Alex Martinez', 'alex.m@example.com', 'Cryptography', '2023-01-22', '2']);
            fputcsv($handle, ['4', 'Prof. Emily Zhang', 'emily.z@example.com', 'Data Protection', '2022-08-30', '3']);
            break;
            
        case 'staff':
            fputcsv($handle, ['id', 'name', 'email', 'position', 'department', 'join_date']);
            fputcsv($handle, ['1', 'David Thomas', 'david.t@example.com', 'Administrator', 'IT Support', '2021-03-15']);
            fputcsv($handle, ['2', 'Susan Miller', 'susan.m@example.com', 'Academic Advisor', 'Student Services', '2022-05-20']);
            fputcsv($handle, ['3', 'Kevin Wilson', 'kevin.w@example.com', 'Technical Support', 'IT Support', '2023-02-10']);
            fputcsv($handle, ['4', 'Amanda Johnson', 'amanda.j@example.com', 'Program Coordinator', 'Administration', '2021-11-05']);
            break;
    }
    
    fclose($handle);
}
?>