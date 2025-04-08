<?php
function isActive($page) {
    return basename($_SERVER['PHP_SELF']) === $page ? 'active' : '';
}
function generateCards($courses) {
    echo '<div class="course-grid">';
    foreach ($courses as $id => $course) {
        echo '<a href="details.php?id='.$id.'" class="course-card">
            <div class="course-image"></div>
            <div class="course-details">
                <h3 class="course-title">'.$course['title'].'</h3>
                <p class="status">Status: '.($course['completed'] ? 'Completed' : 'In-progress').'</p>
                <p class="institution">'.$course['institution'].'</p>
                <div class="menu-dots">⋮</div>
            </div>
        </a>';
    }
    echo '</div>';
}

function generateStudentTable($courseId) {
    $participants = json_decode(file_get_contents('../module/participants.json'), true);
    $students = $participants[$courseId] ?? null;
    if (!$students) {
        return "<p>No participants found for this course.</p>";
    }
    $html = "<table class='student-table'>";
    $html .= "<thead>
            <tr>
                <th>Name</th>
                <th>Role</th>
            </tr>
        </thead>
        <tbody>";
    foreach ($students as $student) {
        $name = htmlspecialchars($student['name'] ?? 'Unknown');
        $role = htmlspecialchars($student['role'] ?? 'Student');
        $html .= "
            <tr>
                <td>$name</td>
                <td>$role</td>
            </tr>
        ";
    }
    $html .= "</tbody></table>";
    return $html;
}


function getStudentByCourseID($courseId) {
    $participants = json_decode(file_get_contents('../module/participants.json'), true);
    return $participants[$courseId] ?? null;
}
function generateGradesTable($students) {
    $grades = json_decode(file_get_contents('../module/grades.json'), true);
    if (!$students) {
        return "<p>No participants found for this course.</p>";
    }

    $html = "<table class='grades-table'>";
    $html .= "
        <thead>
            <tr>
                <th>Name</th>
                <th>Section</th>
                <th>Year</th>
                <th>Grade</th>
                <th>Feedback</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
    ";

    foreach ($students as $student) {
        $studentId = htmlspecialchars($student['student_id'] ?? 'Unknown');
        $name = htmlspecialchars($student['name'] ?? 'Unknown');
        $section = htmlspecialchars($student['section'] ?? 'Unknown');
        $year = htmlspecialchars($student['year'] ?? 'Unknown');
        $grade = htmlspecialchars($grades[$studentId]['grade'] ?? 'N/A');
        $feedback = htmlspecialchars($grades[$studentId]['feedback'] ?? 'No feedback available.');
        
        $html .= "
            <tr>
                <td>$name</td>
                <td>$section</td>
                <td>$year</td>
                <td>$grade</td>
                <td>$feedback</td>
                <td align='center'><button class='edit-btn' data-id='$studentId' onclick='openModal(event)'>Edit</button></td>
            </tr>
        ";
    }

    $html .= "</tbody></table>";

    return $html;
}

function unenroll($courseId, $studentId) {
   
}
function enrollStudent($courseId, $studentId){

}
function updateFeedback($courseId, $studentId, $feedback) {
}
function updateGrade($courseId, $studentId, $grade) {
}
function updateStudentGradeAndFeedback($courseId, $studentId, $grade, $feedback) {
    
}