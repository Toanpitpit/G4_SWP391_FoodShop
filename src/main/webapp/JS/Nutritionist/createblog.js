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
    const validWords = titleText.split(/\s+/).filter(word => /[\p{L}\p{N}]/u.test(word));
    const wordCount = validWords.length;
    if (wordCount < 5 || wordCount > 30) {
        e.preventDefault();
        showWarning('❗ Tiêu đề phải chứa từ 5 đến 30 từ không tính ký tự đặc biệt để tối ưu SEO.');
        form.classList.remove('loading');
        button.disabled = false;
        button.innerHTML = '<i class="fas fa-check"></i> Xuất bản bài viết';
        if (overlay) overlay.style.display = 'none';
        elements.forEach(el => el.disabled = false);
        return;
    }


    const contentHTML = CKEDITOR.instances.editor.getData().trim();

    const contentText = contentHTML
            .replace(/<[^>]*>/g, '')
            .replace(/&nbsp;/g, ' ')
            .trim();


    const contentWords = contentText.split(/\s+/).filter(word => /[\p{L}\p{N}]/u.test(word));
    const contentWordCount = contentWords.length;


    if (contentWordCount < 20) {
        e.preventDefault();
        showWarning("❗ Nội dung bài viết phải có ít nhất 20 từ hợp lệ (không tính ký tự đặc biệt).");
        form.classList.remove('loading');
        button.disabled = false;
        button.innerHTML = '<i class="fas fa-check"></i> Xuất bản bài viết';
        if (overlay)
            overlay.style.display = 'none';
        elements.forEach(el => el.disabled = false);
        return;
    }
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
    form.classList.add('loading');
});


    
