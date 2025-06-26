document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('filterForm');
    console.log('Form:', form);
    console.log('statusFilter:', form.querySelector('select[name="status"]'));
    console.log('bmiIdFilter:', form.querySelector('select[name="bmiId"]'));
    console.log('categoryFilter:', form.querySelector('select[name="category"]'));

    const foodTableBody = document.querySelector('tbody');
    const paginationWrapper = document.getElementById('paginationWrapper');
    
    async function sendAjax(page = 1) {
        const formData = new FormData(form);
        const params = new URLSearchParams();
        
        // Thêm tất cả các tham số từ form
        for (const [key, value] of formData.entries()) {
            if (value !== '') {  // Chỉ thêm các giá trị không rỗng
                params.append(key, value);
                console.log(`${key}: ${value}`);
            }
        }
        
        // Thêm các tham số bắt buộc
        params.append('json', 'true');
        params.append('page', page);
        params.append('action', 'displaysortfood');

        try {
            const res = await fetch(`nutricontrol?${params.toString()}`);
            console.log("Status code:", res.status);
            
            if (!res.ok) {
                throw new Error(`HTTP error! status: ${res.status}`);
            }
            
            const data = await res.json();
            console.log('Response data:', data);
            
            updateFormFilters(data.filters);
            updateFoodTable(data.foods || data.lstFood);
            updatePagination(data.totalPages, data.currentPage, data.currentSize, data.totalFood);
        } catch (error) {
            console.error('AJAX error:', error);
            // Hiển thị thông báo lỗi cho người dùng
            showErrorMessage('Đã xảy ra lỗi khi tải dữ liệu. Vui lòng thử lại.');
        }
    }

    // Xử lý submit form
    form.addEventListener('submit', e => {
        e.preventDefault();
        console.log('✅ Form submit captured');
        sendAjax(1);
    });

    // Xử lý thay đổi trạng thái
    form.querySelector('select[name="status"]').addEventListener('change', () => {
        console.log('✅ Status filter changed');
        sendAjax(1);
    });

    // Xử lý thay đổi BMI
    form.querySelector('select[name="bmiId"]').addEventListener('change', () => {
        console.log('✅ BMI filter changed');
        sendAjax(1);
    });

    // Xử lý thay đổi category
    form.querySelector('select[name="category"]').addEventListener('change', () => {
        console.log('✅ Category filter changed');
        sendAjax(1);
    });

    // Xử lý thay đổi price range
    form.querySelector('select[name="priceRank"]').addEventListener('change', () => {
        console.log('✅ Price range changed');
        sendAjax(1);
    });

    // Xử lý thay đổi sort options
    ['sortTime', 'sortID', 'sortPrice'].forEach(sortName => {
        const sortElement = form.querySelector(`select[name="${sortName}"]`);
        if (sortElement) {
            sortElement.addEventListener('change', () => {
                console.log(`✅ ${sortName} changed`);
                sendAjax(1);
            });
        }
    });

    // Xử lý tìm kiếm theo tên
    let searchTimeout;
    form.querySelector('input[name="searchKey"]').addEventListener('input', (e) => {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => {
            console.log('✅ Search key changed:', e.target.value);
            sendAjax(1);
        }, 500); // Debounce 500ms
    });

    // Xử lý tìm kiếm theo giá
    form.querySelector('input[name="searchPrice"]').addEventListener('input', (e) => {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => {
            console.log('✅ Search price changed:', e.target.value);
            sendAjax(1);
        }, 500);
    });

    // Xử lý click pagination
    document.addEventListener('click', e => {
        if (e.target.classList.contains('pagination-link')) {
            e.preventDefault();
            const page = parseInt(e.target.dataset.page);
            if (!isNaN(page)) {
                sendAjax(page);
            }
        }
    });

    // Cập nhật các filter trong form
    function updateFormFilters(filters) {
        if (!filters) return;
        
        Object.keys(filters).forEach(key => {
            const element = form.querySelector(`[name="${key}"]`);
            if (element && filters[key] !== undefined) {
                element.value = filters[key];
            }
        });
    }

    // Cập nhật bảng món ăn
    function updateFoodTable(foods) {
        if (!foodTableBody) return;
        
        foodTableBody.innerHTML = '';

        if (!foods || foods.length === 0) {
            foodTableBody.innerHTML = `
                <tr>
                    <td colspan="8" style="text-align: center; padding: 30px;">
                        Không tìm thấy món ăn nào phù hợp.
                    </td>
                </tr>`;
            return;
        }

        foods.forEach(food => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>
                    <img src="${food.image || ''}" alt="anh food" class="table-avatar" 
                         onerror="this.src='default-food-image.jpg'"/>
                </td>
                <td><strong>#${food.foodId}</strong></td>
                <td>${food.foodname || ''}</td>
                <td>${food.category || ''}</td>
                <td>
                    <span class="price-value">
                        ${formatPrice(food.price)} <small>₫</small>
                    </span>
                </td>
                <td>
                    <span class="status-badge status-active">${food.status || ''}</span> 
                </td>
                <td>
                    ${formatDateTime(food.update_at)}
                </td>
                <td>
                    <div class="table-actions">
                        <a class="action-btn view-btn" title="Xem chi tiết" 
                           href="nutricontrol?action=showfooddetail&id=${food.foodId}">
                            <i class="fas fa-eye"></i>
                        </a>
                        <a class="action-btn edit-btn" title="Tạo Bản sao" 
                           href="nutricontrol?action=copyfood&id=${food.foodId}">
                            <i class="fas fa-clone"></i>
                        </a>
                    </div>
                </td>
            `;
            foodTableBody.appendChild(row);
        });
    }

    // Cập nhật pagination
    function updatePagination(totalPages, currentPage, currentSize, totalFood) {
        if (!paginationWrapper) return;
        
        let html = `<div style="padding: 10px">Show ${currentSize || 0} of ${totalFood || 0} items</div>`;
        
        if (totalPages > 1) {
            html += `<div class="pagination">`;
            
            // Previous button
            if (currentPage > 1) {
                html += `<a href="#" class="prev pagination-link" data-page="${currentPage - 1}">&laquo; Previous</a>`;
            }
            
            // Page numbers
            for (let i = 1; i <= totalPages; i++) {
                if (i === currentPage) {
                    html += `<span class="current">${i}</span>`;
                } else if (i <= currentPage + 2 && i >= currentPage - 2) {
                    html += `<a href="#" class="pagination-link" data-page="${i}">${i}</a>`;
                } else if (i === currentPage - 3 || i === currentPage + 3) {
                    html += `<span class="ellipsis">...</span>`;
                }
            }
            
            // Next button
            if (currentPage < totalPages) {
                html += `<a href="#" class="next pagination-link" data-page="${currentPage + 1}">Next &raquo;</a>`;
            }
            
            html += `</div>`;
        }
        
        paginationWrapper.innerHTML = html;
    }

    // Utility functions
    function formatPrice(price) {
        if (!price) return '0';
        return new Intl.NumberFormat('vi-VN').format(price);
    }

    function formatDateTime(dateTime) {
        if (!dateTime) return '';
        try {
            const date = new Date(dateTime);
            return date.toLocaleDateString('vi-VN', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });
        } catch (e) {
            return dateTime; // Trả về giá trị gốc nếu không parse được
        }
    }

    function showErrorMessage(message) {
        // Tạo hoặc cập nhật thông báo lỗi
        let errorDiv = document.getElementById('error-message');
        if (!errorDiv) {
            errorDiv = document.createElement('div');
            errorDiv.id = 'error-message';
            errorDiv.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                background-color: #f8d7da;
                color: #721c24;
                padding: 15px;
                border: 1px solid #f5c6cb;
                border-radius: 4px;
                z-index: 1000;
                max-width: 300px;
            `;
            document.body.appendChild(errorDiv);
        }
        
        errorDiv.textContent = message;
        errorDiv.style.display = 'block';
        
        // Tự động ẩn sau 5 giây
        setTimeout(() => {
            errorDiv.style.display = 'none';
        }, 5000);
    }

    // Toggle advanced filters
    window.toggleAdvancedFilters = function() {
        const advancedFilters = document.getElementById('advancedFilters');
        if (advancedFilters) {
            const isVisible = advancedFilters.style.display === 'block';
            advancedFilters.style.display = isVisible ? 'none' : 'block';
        }
    };

    // Initial load - có thể bỏ comment nếu muốn load dữ liệu ngay khi trang được tải
    // sendAjax(1);
});
