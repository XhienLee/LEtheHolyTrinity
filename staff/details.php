<?php
// TANAN DATA IS NAA RA SA .json file
// KAY WALA PA KO NAKA BUHAT UG CORRESPONDING sql para ani
// DISABLE SAD NAKO ANG SESSION CHECK
/*
session_start();
if (!isset($_SESSION['user_type']) || $_SESSION['user_type'] !== 'student') {
    header("Location: ../login/index.php");
    exit();
}
*/
require_once '../functions/staff_function.php';
$courseId = isset($_GET['id']) ? urldecode($_GET['id']) : null;
$courses = json_decode(file_get_contents('../module/course.json'), true);
$courseDetails = $courses[$courseId] ?? null;
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($courseDetails['title'] ?? 'Course Details'); ?></title>
    <link rel="stylesheet" href="index.css">
    <link rel="stylesheet" href="details.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="container">
    <header class="top-nav">
      <div class="profile-circle"></div>
      <nav class="main-menu">
        <a href="index.php" class="<?php echo isActive("home.php") ?>">Home</a>
        <a href="dashboard.php" class="<?php echo isActive("dashboard.php") ?>">Dashboard</a>
        <a href="index.php" class="<?php echo isActive("index.php") ?>">My courses</a>
        <a href="report.php" class="<?php echo isActive("report.php") ?>">Report & Analysis</a>
      </nav>
      <div class="vertical-divider"></div>
      <div class="profile-circle"></div>
    </header>

        <main class="content">
            <?php if ($courseDetails): ?>
                <div class="course-header">
                    <h1 id="editTitle">
                        Data Privacy Lesson - Quiz 1 [2025 - 2026]
                    </h1>
                    <i class="fas fa-pencil-alt" id="editIcon" style="display: none; color: #800000; font-size: 30px;"></i>
                    <div id="editControls">
                        <button id="cancelButton" class="cancelSave-btn">Cancel</button>
                        <button id="saveButton" class="save-btn">Save</button>
                    </div>
                </div>

                <div class="tabs">
                    <button class="tab-btn active" data-tab="course">Course</button>
                    <button class="tab-btn" data-tab="participants">Participants</button>
                    <button class="tab-btn" data-tab="grade">Grade</button>
                    <button class="tab-btn" data-tab="more">Enroll</button>
                    <button id="editCourse">Edit</button>
                </div>

                <div class="tab-content active" id="course">
                    <h2><?php echo htmlspecialchars($courseDetails['title']); ?></h2>
                    <p id="welcomeMessage"><?php echo htmlspecialchars($courseDetails['description']); ?></p>
                </div>

                <div class="tab-content" id="participants">
                    <h2>Participants</h2>
                    <?php echo generateStudentTable($courseId)?>
                </div>
                <div class="tab-content" id="grade">
                    <h2>Grade</h2>
                    <?php echo generateGradesTable(getStudentByCourseID($courseId))?>
                </div>
                <div class="tab-content" id="more">
                    <h2>Enroll</h2>
                    <?php /* enrollStudent($courseId, $studentId); */?>
                </div>
                <div class="collapsible">
                    <button class="collapsible-btn">
                        Data Privacy
                        <i class="fas fa-pencil-alt" id="editTopicIcon" style="display: none; color: white;"></i>
                    </button>
                    <p>Lesson 1</p>
                    <p>Quiz 1</p>
                </div>
            <?php else: ?>
                <p>Course details not found.</p>
            <?php endif; ?>
            <a href="index.php" class="back-btn">Back to Courses</a>
        </main>
    </div>

<div class="circle-menu">
    <button class="circle-btn" id="openOverlay">☰</button>
</div>

<div class="side-overlay" id="sideOverlay">
    <button class="close-btn" onclick="closeOverlay()">×</button>
    <div class="overlay-content">
        <a href="index.php">Home</a>
        <a href="dashboard.php">Dashboard</a>
        <a href="index.php">My Courses</a>
        <a href="report.php">Reports</a>
    </div>
</div>

<div id="editStudentModal" class="modal" style="display: none;">
    <div class="modal-content">
        <span class="close" onclick="closeModal('editStudentModal')">&times;</span>
        <h2>Edit Grades and Feedback</h2>
        <form id="editStudentForm">
            <label for="studentName">Name:</label>
            <input type="text" id="studentName" name="name" readonly>

            <label for="studentYear">Year:</label>
            <input type="text" id="studentYear" name="year" readonly>

            <label for="studentSection">Section:</label>
            <input type="text" id="studentSection" name="section" readonly>

            <label for="studentGrade">Grades:</label>
            <input type="text" id="studentGrade" name="grades">

            <label for="studentFeedback">Feedback:</label>
            <textarea id="studentFeedback" name="feedback" oninput="textAreaAdjust(this)"></textarea>

            <button type="submit">Save Changes</button>
        </form>
    </div>
</div>
<script src="details.js"></script> 
<script>
function textAreaAdjust(element) {
  element.style.height = "auto";
  element.style.height = (element.scrollHeight) + "px"; 

  const maxHeight = 100;
  if (element.scrollHeight > maxHeight) {
    element.style.height = maxHeight + "px";
    element.style.overflowY = "auto"; 
  } else {
    element.style.overflowY = "hidden";
  }
}
</script>
</body>
</html>