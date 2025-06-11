function toggleNavigation() {
    const navigation = document.querySelector('.navigation');
    const toggle = document.querySelector('.toggle');
    
    // Toggle collapsed class
    navigation.classList.toggle('collapsed');
    
    // Add ripple effect to toggle button
    toggle.classList.add('ripple');
    setTimeout(() => {
        toggle.classList.remove('ripple');
    }, 600);
}

// Toggle Submenu Function
function toggleSubmenu(element) {
    const parentLi = element.parentElement;
    const submenu = parentLi.querySelector('ul');
    
    // Close other open submenus
//    const otherSubmenus = document.querySelectorAll('.navigation ul li.has-submenu.active');
//    otherSubmenus.forEach(item => {
//        if (item !== parentLi) {
//            item.classList.remove('active');
//        }
//    });
    
    // Toggle current submenu
    parentLi.classList.toggle('active');
}

// Initialize Navigation
document.addEventListener('DOMContentLoaded', function() {
    // Add event listener to toggle button
    const toggleBtn = document.querySelector('.toggle');
    if (toggleBtn) {
        toggleBtn.addEventListener('click', toggleNavigation);
    }
    
    // Set active menu item based on current page
    const currentPath = window.location.pathname;
    const menuLinks = document.querySelectorAll('.navigation ul li a');
    
    menuLinks.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            link.parentElement.classList.add('active');
        }
    });
    
    // Handle mobile menu
    const navigation = document.querySelector('.navigation');
    const main = document.querySelector('.main');
    
    // Close mobile menu when clicking outside
    document.addEventListener('click', function(event) {
        if (window.innerWidth <= 768) {
            if (!navigation.contains(event.target) && navigation.classList.contains('mobile-open')) {
                navigation.classList.remove('mobile-open');
            }
        }
    });
    
    // Handle window resize
    window.addEventListener('resize', function() {
        if (window.innerWidth > 768) {
            navigation.classList.remove('mobile-open');
        }
    });
});

// Add smooth scrolling for better UX
document.addEventListener('DOMContentLoaded', function() {
    // Smooth scroll for anchor links
    const links = document.querySelectorAll('a[href^="#"]');
    links.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
});

document.addEventListener('DOMContentLoaded', function () {
    const pieCanvas = document.getElementById('pieChart');
    const labels = JSON.parse(pieCanvas.dataset.labels || "[]");
    const counts = JSON.parse(pieCanvas.dataset.counts || "[]");

    const backgroundColors = [
        'rgba(255, 205, 86, 0.8)',
        'rgba(75, 192, 192, 0.8)',
        'rgba(255, 99, 132, 0.8)',
        'rgba(153, 102, 255, 0.8)'
    ];

    new Chart(pieCanvas, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                    data: counts,
                    backgroundColor: backgroundColors,
                    hoverOffset: 4
                }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {display: false},
                tooltip: {
                    callbacks: {
                        label: (context) => `${context.label}: ${context.parsed}`
                    }
                }
            }
        }
    });
});

const contextPath = window.contextPath || '';

let blogChart;

document.addEventListener('DOMContentLoaded', () => {
    const barCanvas = document.getElementById('barChart');
    const labels = JSON.parse(barCanvas.dataset.labels || '[]');
    const counts = JSON.parse(barCanvas.dataset.counts || '[]');

    const ctx = barCanvas.getContext('2d');
    blogChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                    label: 'Blogs',
                    data: counts,
                    backgroundColor: 'rgba(54, 162, 235, 0.8)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1,
                        callback: v => Number.isInteger(v) ? v : null
                    },
                    title: {display: true, text: 'Number of Blogs'}
                },
                x: {
                    title: {display: true, text: 'Month'}
                }
            },
            plugins: {legend: {display: false}}
        }
    });

    // Bắt sự kiện onchange của dropdown năm
    const yearDropdown = document.getElementById('yearDropdown');
    if (yearDropdown) {
        yearDropdown.addEventListener('change', async () => {
            const year = yearDropdown.value;
            try {
                const response = await fetch(`${contextPath}/dashboadnutri?year=${year}&json=true`);
                if (!response.ok)
                    throw new Error('Network response was not ok');
                const data = await response.json();

                // Cập nhật dữ liệu chart
                blogChart.data.labels = data.labels;
                blogChart.data.datasets[0].data = data.counts;
                blogChart.update();
            } catch (error) {
                console.error('Error fetching chart data:', error);
            }
        });
    }
});



document.addEventListener('DOMContentLoaded', function () {
    const lineCanvas = document.getElementById('lineChart');
    const labels = JSON.parse(lineCanvas.dataset.labels || "[]");
    const counts = JSON.parse(lineCanvas.dataset.counts || "[]");

    new Chart(lineCanvas, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                    label: 'Food Drafts Created',
                    data: counts,
                    borderColor: 'rgba(54, 162, 235, 0.8)',
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    fill: true,
                    tension: 0.4,
                    pointRadius: 5,
                    pointBackgroundColor: 'rgba(54, 162, 235, 1)',
                    pointBorderWidth: 1
                }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Number of Drafts'
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: 'Week'
                    }
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                },
                tooltip: {
                    callbacks: {
                        label: function (context) {
                            return `${context.label}: ${context.parsed.y} drafts`;
                        }
                    }
                }
            }
        }
    });
});

