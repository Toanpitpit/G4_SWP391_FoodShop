document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('filterForm');
    console.log('Form:', form);
    console.log('searchKey:', form.querySelector('input[name="searchKey"]'));
    console.log('searchKeyDe:', form.querySelector('input[name="searchKeyDe"]'));
    console.log('sortCreate:', form.querySelector('#sortCreate'));
    console.log('sortUpdate:', form.querySelector('#sortUpdate'));

    const categoryTableBody = document.querySelector('tbody');
    const paginationWrapper = document.getElementById('paginationWrapper');
    
    async function sendAjax(page = 1) {
        const formData = new FormData(form);
        const params = new URLSearchParams();
        
        
        for (const [key, value] of formData.entries()) {
            params.append(key, value);
            
        }
        params.append('json', 'true');
        params.append('page', page);

        try {
            const res = await fetch(`nutricontrol?${params.toString()}`);
           
            const data = await res.json();
            
            updateFormFilters(data.filters);
            updateCategoryTable(data.categories);
            updatePagination(data.totalPages, data.currentPage, data.currentSize, data.totalSize);
            updateShowResult(data.categories.length, data.totalCategory);
        } catch (error) {
            console.error('AJAX error:', error);
        }
    }


    form.addEventListener('submit', e => {
        e.preventDefault();
        sendAjax(1);
    });

   
    form.querySelector('#sortCreate').addEventListener('change', () => {
        sendAjax(1);
    });

   
    form.querySelector('#sortUpdate').addEventListener('change', () => {
        sendAjax(1);
    });



//    // Xử lý thay đổi input search (có thể thêm debounce)
//    let searchTimeout;
//    form.querySelector('input[name="searchKey"]').addEventListener('input', () => {
//        clearTimeout(searchTimeout);
//        searchTimeout = setTimeout(() => {
//            console.log('✅ searchKey changed');
//            sendAjax(1);
//        }, 500); // Debounce 500ms
//    });
//
//    form.querySelector('input[name="searchKeyDe"]').addEventListener('input', () => {
//        clearTimeout(searchTimeout);
//        searchTimeout = setTimeout(() => {
//            console.log('✅ searchKeyDe changed');
//            sendAjax(1);
//        }, 500); // Debounce 500ms
//    });



    document.addEventListener('click', e => {
        if (e.target.classList.contains('pagination-link')) {
            e.preventDefault();
            const page = parseInt(e.target.dataset.page);
            sendAjax(page);
        }
    });

    function updateFormFilters(filters) {
        if (!filters) return;
        
        if ('searchKey' in filters) {
            form.querySelector('input[name="searchKey"]').value = filters.searchKey;
        }
        if ('searchKeyDe' in filters) {
            form.querySelector('input[name="searchKeyDe"]').value = filters.searchKeyDe;
        }
        if ('sortCreate' in filters) {
            form.querySelector('select[name="sortCreate"]').value = filters.sortCreate;
        }
        if ('sortUpdate' in filters) {
            form.querySelector('select[name="sortUpdate"]').value = filters.sortUpdate;
        }
    }

    function updateCategoryTable(categories) {
        categoryTableBody.innerHTML = '';

        if (!categories || categories.length === 0) {
            categoryTableBody.innerHTML = `
                <tr>
                    <td colspan="6" style="text-align: center; margin: 30px;">
                        Không tìm thấy loại nào phù hợp.
                    </td>
                </tr>`;
            return;
        }

        categories.forEach(cat => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td><strong>#${cat.catID}</strong></td>
                <td>${cat.caName}</td>
                <td class="ellipsis" title="${cat.decription}">${cat.decription}</td>
                <td>${formatDate(cat.create_at)}</td>
                <td>${formatDate(cat.update_at)}</td>
                <td>
                    <div class="table-actions">
                        <a class="action-btn edit-btn" title="Chỉnh sửa"
                           href="nutricontrol?action=showEditCategory&id=${cat.catID}">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a class="action-btn remove-btn" title="Xóa" 
                           style="background-color:red; color:white"
                           href="#" 
                           href="#" onclick="showDeletePopup('nutricontrol?action=deleteCategory&id=${cat.catID}', '${cat.caName}'); return false;">
                            <i class="fas fa-trash"></i>
                        </a>   
                    </div>
                </td>
            `;
            categoryTableBody.appendChild(row);
        });
    }

    function updatePagination(totalPages, currentPage, currentSize, totalSize) {
        let html = `
            <div style="padding: 10px">Show ${currentSize} of ${totalSize} items</div>
            <div class="pagination">`;
        if (currentPage > 1) {
            html += `<a href="#" class="prev pagination-link" data-page="${currentPage - 1}">&laquo; Previous</a>`;
        }

        for (let i = 1; i <= totalPages; i++) {
            if (i === currentPage) {
                html += `<span class="current">${i}</span>`;
            } else if (i <= currentPage + 2 && i >= currentPage - 2) {
                html += `<a href="#" class="pagination-link" data-page="${i}">${i}</a>`;
            } else if (i === currentPage - 3 || i === currentPage + 3) {
                html += `<span class="ellipsis">...</span>`;
            }
        }

        if (currentPage < totalPages) {
            html += `<a href="#" class="next pagination-link" data-page="${currentPage + 1}">Next &raquo;</a>`;
        }

        html += `</div>`;
        paginationWrapper.innerHTML = html;
    }
    function updateShowResult(currentSize, totalSize) {
        const showResultDiv = paginationWrapper.querySelector('div:first-child');
        if (showResultDiv) {
            showResultDiv.textContent = `Show ${currentSize} of ${totalSize} items`;
        }
    }
    function formatDate(dateString) {
        if (!dateString) return '';
        const date = new Date(dateString);
        const day = date.getDate().toString().padStart(2, '0');
        const month = (date.getMonth() + 1).toString().padStart(2, '0');
        const year = date.getFullYear();
        const hours = date.getHours().toString().padStart(2, '0');
        const minutes = date.getMinutes().toString().padStart(2, '0');
        const seconds = date.getSeconds().toString().padStart(2, '0');
        
        return `${day}/${month}/${year} ${hours}:${minutes}:${seconds}`;
    }
});
