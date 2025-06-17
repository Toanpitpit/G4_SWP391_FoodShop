document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('searchFilterForm');
    console.log('Form:', form);
    console.log('statusFilter:', form.querySelector('#statusFilter'));
    console.log('BmitypeFilter:', form.querySelector('#BmitypeFilter'));

    const blogTableBody = document.getElementById('blogTableBody');
    const paginationWrapper = document.getElementById('paginationWrapper');
    
    async function sendAjax(page = 1) {
        const formData = new FormData(form);
        const params = new URLSearchParams();
        for (const [key, value] of formData.entries()) {
            params.append(key, value);
             console.log(`${key}: ${value}`);
        }
        params.append('json', 'true');
        params.append('index', page);

        try {
            const res = await fetch(`nutricontrol?action=displayblog&${params.toString()}`);
            console.log("Status code:", res.status);
            const data = await res.json();
            updateFormFilters(data.filters);
            updateBlogTable(data.blogs);
            updatePagination(data.totalPages, data.currentPage,data.currentSize, data.totalSize);
            updateShowResult(data.blogs.length, data.totalBlog);
        } catch (error) {
            console.error('AJAX error:', error);
        }
    }

    form.addEventListener('submit', e => {
        e.preventDefault();
        console.log('✅ Form submit captured'); // Kiểm tra đã bắt sự kiện submit
        sendAjax(1);
    });

    form.querySelector('#statusFilter').addEventListener('change', () => {
        console.log('✅ statusFilter changed'); // Kiểm tra đã chọn trạng thái mới
        sendAjax(1);
    });

    form.querySelector('#BmitypeFilter').addEventListener('change', () => {
        console.log('✅ BmitypeFilter changed'); // Kiểm tra đã chọn BMI mới
        sendAjax(1);
    });


    document.addEventListener('click', e => {
        if (e.target.classList.contains('pagination-link')) {
            e.preventDefault();
            const page = parseInt(e.target.dataset.page);
            sendAjax(page);
        }
    });

      function updateFormFilters(filters) {
        if (!filters) return;
        if ('input_search' in filters) {
            form.querySelector('input[name="input_search"]').value = filters.input_search;
        }
        if ('status' in filters) {
            form.querySelector('select[name="status"]').value = filters.status;
        }
         if ('bmiID' in filters) {
            form.querySelector('select[name="bmiID"]').value = filters.status;
        }
        
    }

    function updateBlogTable(blogs) {
        blogTableBody.innerHTML = '';

        if (!blogs || blogs.length === 0) {
            blogTableBody.innerHTML = `<tr><td colspan="10" style="text-align:center;">Không có bài viết nào</td></tr>`;
            return;
        }

        blogs.forEach(blog => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td colspan="3">
                    <img src="${blog.imageUlr}" alt="Ảnh blog" style="width: 80px; height: 44px; object-fit: cover;">
                </td>
                <td class="blog-id">${blog.bID}</td>
                <td class="blog-title">${blog.title}</td>
                <td>
                    <span class="status status-${blog.status}">
                        ${blog.status}
                    </span>
                </td>
                <td class="date-time">${blog.update_at}</td>
                <td class="action-cell" style="text-align: center;">
                    <a href="nutricontrol?id=${blog.bID}&action=displayblogdetail" title="View"><ion-icon name="eye-outline"></ion-icon></a>
                    <a href="nutricontrol?id=${blog.bID}&action=editblog" title="Edit"> <ion-icon name="create-outline"</ion-icon></a>
                    <a href="#" title="Delete"
                                                       onclick="showDeletePopup('nutricontrol?action=deleteblog&id=${blog.bID}', '${blog.title}'); return false;">
                                                        <ion-icon name="trash-outline" style="color: red"></ion-icon>
                                               </a>
                </td>
            `;
            blogTableBody.appendChild(row);
        });
    }

    function updatePagination(totalPages, currentPage, currentSize, totalSize) {
        let html = `<div style="margin: 30px 0 20px">Show ${currentSize} of ${totalSize} items</div><div class="pagination">`;

        if (currentPage > 1) {
            html += `<a href="#" class="pagination-link" data-page="${currentPage - 1}">&laquo; Previous</a>`;
        }

        for (let i = 1; i <= totalPages; i++) {
            if (i === currentPage) {
                html += `<span class="current">${i}</span>`;
            } else if (i >= currentPage - 2 && i <= currentPage + 2) {
                html += `<a href="#" class="pagination-link" data-page="${i}">${i}</a>`;
            } else if (i === currentPage - 3 || i === currentPage + 3) {
                html += `<span class="ellipsis">...</span>`;
            }
        }

        if (currentPage < totalPages) {
            html += `<a href="#" class="pagination-link" data-page="${currentPage + 1}">Next &raquo;</a>`;
        }

        html += `</div>`;
        paginationWrapper.innerHTML = html;
    }

   
});


