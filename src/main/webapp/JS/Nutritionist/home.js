
// Toggle navigation
document.querySelector('.toggle').addEventListener('click', function() {
  document.querySelector('.navigation').classList.toggle('active');
  document.querySelector('.main').classList.toggle('active');
  this.classList.add('ripple');
  
  setTimeout(() => {
    this.classList.remove('ripple');
  }, 600);
});
// 

//document.addEventListener('DOMContentLoaded', function () {
//    // ===== STATUS CHART =====
//    const statusCanvas = document.getElementById('statusChart');
//    const publicCount = parseInt(statusCanvas.dataset.public) || 0;
//    const draftCount = parseInt(statusCanvas.dataset.draft) || 0;
//    const privateCount = parseInt(statusCanvas.dataset.private) || 0;
//
//    const statusData = {
//        labels: ['Public', 'Draft', 'Private'],
//        datasets: [{
//            data: [publicCount, draftCount, privateCount],
//            backgroundColor: [
//                'rgba(75, 192, 192, 0.8)',
//                'rgba(255, 205, 86, 0.8)',
//                'rgba(255, 99, 132, 0.8)'
//            ],
//            hoverOffset: 4
//        }]
//    };
//
//    new Chart(statusCanvas.getContext('2d'), {
//        type: 'pie',
//        data: statusData,
//        options: {
//            responsive: true,
//            plugins: {
//                legend: { display: false },
//                tooltip: {
//                    callbacks: {
//                        label: function (context) {
//                            const label = context.label || '';
//                            const value = context.parsed || 0;
//                            return label + ': ' + value;
//                        }
//                    }
//                }
//            }
//        }
//    });

    // ===== BMI CHART =====
//    const bmiCanvas = document.getElementById('bmiChart');
//    const labelData = JSON.parse(bmiCanvas.dataset.labels || "[]");
//    const countData = JSON.parse(bmiCanvas.dataset.counts || "[]");
//
//    const colorList = [
//        'rgba(54, 162, 235, 0.8)',
//        'rgba(255, 99, 132, 0.8)',
//        'rgba(255, 205, 86, 0.8)',
//        'rgba(75, 192, 192, 0.8)',
//        'rgba(153, 102, 255, 0.8)',
//        'rgba(255, 159, 64, 0.8)'
//    ];
//    const backgroundColors = labelData.map((_, idx) => colorList[idx % colorList.length]);
//
//    const bmiData = {
//        labels: labelData,
//        datasets: [{
//            data: countData,
//            backgroundColor: backgroundColors,
//            hoverOffset: 4
//        }]
//    };
//
//    new Chart(bmiCanvas.getContext('2d'), {
//        type: 'pie',
//        data: bmiData,
//        options: {
//            responsive: true,
//            plugins: {
//                legend: { display: false },
//                tooltip: {
//                    callbacks: {
//                        label: function (context) {
//                            const label = context.label || '';
//                            const value = context.parsed || 0;
//                            return label + ': ' + value;
//                        }
//                    }
//                }
//            }
//        }
//    });
//});


document.addEventListener('DOMContentLoaded', function () {
    const pieCanvas = document.getElementById('pieChart');
    const labels = JSON.parse(pieCanvas.dataset.labels || "[]");
    const counts = JSON.parse(pieCanvas.dataset.counts || "[]");

    const backgroundColors = [
        'rgba(255, 205, 86, 0.8)',   // Pending - Yellow
        'rgba(75, 192, 192, 0.8)',   // Approved - Green
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
                legend: { display: false  },
                tooltip: {
                    callbacks: {
                        label: (context) => `${context.label}: ${context.parsed}`
                    }
                }
            }
        }
    });
});


document.addEventListener('DOMContentLoaded', function () {
    const barCanvas = document.getElementById('barChart');
    const labels = JSON.parse(barCanvas.dataset.labels || "[]");
    const counts = JSON.parse(barCanvas.dataset.counts || "[]");

    new Chart(barCanvas, {
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
                    title: {
                        display: true,
                        text: 'Number of Blogs'
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: 'Month'
                    }
                }
            },
            plugins: {
                legend: { display: false }
            }
        }
    });
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

