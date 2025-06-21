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
        const allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
        if (!allowedTypes.includes(file.type)) {
            showAlert("❌ Chỉ hỗ trợ định dạng ảnh JPG, PNG, GIF.", 'danger', 5000);
            event.target.value = '';
            preview.src = '';
            preview.style.display = 'none';
            placeholder.style.display = 'block';
            container.classList.remove('has-image');
            return;
        }

        if (file.size > 5 * 1024 * 1024) {
            showAlert("❌ Ảnh vượt quá dung lượng cho phép (5MB).", 'danger', 5000);
            event.target.value = '';
            preview.src = '';
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
    } else {
        preview.src = '';
        preview.style.display = 'none';
        placeholder.style.display = 'block';
        container.classList.remove('has-image');
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
        const allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
        if (!allowedTypes.includes(file.type)) {
            showAlert("❌ Chỉ hỗ trợ ảnh JPG, PNG, GIF.", 'danger', 5000);
            event.target.value = '';
            preview.style.display = 'none';
            placeholder.style.display = 'block';
            container.classList.remove('has-image');
            return;
        }
        if (file.size > 5 * 1024 * 1024) {
            showAlert("Ảnh vượt quá dung lượng cho phép (5MB). Vui lòng chọn ảnh nhỏ hơn.", 'danger', 5000);
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

 document.getElementById('newBlogForm').addEventListener('submit', function (e) {
    const form = document.querySelector('.new-blog-form');
    const button = document.querySelector('.new-btn-submit');
    const overlay = document.querySelector('.loading-overlay');
    const elements = form.querySelectorAll("input, textarea, select, button");
    
    const titleInput = document.getElementById('title');
    const titleText = titleInput.value.trim();
    const wordCount = titleText.split(/\s+/).filter(word => word !== '').length;

    if (wordCount < 5 || wordCount > 30) {
        e.preventDefault();
        showWarning('❗ Tiêu đề phải chứa từ 5 đến 30 từ để tối ưu SEO.');
        form.classList.remove('loading');
        button.disabled = false;
        button.innerHTML = '<i class="fas fa-check"></i> Xuất bản bài viết';
        if (overlay) overlay.style.display = 'none';
        elements.forEach(el => el.disabled = false);
        return;
    }

   
    const content = CKEDITOR.instances.editor.getData().trim();
    if (!content) {
        e.preventDefault();
        showWarning("❗ Vui lòng nhập nội dung bài viết trước khi xuất bản.");
        form.classList.remove('loading');
        button.disabled = false;
        button.innerHTML = '<i class="fas fa-check"></i> Xuất bản bài viết';
        if (overlay) overlay.style.display = 'none';
        elements.forEach(el => el.disabled = false);
        return;
    }  
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
    form.classList.add('loading');
});


    
