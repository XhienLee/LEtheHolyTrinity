// Open the side overlay
document.querySelector('.circle-btn').addEventListener('click', () => {
    document.getElementById('sideOverlay').classList.add('open');
});

// Close the side overlay
function closeOverlay() {
    document.getElementById('sideOverlay').classList.remove('open');
}

// Collapsible functionality
document.querySelectorAll('.collapsible-btn').forEach(button => {
    button.addEventListener('click', () => {
        button.classList.toggle('active');
        const content = button.nextElementSibling;
        content.style.display = content.style.display === 'block' ? 'none' : 'block';
    });
});
// Tab functionality
document.querySelectorAll('.tab-btn').forEach(button => {
    button.addEventListener('click', () => {
        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
        button.classList.add('active');
        document.getElementById(button.dataset.tab).classList.add('active');
    });
});

// Collapsible functionality
document.querySelectorAll('.collapsible-btn').forEach(button => {
    button.addEventListener('click', () => {
        button.classList.toggle('active');
        const content = button.nextElementSibling;
        content.style.display = content.style.display === 'block' ? 'none' : 'block';
    });
});

// Edit modal functionality
function openModal(event) {
    const studentId = event.target.getAttribute('data-id');
    const modalId = 'editStudentModal';
    const studentDetails = getStudentDetailsById(studentId);
    document.getElementById('studentName').value = studentDetails.name;
    document.getElementById('studentSection').value = studentDetails.section;
    document.getElementById('studentYear').value = studentDetails.year;
    document.getElementById('studentGrade').value = studentDetails.grade;
    document.getElementById('studentFeedback').value = studentDetails.feedback;
    document.getElementById(modalId).style.display = 'flex';
}

function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = 'none';
    }
}

document.addEventListener("DOMContentLoaded", () => {
    closeModal('editStudentModal');
});

function getStudentDetailsById(studentId) {
    var row = document.querySelector(`button[data-id='${studentId}']`).closest('tr');
    var cells = row.getElementsByTagName('td');
    return {
        student_id: studentId,
        name: cells[0].innerText,
        section: cells[1].innerText,
        year: cells[2].innerText,
        grade: cells[3].innerText,
        feedback: cells[4].innerText
    };
}

// Edit Course
const editCourse = document.getElementById('editCourse');
const cancelButton = document.getElementById('cancelButton');
const saveButton = document.getElementById('saveButton');
const editIcon = document.getElementById('editIcon');
const editableTitle = document.getElementById('editTitle');
const editControls = document.getElementById('editControls');
const welcomeMessage = document.getElementById('welcomeMessage');
const editTopicIcon = document.getElementById('editTopicIcon');
let welcomeMessageOrig = welcomeMessage.innerText;
let titleOrig = editableTitle.innerText;
editCourse.addEventListener('click', () => {
    editIcon.style.display = 'inline-block'; // display the pencil icon

    // for the welcome message
    welcomeMessage.contentEditable = true;
    welcomeMessage.style.border = '2px solid #ccc';
    welcomeMessage.focus();
    welcomeMessage.style.display = 'block';
    welcomeMessage.style.height = '100px';
    // for edit topic icon
    editTopicIcon.style.display = 'inline-block';
    
});
editIcon.addEventListener('click', () => {
    editableTitle.style.border = '1px solid #ccc';
    editableTitle.focus();
    editControls.style.display = "block";
    editCourse.style.display = "none";
    editableTitle.style.display = 'block';
    editableTitle.contentEditable = true;
});

cancelButton.addEventListener('click', () => {
    editIcon.style.display = 'none';
    editableTitle.contentEditable = false;
    editableTitle.style.border = 'none';
    editableTitle.innerText = titleOrig;
    editControls.style.display = "none";
    editCourse.style.display = "block";
    // for welcome message to deafult
    welcomeMessage.innerText = welcomeMessageOrig;
    welcomeMessage.contentEditable = false;
    welcomeMessage.style.border = 'none';
    welcomeMessage.style.display = 'block';
    welcomeMessage.style.height = 'auto';
});

saveButton.addEventListener('click', () => {
    editIcon.style.display = 'none';
    editableTitle.contentEditable = false;
    editableTitle.style.border = 'none';
    editableTitle.innerText = editableTitle.innerText;
    editControls.style.display = "none";
    editCourse.style.display = "block";
    // for welcome message new
    welcomeMessage.contentEditable = false;
    welcomeMessage.style.border = 'none';
    welcomeMessage.style.height = 'auto';
    // ajax code to call php so that the changes is saved in the database
});

