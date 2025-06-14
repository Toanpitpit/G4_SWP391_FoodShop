/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function newPreviewImage(event) {
    const file = event.target.files[0];
    const preview = document.getElementById('new-preview');
    const placeholder = document.getElementById('newUploadPlaceholder');
    const container = document.querySelector('.new-image-preview-container');

    if (file) {
        if (file.size > 5 * 1024 * 1024) {
            showAlert("Ảnh vượt quá dung lượng cho phép (5MB). Vui lòng chọn ảnh nhỏ hơn.", type = 'danger', duration = 5000);
            event.target.value = ''; 
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
function previewImageEdit(event) {
    const file = event.target.files[0];
    const preview = document.getElementById('new-preview-edit');
    const placeholder = document.getElementById('newUploadPlaceholder');
    const container = document.querySelector('.new-image-preview-container');

    if (!preview) {
        console.error("Không tìm thấy phần tử preview!");
        return;
    }

    if (file) {
        if (file.size > 5 * 1024 * 1024) {
            showAlert("Ảnh vượt quá 5MB.", 'danger', 5000);
            event.target.value = '';
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
        e.preventDefault(); 
        showWarning('Tiêu đề phải chứa từ 5 đến 30 từ để tối ưu SEO.');
        button.innerHTML = '<i class="fas fa-check"></i> Xuất bản bài viết';
        form.classList.remove('loading'); 
        return;
    }
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
    form.classList.add('loading');
});



