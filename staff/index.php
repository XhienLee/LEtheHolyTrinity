<?php
require_once '../functions/staff_function.php';
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
  <title>Staff Dashboard</title>
  <link rel="stylesheet" href="index.css">
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
      <h1 class="welcome-text">Hi, <?php echo $user; ?>!</h1>
      <h2 class="subtitle">Course overview</h2>
      <hr class="separator">
      <div class="filter-controls">
        <div class="dropdown">
          <button class="dropdown-btn">All</button>
          <div class="dropdown-menu">
            <div class="dropdown-item" data-filter="all">All</div>
            <div class="dropdown-item" data-filter="in-progress">In progress</div>
            <div class="dropdown-item" data-filter="completed">Completed</div>
          </div>
        </div>
        <input type="text" class="search-input" placeholder="Search">
        <button class="sort-btn">Sort by course name</button>
      </div>

      <?php generateCards($courses); ?>
    </main>
  </div>
  <script src="index.js"></script>
</body>
</html>