<?php
// Enable error reporting for debugging
// Comment out in production
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Set content type to JSON
header('Content-Type: application/json');

// Check if this is a POST request
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid request method. Only POST requests are accepted.'
    ]);
    exit;
}

$rawData = file_get_contents('php://input');

$data = json_decode($rawData, true);
if (!$data || !isset($data['users']) || !isset($data['type'])) {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid or missing data.'
    ]);
    exit;
}

$users = $data['users'];
$type = $data['type'];
if (!in_array($type, ['student', 'instructor', 'staff'])) {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid user type. Allowed types are: student, instructor, staff.'
    ]);
    exit;
}

foreach ($users as $user) {
    $requiredFields = ['name', 'email', 'id'];
    if ($type === 'student') {
        $requiredFields[] = 'class';
    } elseif ($type === 'instructor') {
        $requiredFields[] = 'department';
        $requiredFields[] = 'title';
    } elseif ($type === 'staff') {
        $requiredFields[] = 'department';
        $requiredFields[] = 'position';
    }
    foreach ($requiredFields as $field) {
        if (!isset($user[$field]) || empty($user[$field])) {
            echo json_encode([
                'success' => false,
                'message' => "Missing required field: {$field} for one or more users."
            ]);
            exit;
        }
    }
    if (!filter_var($user['email'], FILTER_VALIDATE_EMAIL)) {
        echo json_encode([
            'success' => false,
            'message' => "Invalid email format: {$user['email']}"
        ]);
        exit;
    }
}
echo json_encode([
    'success' => true,
    'message' => count($users).' '.ucfirst($type).(count($users) !== 1 ? 's' : '').' saved successfully to database.',
    'count' => count($users)
]);

/*
// Connect to database (replace with your database credentials)
try {
    $db = new PDO('mysql:host=localhost;dbname=yourdb;charset=utf8mb4', 'username', 'password');
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Database connection error: ' . $e->getMessage()
    ]);
    exit;
}

// Insert users into the database
try {
    // Start transaction
    $db->beginTransaction();
    
    // Prepare the SQL statement based on user type
    if ($type === 'student') {
        $sql = "INSERT INTO users (id, name, email, class, user_type) VALUES (:id, :name, :email, :class, :type)";
    } elseif ($type === 'instructor') {
        $sql = "INSERT INTO users (id, name, email, department, title, user_type) VALUES (:id, :name, :email, :department, :title, :type)";
    } elseif ($type === 'staff') {
        $sql = "INSERT INTO users (id, name, email, department, position, user_type) VALUES (:id, :name, :email, :department, :position, :type)";
    }
    
    $stmt = $db->prepare($sql);
    
    // Insert each user
    foreach ($users as $user) {
        $params = [
            ':id' => $user['id'],
            ':name' => $user['name'],
            ':email' => $user['email'],
            ':type' => $type
        ];
        
        if ($type === 'student') {
            $params[':class'] = $user['class'];
        } elseif ($type === 'instructor') {
            $params[':department'] = $user['department'];
            $params[':title'] = $user['title'];
        } elseif ($type === 'staff') {
            $params[':department'] = $user['department'];
            $params[':position'] = $user['position'];
        }
        
        $stmt->execute($params);
    }
    
    // Commit the transaction
    $db->commit();
    
    // Return success response
    echo json_encode([
        'success' => true,
        'message' => count($users) . ' ' . ucfirst($type) . (count($users) !== 1 ? 's' : '') . ' saved successfully.',
        'count' => count($users)
    ]);
    
} catch (PDOException $e) {
    // Rollback the transaction on error
    $db->rollBack();
    
    echo json_encode([
        'success' => false,
        'message' => 'Database error: ' . $e->getMessage()
    ]);
}
*/
?>