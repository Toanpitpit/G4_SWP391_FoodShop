document.addEventListener('DOMContentLoaded', () => {
    console.log("Page loaded, checking data availability...");

    // =================== PIE CHART ===================
    const pieCanvas = document.getElementById("pieChart");
    if (pieCanvas) {
        try {
            console.log("Found pieChart canvas");

            const rawLabels = pieCanvas.dataset.labels;
            const rawCounts = pieCanvas.dataset.counts;
            console.log("Raw pie data:", rawLabels, rawCounts);

            const labels = JSON.parse(rawLabels || '[]');
            const counts = JSON.parse(rawCounts || '[]');
            console.log("Parsed pie labels:", labels);
            console.log("Parsed pie counts:", counts);

            const total = counts.reduce((a, b) => a + b, 0);
            Chart.register(ChartDataLabels);
            new Chart(pieCanvas, {
                type: 'pie',
                data: {
                    labels: labels,
                    datasets: [{
                        data: counts,
                        backgroundColor: [
                            'rgba(255, 205, 86, 0.8)',
                            'rgba(75, 192, 192, 0.8)',
                            'rgba(255, 99, 132, 0.8)',
                            'rgba(153, 102, 255, 0.8)'
                        ],
                        hoverOffset: 6
                    }]
                },
                options: {
                    responsive: false,
                    plugins: {
                        datalabels: {
                            color: 'black',
                            font: { weight: 'bold', size: 18 },
                            formatter: (value) => `${((value / total) * 100).toFixed(1)}%`,
                            padding: 1,
                            offset: 10,
                            anchor: 'center',
                            align: 'end',
                            clamp: true,
                            borderRadius: 4,
                            backgroundColor: '#ffffffcc',
                            borderColor: '#ccc',
                            borderWidth: 1,
                        },
                        legend: { display: false },
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
            console.log("Pie chart rendered successfully");
        } catch (e) {
            console.error("Pie chart error:", e);
        }
    } else {
        console.warn("pieChart canvas not found");
    }

    // =================== BAR CHART ===================
    const contextPath = window.contextPath || '';
    const barCanvas = document.getElementById("barChart");

    if (barCanvas) {
        try {
            console.log("✅ Found barChart canvas");

            const rawLabels = barCanvas.dataset.labels;
            const rawCounts = barCanvas.dataset.counts;
            console.log("📊 Raw bar data:", rawLabels, rawCounts);

            const labels = JSON.parse(rawLabels || '[]');
            const counts = JSON.parse(rawCounts || '[]');
            console.log("✅ Parsed bar labels:", labels);
            console.log("✅ Parsed bar counts:", counts);

            const ctx = barCanvas.getContext('2d');
            const blogChart = new Chart(ctx, {
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
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 1,
                                callback: v => Number.isInteger(v) ? v : null
                            },
                            title: { display: true, text: 'Number of Blogs' }
                        },
                        x: {
                            title: { display: true, text: 'Month' }
                        }
                    },
                    plugins: { legend: { display: false } }
                }
            });

            console.log("✅ Bar chart rendered successfully");

            // Bắt sự kiện thay đổi dropdown năm
            const yearDropdown = document.getElementById('yearDropdown');
            if (yearDropdown) {
                yearDropdown.addEventListener('change', async () => {
                    const year = yearDropdown.value;
                    console.log(`🔄 Year changed to: ${year}`);
                    try {
                        const response = await fetch(`${contextPath}/nutricontrol?action=dashboard&year=${year}&json=true`);
                        if (!response.ok) throw new Error('Network response was not ok');

                        const data = await response.json();
                        console.log("📥 New data from server:", data);

                        blogChart.data.labels = data.labels;
                        blogChart.data.datasets[0].data = data.counts;
                        blogChart.update();

                        console.log("✅ Bar chart updated with new year data");
                    } catch (error) {
                        console.error('❌ Error fetching chart data:', error);
                    }
                });
            } else {
                console.warn("⚠️ yearDropdown not found");
            }
        } catch (e) {
            console.error("❌ Bar chart error:", e);
        }
    } else {
        console.warn("⚠️ barChart canvas not found");
    }

    // =================== LINE CHART ===================
    const lineCanvas = document.getElementById("lineChart");
    if (lineCanvas) {
        try {
            console.log("Found lineChart canvas");

            const rawLabels = lineCanvas.dataset.labels;
            const rawCounts = lineCanvas.dataset.counts;
            console.log("Raw line data:", rawLabels, rawCounts);

            const labels = JSON.parse(rawLabels || '[]');
            const counts = JSON.parse(rawCounts || '[]');
            console.log("Parsed line labels:", labels);
            console.log("Parsed line counts:", counts);

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
                                label: (context) => `${context.label}: ${context.parsed.y} drafts`
                            }
                        }
                    }
                }
            });
            console.log("Line chart rendered successfully");
        } catch (e) {
            console.error("Line chart error:", e);
        }
    } else {
        console.warn("lineChart canvas not found");
    }
});


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

    // Smooth scroll behavior and active class toggling
    document.querySelectorAll('.nav-item').forEach(item => {
        item.addEventListener('click', function (e) {
            e.preventDefault();

            document.querySelectorAll('.nav-item').forEach(nav => nav.classList.remove('active'));
            this.classList.add('active');
        });
    });
});

// =================== OTHER FUNCTIONS OUTSIDE DOMContentLoaded ===================

function toggleNotifications() {
    const dropdown = document.getElementById('notificationDropdown');
    const userDropdown = document.getElementById('userDropdown');

    userDropdown?.classList.remove('show');
    dropdown?.classList.toggle('show');
}

function toggleUserMenu() {
    const dropdown = document.getElementById('userDropdown');
    const notificationDropdown = document.getElementById('notificationDropdown');

    notificationDropdown?.classList.remove('show');
    dropdown?.classList.toggle('show');
}

function toggleTheme() {
    console.log('Toggle theme clicked');
    // Add your logic here
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
            document.querySelectorAll('.notification-item.unread').forEach(item => {
                item.classList.remove('unread');
            });

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

//// Animation for notification badge
//function animateNotificationBadge() {
//    const badge = document.querySelector('.notification-badge');
//    badge.style.animation = 'pulse 1s infinite';
//}
//
//// CSS animation for badge
//const style = document.createElement('style');
//style.textContent = `
//            @keyframes pulse {
//                0% { transform: scale(1); }
//                50% { transform: scale(1.1); }
//                100% { transform: scale(1); }
//            }
//        `;
//document.head.appendChild(style);
//)};

