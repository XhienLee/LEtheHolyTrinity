<?php
session_start();
require_once '../functions/db_connect.php';
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $userid = $_POST['userid'];
    $password = $_POST['password'];
    $stmt = $conn->prepare("SELECT * FROM users WHERE id = ?");
    $stmt->bind_param("s", $userid);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows === 1) {
        $user = $result->fetch_assoc();
        if (password_verify($password, $user['password'])) {
            $_SESSION['name'] = $user['name'];
            $_SESSION['user_type'] = $user['user_type'];
            if ($user['user_type'] === 'admin') {
                header("Location: ../admin/index.php");
            } elseif ($user['user_type'] === 'staff') {
                header("Location: ../staff/index.php");
            } elseif ($user['user_type'] === 'student') {
                header("Location: ../student/index.php");
            }
            exit();
        } else {
            $error = "Invalid username or password.";
        }
    } else {
        $error = "Invalid username or password.";
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    
    <div id="form">
        <div class="logo-circle">
            <span>Logo</span>
        </div>
        <form method="POST" action="">
            <input type="text" name="userid" placeholder="UserId" autocomplete="userid" required>
            <div class="pass-container">
                <input type="password" name="password" placeholder="Password" id="password" autocomplete="current-password" required>
                <i class="fa-solid fa-eye toggle-password" onclick="togglePassword()"></i>
            </div>
            <?= isset($error) ? "<span style=\"color: red;\">{$error}</span>" : '' ?>
            <button type="submit">Login</button>
        </form>
    </div>
     
    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.querySelector('.toggle-password');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        }
    </script>
</body>
</html>
