
// Toggle navigation
document.querySelector('.toggle').addEventListener('click', function() {
  document.querySelector('.navigation').classList.toggle('active');
  document.querySelector('.main').classList.toggle('active');
  this.classList.add('ripple');
  
  setTimeout(() => {
    this.classList.remove('ripple');
  }, 600);
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
                    ticks: {
                        stepSize: 1,
                        callback: function(value) {
                            if (Number.isInteger(value)) {
                                return value;
                            }
                            return null;
                        }
                    },
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

