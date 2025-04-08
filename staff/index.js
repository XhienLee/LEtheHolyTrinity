// For sort by course name [a-z]
document.addEventListener('DOMContentLoaded', () => {
    const courseContainer = document.querySelector('.course-grid');
    const sortBtn = document.querySelector('.sort-btn');

    if (!courseContainer || !sortBtn) {
        console.error('Required elements not found: .course-grid or .sort-btn');
        return;
    }

    const originalOrder = Array.from(courseContainer.children);

    sortBtn.addEventListener('click', () => {
        const courseCards = Array.from(courseContainer.children);
        if (sortBtn.classList.contains('active')) {
            courseContainer.innerHTML = '';
            originalOrder.forEach(card => courseContainer.appendChild(card));
        } else {
            const sortedCards = courseCards.sort((a, b) => {
                const titleA = a.querySelector('.course-title').textContent.toLowerCase();
                const titleB = b.querySelector('.course-title').textContent.toLowerCase();
                return titleA.localeCompare(titleB);
            });

            courseContainer.innerHTML = '';
            sortedCards.forEach(card => courseContainer.appendChild(card));
        }
        sortBtn.classList.toggle('active');
    });
});

// For dropdown filter
document.addEventListener('DOMContentLoaded', () => {
    const dropdown = document.querySelector('.dropdown');
    const dropdownBtn = dropdown.querySelector('.dropdown-btn');
    const dropdownMenu = dropdown.querySelector('.dropdown-menu');
    const dropdownItems = dropdown.querySelectorAll('.dropdown-item');
    const courseContainer = document.querySelector('.course-grid');
    const allCourses = Array.from(courseContainer.children);

    dropdownBtn.addEventListener('click', () => {
        dropdown.classList.toggle('open');
    });

    dropdownItems.forEach(item => {
        item.addEventListener('click', () => {
            const selectedText = item.textContent;
            dropdownBtn.textContent = selectedText;
            dropdown.classList.remove('open');
            const filter = item.getAttribute('data-filter');
            let filteredCourses = [];
            if (filter === 'all') {
                filteredCourses = allCourses; 
            } else if (filter === 'in-progress') {
                filteredCourses = allCourses.filter(course => {
                    const statusText = course.querySelector('.status').textContent.toLowerCase();
                    return statusText.includes('in-progress');
                });
            } else if (filter === 'completed') {
                filteredCourses = allCourses.filter(course => {
                    const statusText = course.querySelector('.status').textContent.toLowerCase();
                    return statusText.includes('completed');
                });
            }
            courseContainer.innerHTML = '';
            filteredCourses.forEach(course => courseContainer.appendChild(course));
        });
    });

    document.addEventListener('click', (e) => {
        if (!dropdown.contains(e.target)) {
            dropdown.classList.remove('open');
        }
    });
});

document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.querySelector('.search-input');
    const courseContainer = document.querySelector('.course-grid');
    const allCourses = Array.from(courseContainer.children);
    searchInput.addEventListener('input', () => {
        const query = searchInput.value.toLowerCase().trim();
        allCourses.forEach(course => {
            const title = course.querySelector('.course-title').textContent.toLowerCase();
            if (title.includes(query)) {
                course.style.display = '';
            } else {
                course.style.display = 'none';
            }
        });
    });
});
