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
require_once '../functions/function.php';
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
                    <h1><?php echo htmlspecialchars($courseDetails['title']); ?></h1>
                </div>

                <div class="tabs">
                    <button class="tab-btn active" data-tab="course">Course</button>
                    <button class="tab-btn" data-tab="participants">Participants</button>
                    <button class="tab-btn" data-tab="grade">Grade</button>
                    <button class="tab-btn" data-tab="more">Unenroll</button>
                </div>

                <div class="tab-content active" id="course">
                    <h2>Course Details</h2>
                    <p><strong>Institution:</strong> <?php echo htmlspecialchars($courseDetails['institution']); ?></p>
                    <p><strong>Status:</strong> <?php echo htmlspecialchars($courseDetails['completed'] ? 'Completed' : 'In-progress'); ?></p>
                    <p><strong>Description:</strong> <?php echo htmlspecialchars($courseDetails['description']); ?></p>
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
                <h2>Unenroll</h2>
                <?php
                $studentId = $_SESSION['student_id'] ?? null;
                //if ($studentId) {
                    //echo unenroll($courseId, $studentId);
                    echo "<p>To be implemented</p>";
                //} else {
                //    echo "<p>Error: Student ID not found.</p>";
                //}
                ?>
            </div>
                <div class="collapsible">
                    <button class="collapsible-btn">Data Privacy</button>
                    <div class="collapsible-content">
                        <p>Lesson 1</p>
                        <p>Quiz 1</p>
                    </div>
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
<script src="details.js"></script>  
</body>
</html>