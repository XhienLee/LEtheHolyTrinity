<?php
session_start();
require_once '../functions/staff_function.php';
require_once '../functions/module.php';
require_once '../functions/session.php';
requireLogin();

$action = isset($_GET['action']) ? $_GET['action'] : 'create';
$quizId = isset($_GET['id']) ? $_GET['id'] : null;
$moduleId = isset($_GET['module']) ? $_GET['module'] : null;

if (!$moduleId) {
    header('Location: index.php');
    exit();
}

$courseDetails = getCourseById($moduleId);
$title = isset($courseDetails['title']) ? $courseDetails['title'] : 'Course Not Found';

$success_message = '';
$error_message = '';
$quiz_data = [];
if ($_POST) {
    if (isset($_POST['quiz_action'])) {
        switch ($_POST['quiz_action']) {
            case 'create':
                $result = createQuiz($_POST, $moduleId);
                if ($result['status']) {
                    $success_message = $result['message'];
                } else {
                    $error_message = $result['message'];
                }
                break;
            case 'update':
                $result = updateQuiz($_POST, $quizId);
                if ($result['status']) {
                    $success_message = $result['message'];
                    $quiz_data = getQuizById($quizId);
                } else {
                    $error_message = $result['message'];
                }
                break;
                
            case 'delete':
                $result = deleteQuiz($quizId);
                if ($result['status']) {
                    header('Location: details.php?id=' . $moduleId . '&tab=quizzes&message=Quiz deleted successfully');
                    exit();
                } else {
                    $error_message = $result['message'];
                }
                break;
        }
    }
}

if ($action === 'edit' && $quizId) {
    $quiz_data = getQuizById($quizId);
    if (empty($quiz_data)) {
        $error_message = 'Quiz not found.';
        $action = 'create';
    }
}

function createQuiz($data, $moduleId) {
    require '../functions/db_connect.php';
    try {
        $quizId = generateQuizId();
        $stmt = $conn->prepare("INSERT INTO quizzes (quizId, moduleId, title, description, total_questions, passing_score, duration_minutes, status) VALUES (?, ?, ?, ?, ?, ?, ?, 'active')");
        $stmt->bind_param("ssssiis", 
            $quizId, 
            $moduleId, 
            $data['title'], 
            $data['description'], 
            $data['total_questions'], 
            $data['passing_score'], 
            $data['duration_minutes']
        );
        
        if ($stmt->execute()) {
            return ['status' => true, 'message' => 'Quiz created successfully!'];
        } else {
            return ['status' => false, 'message' => 'Database error: ' . $conn->error];
        }
    } catch (Exception $e) {
        return ['status' => false, 'message' => 'Error creating quiz: ' . $e->getMessage()];
    }
}

function updateQuiz($data, $quizId) {
    require '../functions/db_connect.php';
    
    try {
        $stmt = $conn->prepare("UPDATE quizzes SET title = ?, description = ?, total_questions = ?, passing_score = ?, duration_minutes = ? WHERE quizId = ?");
        $stmt->bind_param("ssiiss", 
            $data['title'], 
            $data['description'], 
            $data['total_questions'], 
            $data['passing_score'], 
            $data['duration_minutes'], 
            $quizId
        );
        
        if ($stmt->execute()) {
            if ($stmt->affected_rows > 0) {
                return ['status' => true, 'message' => 'Quiz updated successfully!'];
            } else {
                return ['status' => false, 'message' => 'No changes were made to the quiz.'];
            }
        } else {
            return ['status' => false, 'message' => 'Database error: ' . $conn->error];
        }
    } catch (Exception $e) {
        return ['status' => false, 'message' => 'Error updating quiz: ' . $e->getMessage()];
    }
}

function deleteQuiz($quizId) {
    require '../functions/db_connect.php';
    try {
        $checkStmt = $conn->prepare("SELECT COUNT(*) as count FROM quiz_attempt WHERE quizId = ?");
        $checkStmt->bind_param("s", $quizId);
        $checkStmt->execute();
        $result = $checkStmt->get_result();
        $count = $result->fetch_assoc()['count'];
        
        if ($count > 0) {
            return ['status' => false, 'message' => 'Cannot delete quiz with existing student attempts.'];
        }
        $deleteQuestionsStmt = $conn->prepare("DELETE FROM quiz_questions WHERE quizId = ?");
        $deleteQuestionsStmt->bind_param("s", $quizId);
        $deleteQuestionsStmt->execute();
    
        $stmt = $conn->prepare("DELETE FROM quizzes WHERE quizId = ?");
        $stmt->bind_param("s", $quizId);
        
        if ($stmt->execute()) {
            return ['status' => true, 'message' => 'Quiz deleted successfully!'];
        } else {
            return ['status' => false, 'message' => 'Database error: ' . $conn->error];
        }
    } catch (Exception $e) {
        return ['status' => false, 'message' => 'Error deleting quiz: ' . $e->getMessage()];
    }
}

function getQuizById($quizId) {
    require '../functions/db_connect.php';
    
    $stmt = $conn->prepare("SELECT * FROM quizzes WHERE quizId = ?");
    $stmt->bind_param("s", $quizId);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        return $result->fetch_assoc();
    }
    return [];
}

function generateQuizId() {
    return 'QZ' . time() . rand(100, 999);
}

// Set page title based on action
$page_title = '';
switch ($action) {
    case 'create':
        $page_title = 'Create New Quiz';
        break;
    case 'edit':
        $page_title = 'Edit Quiz';
        break;
    case 'delete':
        $page_title = 'Delete Quiz';
        break;
    default:
        $page_title = 'Manage Quiz';
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($page_title); ?> - <?php echo htmlspecialchars($title); ?></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="quiz.css">
    <link rel="stylesheet" href="details.css">
</head>
<body>
    <div class="container">
        <main class="content">
            <div class="course-header">
                <h1><?php echo htmlspecialchars($page_title); ?></h1>
                <p>Module: <?php echo htmlspecialchars($title); ?></p>
            </div>

            <?php if ($success_message): ?>
                <div class="alert alert-success">
                    <?php echo htmlspecialchars($success_message); ?>
                </div>
            <?php endif; ?>

            <?php if ($error_message): ?>
                <div class="alert alert-error">
                    <?php echo htmlspecialchars($error_message); ?>
                </div>
            <?php endif; ?>

            <?php if ($action === 'delete' && !empty($quiz_data)): ?>
                <div class="delete-confirmation">
                    <h3><i class="fas fa-exclamation-triangle"></i> Confirm Quiz Deletion</h3>
                    <p><strong>Warning:</strong> This action cannot be undone!</p>
                    
                    <div class="quiz-info-box">
                        <h4>Quiz to be deleted:</h4>
                        <div class="info-grid">
                            <div class="info-item">
                                <strong>Title:</strong>
                                <?php echo htmlspecialchars($quiz_data['title']); ?>
                            </div>
                            <div class="info-item">
                                <strong>Questions:</strong>
                                <?php echo htmlspecialchars($quiz_data['total_questions']); ?>
                            </div>
                            <div class="info-item">
                                <strong>Duration:</strong>
                                <?php echo htmlspecialchars($quiz_data['duration_minutes']); ?> minutes
                            </div>
                            <div class="info-item">
                                <strong>Passing Score:</strong>
                                <?php echo htmlspecialchars($quiz_data['passing_score']); ?>%
                            </div>
                        </div>
                    </div>
                    
                    <form method="POST">
                        <input type="hidden" name="quiz_action" value="delete">
                        <div class="quiz-actions">
                            <button type="submit" class="confirm-btn">
                                <i class="fas fa-trash"></i> Yes, Delete Quiz
                            </button>
                            <a href="details.php?id=<?php echo htmlspecialchars($moduleId); ?>&tab=quizzes" class="cancel-btn">
                                <i class="fas fa-arrow-left"></i> Cancel
                            </a>
                        </div>
                    </form>
                </div>

            <?php else: ?>
                <form method="POST" class="quiz-form">
                    <input type="hidden" name="quiz_action" value="<?php echo $action === 'edit' ? 'update' : 'create'; ?>">
                    
                    <div class="form-group">
                        <label for="title"><strong>Quiz Title:</strong></label>
                        <input type="text" id="title" name="title" 
                               value="<?php echo htmlspecialchars($quiz_data['title'] ?? ''); ?>" 
                               class="form-input" required 
                               placeholder="Enter quiz title">
                    </div>
                    
                    <div class="form-group">
                        <label for="description"><strong>Description:</strong></label>
                        <textarea id="description" name="description" rows="4" 
                                  class="form-textarea" 
                                  placeholder="Enter quiz description"><?php echo htmlspecialchars($quiz_data['description'] ?? ''); ?></textarea>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="total_questions"><strong>Total Questions:</strong></label>
                            <input type="number" id="total_questions" name="total_questions" 
                                   value="<?php echo htmlspecialchars($quiz_data['total_questions'] ?? ''); ?>" 
                                   class="form-input" required min="1" max="100"
                                   placeholder="e.g., 10">
                        </div>
                        
                        <div class="form-group">
                            <label for="duration_minutes"><strong>Duration (Minutes):</strong></label>
                            <input type="number" id="duration_minutes" name="duration_minutes" 
                                   value="<?php echo htmlspecialchars($quiz_data['duration_minutes'] ?? ''); ?>" 
                                   class="form-input" required min="1" max="300"
                                   placeholder="e.g., 30">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="passing_score"><strong>Passing Score (%):</strong></label>
                        <input type="number" id="passing_score" name="passing_score" 
                               value="<?php echo htmlspecialchars($quiz_data['passing_score'] ?? ''); ?>" 
                               class="form-input" required min="0" max="100"
                               placeholder="e.g., 70">
                        <small class="file-help">Students need to score at least this percentage to pass</small>
                    </div>
                    
                    <div class="quiz-actions">
                        <button type="submit" class="save-btn">
                            <i class="fas fa-save"></i> 
                            <?php echo $action === 'edit' ? 'Update Quiz' : 'Create Quiz'; ?>
                        </button>
                        <a href="details.php?id=<?php echo htmlspecialchars($moduleId); ?>&tab=quizzes" class="cancel-btn">
                            <i class="fas fa-arrow-left"></i> Back to Module
                        </a>
                    </div>
                </form>
            <?php endif; ?>
        </main>
    </div>

    <script>
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.display = 'none';
            });
        }, 5000);
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('.quiz-form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const totalQuestions = parseInt(document.getElementById('total_questions').value);
                    const duration = parseInt(document.getElementById('duration_minutes').value);
                    const passingScore = parseInt(document.getElementById('passing_score').value);
                    
                    if (totalQuestions < 1 || totalQuestions > 100) {
                        e.preventDefault();
                        alert('Total questions must be between 1 and 100.');
                        return;
                    }
                    
                    if (duration < 1 || duration > 300) {
                        e.preventDefault();
                        alert('Duration must be between 1 and 300 minutes.');
                        return;
                    }
                    
                    if (passingScore < 0 || passingScore > 100) {
                        e.preventDefault();
                        alert('Passing score must be between 0 and 100.');
                        return;
                    }
                });
            }
        });
    </script>
</body>
</html>