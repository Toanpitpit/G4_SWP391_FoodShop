document.addEventListener('DOMContentLoaded', () => {
    // =================== NAVIGATION ===================
    const toggleBtn = document.querySelector('.toggle');
    if (toggleBtn) {
        toggleBtn.addEventListener('click', toggleNavigation);
    }

    const currentPath = window.location.pathname;
    const menuLinks = document.querySelectorAll('.navigation ul li a');
    menuLinks.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            link.parentElement.classList.add('active');
        }
    });

    const navigation = document.querySelector('.navigation');
    document.addEventListener('click', function (event) {
        if (window.innerWidth <= 768) {
            if (!navigation.contains(event.target) && navigation.classList.contains('mobile-open')) {
                navigation.classList.remove('mobile-open');
            }
        }
    });

    window.addEventListener('resize', function () {
        if (window.innerWidth > 768) {
            navigation.classList.remove('mobile-open');
        }
    });

    // =================== SMOOTH SCROLL ===================
    document.querySelectorAll('a[href^="#"]').forEach(link => {
        link.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({behavior: 'smooth', block: 'start'});
            }
        });
    });

    // =================== PIE CHART ===================
    const pieCanvas = document.getElementById("pieChart");

// Lấy dữ liệu từ HTML data attributes
    const labels = JSON.parse(pieCanvas.dataset.labels || '[]');
    const counts = JSON.parse(pieCanvas.dataset.counts || '[]');

// Màu như cũ
    const backgroundColors = [
        'rgba(255, 205, 86, 0.8)',
        'rgba(75, 192, 192, 0.8)',
        'rgba(255, 99, 132, 0.8)',
        'rgba(153, 102, 255, 0.8)'
    ];

// Tính tổng
    const total = counts.reduce((a, b) => a + b, 0);

// Đăng ký plugin
    Chart.register(ChartDataLabels);

// Vẽ biểu đồ
    new Chart(pieCanvas, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                    data: counts,
                    backgroundColor: backgroundColors,
                    hoverOffset: 6
                }]
        },
        options: {
            responsive: true,
            plugins: {
                datalabels: {
                    color: 'black',
                    font: {
                        weight: 'bold',
                        size: 18
                    },
                    formatter: (value) => {
                        const percent = (value / total) * 100;
                        return `${percent.toFixed(1)}%`;
                    },
                    padding: 0, // thêm khoảng cách bên trong box
                    offset: 5,
                    anchor: 'end', // đẩy label ra ngoài
                    align: 'end',

                    clamp: true,
                    borderRadius: 4,
                    backgroundColor: '#ffffffcc',
                    borderColor: '#ccc',
                    borderWidth: 1,

                },
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        label: (context) => {
                            const value = context.parsed;
                            const percent = ((value / total) * 100).toFixed(1);
                            return `${context.label}: ${percent}%`;
                        }
                    }
                }
            }
        },
        plugins: [ChartDataLabels]
    });



    // =================== BAR CHART (Blogs Per Month) ===================
    const barCanvas = document.getElementById('barChart');
    const yearDropdown = document.getElementById('yearDropdown');
    let blogChart;

    if (barCanvas) {
        const labels = JSON.parse(barCanvas.dataset.labels || '[]');
        const counts = JSON.parse(barCanvas.dataset.counts || '[]');

        blogChart = new Chart(barCanvas, {
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
                plugins: {
                    legend: {display: false}
                }
            }
        });

        if (yearDropdown) {
            yearDropdown.addEventListener('change', async () => {
                const year = yearDropdown.value;
                try {
                    const response = await fetch(`/dashboadnutri?year=${year}&json=true`);
                    if (!response.ok)
                        throw new Error('Failed to fetch chart data');
                    const data = await response.json();

                    // Update chart data
                    blogChart.data.labels = data.labels;
                    blogChart.data.datasets[0].data = data.counts;
                    blogChart.update();
                } catch (error) {
                    console.error('Error updating blog chart:', error);
                }
            });
        }
    }

    // =================== LINE CHART ===================
    const lineCanvas = document.getElementById('lineChart');
    if (lineCanvas) {
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
    }
});


//document.addEventListener('click', function (event) {
//    const notificationDropdown = document.getElementById('notificationDropdown');
//    const userDropdown = document.getElementById('userDropdown');
//
//    if (!event.target.closest('.user-menu')) {
//        notificationDropdown.classList.remove('show');
//        userDropdown.classList.remove('show');
//    }
//});

function toggleNotifications() {
    const dropdown = document.getElementById('notificationDropdown');
    const userDropdown = document.getElementById('userDropdown');

    userDropdown.classList.remove('show');
    dropdown.classList.toggle('show');
}

function toggleUserMenu() {
    const dropdown = document.getElementById('userDropdown');
    const notificationDropdown = document.getElementById('notificationDropdown');

    notificationDropdown.classList.remove('show');
    dropdown.classList.toggle('show');
}

function toggleTheme() {
    // Theme toggle functionality
    console.log('Toggle theme clicked');
    // Bạn có thể thêm logic chuyển đổi theme ở đây
}

function markAllAsRead() {
    fetch('/your-servlet-url/mark-all-read', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            action: 'markAllAsRead'
        })
    })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Xóa class unread từ tất cả notification items
                    document.querySelectorAll('.notification-item.unread').forEach(item => {
                        item.classList.remove('unread');
                    });

                    // Cập nhật badge số
                    const badge = document.querySelector('.notification-badge');
                    badge.textContent = '0';
                    badge.style.display = 'none';

                    console.log('Đã đánh dấu tất cả thông báo là đã đọc');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
}

function logout() {
    if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
        fetch('/logout', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            }
        })
                .then(response => {
                    if (response.ok) {
                        window.location.href = '/login';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
    }
}

// Smooth scroll behavior when clicking on navigation
document.querySelectorAll('.nav-item').forEach(item => {
    item.addEventListener('click', function (e) {
        e.preventDefault();

        // Remove active class from all items
        document.querySelectorAll('.nav-item').forEach(nav => nav.classList.remove('active'));

        // Add active class to clicked item
        this.classList.add('active');
    });
});

// Animation for notification badge
function animateNotificationBadge() {
    const badge = document.querySelector('.notification-badge');
    badge.style.animation = 'pulse 1s infinite';
}

// CSS animation for badge
const style = document.createElement('style');
style.textContent = `
            @keyframes pulse {
                0% { transform: scale(1); }
                50% { transform: scale(1.1); }
                100% { transform: scale(1); }
            }
        `;
document.head.appendChild(style);
