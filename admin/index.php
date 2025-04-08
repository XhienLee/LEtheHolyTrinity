<?php
//require_once 'actions.php';
require_once '../functions/student_function.php';
/*
session_start();
if (!isset($_SESSION['user_type']) || $_SESSION['user_type'] !== 'student') {
  header("Location: ../login/index.php");
  exit();
}
  */
$user = isset($_SESSION['name']) ? strtok($_SESSION['name'], " ") : "Student";
$courses = json_decode(file_get_contents('../module/course.json'), true);

?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Dashboard</title>
  <link rel="stylesheet" href="index.css">
</head>

<body>
  <div class="container">
    <header class="top-nav">
      <div class="profile-circle"></div>
      <nav class="main-menu">
        <a href="dashboard.php" class="<?php echo isActive("home.php") ?>">Home</a>
        <a href="index.php" class="<?php echo isActive("index.php") ?>">Dashboard</a>
        <a href="report.php" class="<?php echo isActive("report.php") ?>">Report & Analysis</a>
      </nav>
      <div class="vertical-divider"></div>
      <div class="profile-circle"></div>
    </header>

    <main class="content">
      <h1 class="welcome-text" style="color: #A20202; margin-left: 40px;">Welcome, <?php echo $user; ?>!</h1>
      <h2 class="subtitle" style="margin-left: 50px; font-size: 20px;">Management overview</h2>
      <hr class="separator" style="background-color: #A20202; width: 96%; height: 2px;">    
    </main>
    <div id="actions">
        <div id="contentContainer">
            <div class="button-container">
                <button id="addStudent">Add Student</button>
                <button id="ManageStaff">Manage Staff</button>
                <button id="manageStudent" style="height: 60px;">Manage Student & Staff</button>
            </div>
            <div class="box-container">
            </div>
        </div>
    </div>
  </div>
</body>
</html>