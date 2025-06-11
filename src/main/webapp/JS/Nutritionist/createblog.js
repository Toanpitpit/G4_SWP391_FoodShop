/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */



function previewImage(event) {
    const input = event.target;
    const preview = document.getElementById("preview");
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function (e) {
            preview.src = e.target.result;
            preview.style.display = "block";
        };
        reader.readAsDataURL(input.files[0]);
    }
}

// Alert Notification System
class AlertNotification {
    constructor() {
        this.container = null;
        this.alerts = [];
        this.init();
    }

    init() {
        // Tạo container nếu chưa có
        if (!document.querySelector('.alert-container')) {
            this.container = document.createElement('div');
            this.container.className = 'alert-container';
            document.body.appendChild(this.container);
        } else {
            this.container = document.querySelector('.alert-container');
        }
    }

    show(message, type = 'danger', duration = 5000) {
        const alert = this.createAlert(message, type, duration);
        this.container.appendChild(alert);
        this.alerts.push(alert);

        // Trigger animation
        setTimeout(() => {
            alert.classList.add('show');
        }, 100);

        // Auto hide
        if (duration > 0) {
            this.startProgressBar(alert, duration);
            setTimeout(() => {
                this.hide(alert);
            }, duration);
        }

        return alert;
    }

    createAlert(message, type, duration) {
        const alert = document.createElement('div');
        alert.className = `custom-alert alert-${type}`;

        const icons = {
            danger: 'fas fa-exclamation-circle',
            success: 'fas fa-check-circle',
            warning: 'fas fa-exclamation-triangle',
            info: 'fas fa-info-circle'
        };

        alert.innerHTML = `
            <div class="alert-content">
                <i class="${icons[type]} alert-icon"></i>
                <div class="alert-message">${message}</div>
                <button class="alert-close" onclick="alertSystem.hide(this.closest('.custom-alert'))">&times;</button>
            </div>
            ${duration > 0 ? '<div class="alert-progress"></div>' : ''}
        `;

        return alert;
    }

    startProgressBar(alert, duration) {
        const progressBar = alert.querySelector('.alert-progress');
        if (progressBar) {
            progressBar.style.width = '100%';
            setTimeout(() => {
                progressBar.style.width = '0%';
                progressBar.style.transition = `width ${duration}ms linear`;
            }, 50);
        }
    }

    hide(alert) {
        if (!alert || !alert.classList.contains('custom-alert'))
            return;

        alert.classList.remove('show');
        alert.classList.add('hide');

        setTimeout(() => {
            if (alert.parentNode) {
                alert.parentNode.removeChild(alert);
            }
            // Remove from alerts array
            const index = this.alerts.indexOf(alert);
            if (index > -1) {
                this.alerts.splice(index, 1);
            }
        }, 500);
    }

    hideAll() {
        this.alerts.forEach(alert => {
            this.hide(alert);
        });
    }

    // Convenience methods
    success(message, duration = 4000) {
        return this.show(message, 'success', duration);
    }

    error(message, duration = 6000) {
        return this.show(message, 'danger', duration);
    }

    warning(message, duration = 5000) {
        return this.show(message, 'warning', duration);
    }

    info(message, duration = 4000) {
        return this.show(message, 'info', duration);
    }
}

// Initialize global alert system
const alertSystem = new AlertNotification();

// Auto-detect existing alerts and convert them
document.addEventListener('DOMContentLoaded', function () {
    // Tìm các alert cũ và chuyển đổi
    const existingAlerts = document.querySelectorAll('.alert');
    existingAlerts.forEach(alert => {
        const message = alert.textContent.trim();
        let type = 'info';

        if (alert.classList.contains('alert-danger'))
            type = 'danger';
        else if (alert.classList.contains('alert-success'))
            type = 'success';
        else if (alert.classList.contains('alert-warning'))
            type = 'warning';

        // Ẩn alert cũ
        alert.style.display = 'none';

        // Hiển thị alert mới
        setTimeout(() => {
            alertSystem.show(message, type);
        }, 300);
    });
});


function showAlert(message, type = 'danger', duration = 5000) {
    return alertSystem.show(message, type, duration);
}

function showSuccess(message, duration = 4000) {
    return alertSystem.success(message, duration);
}

function showError(message, duration = 6000) {
    return alertSystem.error(message, duration);
}

function showWarning(message, duration = 5000) {
    return alertSystem.warning(message, duration);
}

function showInfo(message, duration = 4000) {
    return alertSystem.info(message, duration);
}

function newPreviewImage(event) {
    const file = event.target.files[0];
    const preview = document.getElementById('new-preview');
    const placeholder = document.getElementById('newUploadPlaceholder');
    const container = document.querySelector('.new-image-preview-container');

    if (file) {
        // Kiểm tra kích thước file (giới hạn 5MB = 5 * 1024 * 1024)
        if (file.size > 5 * 1024 * 1024) {
            showAlert("Ảnh vượt quá dung lượng cho phép (5MB). Vui lòng chọn ảnh nhỏ hơn.", type = 'danger', duration = 5000);
            event.target.value = ''; // Reset input file
            preview.style.display = 'none';
            placeholder.style.display = 'block';
            container.classList.remove('has-image');
            return;
        }

        const reader = new FileReader();
        reader.onload = function (e) {
            preview.src = e.target.result;
            preview.style.display = 'block';
            placeholder.style.display = 'none';
            container.classList.add('has-image');
        };
        reader.readAsDataURL(file);
    }
}

document.getElementById('newBlogForm').addEventListener('submit', function (e) {
    const titleInput = document.getElementById('title');
    const titleText = titleInput.value.trim();
    const wordCount = titleText.split(/\s+/).length;

    const button = document.querySelector('.new-btn-submit');
    const form = document.querySelector('.new-blog-form');

    if (wordCount < 5 || wordCount > 30) {
        e.preventDefault(); // Chặn submit

        // 👉 Hiển thị cảnh báo
        showWarning('Tiêu đề phải chứa từ 5 đến 30 từ để tối ưu SEO.');

        // 👉 Reset lại nút và form
        button.innerHTML = '<i class="fas fa-check"></i> Xuất bản bài viết';
        form.classList.remove('loading'); // 👈 QUAN TRỌNG

        return;
    }

    // Nếu hợp lệ thì mới loading
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
    form.classList.add('loading');
});



