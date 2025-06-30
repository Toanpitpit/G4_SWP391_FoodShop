//document.addEventListener('DOMContentLoaded', () => {
//    const form = document.getElementById('searchFilterForm');
//    console.log('Form:', form);
//    
//    const blogTableBody = document.getElementById('blogTableBody');
//    const paginationWrapper = document.getElementById('paginationWrapper');
//    
// 
//    async function sendAjax(page = 1) {
//        const formData = new FormData(form);
//        const params = new URLSearchParams();
//        
//        
//        for (const [key, value] of formData.entries()) {
//            if (value.trim() !== '') {
//                params.append(key, value);
//                console.log(`${key}: ${value}`);
//            }
//        }
//        
//     
//        params.append('json', 'true');
//        params.append('index', page);
//
//        try {
//            const res = await fetch(`nutricontrol?action=showBMI&${params.toString()}`);
//            const data = await res.json();
//            
//            console.log('Received data:', data);
//            
//            updateFormFilters(data.filters);
//            updateBMITable(data.lstBMI || data.bmis);
//            updatePagination(data.totalPages, data.currentPage, data.currentSize, data.totalCount);
//            
//        } catch (error) {
//            console.error('AJAX error:', error);
//            showErrorMessage('Có lỗi xảy ra khi tải dữ liệu. Vui lòng thử lại.');
//        }
//    }
//
//   
//    form.addEventListener('submit', e => {
//        e.preventDefault();
//        
//        sendAjax(1);
//    });
//
//   
//    form.querySelector('select[name="limitpage"]').addEventListener('change', () => {
//        
//        sendAjax(1);
//    });
//
//    form.querySelector('select[name="sortOrderTarget"]').addEventListener('change', () => {
//        
//        sendAjax(1);
//    });
//
//    form.querySelector('select[name="sortOrderID"]').addEventListener('change', () => {
//        
//        sendAjax(1);
//    });
//
//    
//    let searchTimeout;
//    form.querySelector('input[name="input_search"]').addEventListener('input', () => {
//        clearTimeout(searchTimeout);
//        searchTimeout = setTimeout(() => {
//            console.log('✅ Search input changed');
//            sendAjax(1);
//        }, 500); 
//    });
//
//    document.addEventListener('click', e => {
//        if (e.target.classList.contains('pagination-link')) {
//            e.preventDefault();
//            const page = parseInt(e.target.dataset.page);
//            if (!isNaN(page)) {
//                sendAjax(page);
//            }
//        }
//    });
//
//    document.querySelector('.reset-button').addEventListener('click', e => {
//        e.preventDefault();
//        // Clear all form inputs
//        form.querySelector('input[name="input_search"]').value = '';
//        form.querySelector('select[name="limitpage"]').value = '5';
//        form.querySelector('select[name="sortOrderTarget"]').value = '';
//        form.querySelector('select[name="sortOrderID"]').value = '';
//        
//        sendAjax(1);
//    });
//
//    // Update form filters (maintain filter state)
//    function updateFormFilters(filters) {
//        if (!filters) return;
//        
//        if ('input_search' in filters) {
//            form.querySelector('input[name="input_search"]').value = filters.input_search || '';
//        }
//        if ('sortOrderDe' in filters) {
//            form.querySelector('select[name="limitpage"]').value = filters.sortOrderDe || '';
//        }
//        if ('sortOrderTarget' in filters) {
//            form.querySelector('select[name="sortOrderTarget"]').value = filters.sortOrderTarget || '';
//        }
//        if ('sortOrderID' in filters) {
//            form.querySelector('select[name="sortOrderID"]').value = filters.sortOrderID || '';
//        }
//    }
//
//    function updateBMITable(bmis) {
//        blogTableBody.innerHTML = '';
//
//        if (!bmis || bmis.length === 0) {
//            showEmptyState();
//            return;
//        }
//
//        bmis.forEach((bmi, index) => {
//            const row = document.createElement('tr');
//            row.innerHTML = `
//                <td>#${index + 1}</td>
//                <td>${bmi.bmiID || ''}</td>
//                <td>${bmi.classification || ''}</td>
//                <td>${bmi.bmiRange || ''}</td>
//                <td>${bmi.decription || bmi.description || ''}</td>
//                <td>${bmi.tagetAudience || bmi.targetAudience || ''}</td>
//            `;
//            blogTableBody.appendChild(row);
//        });
//    }
//
//    function showEmptyState() {
//        const tableContainer = blogTableBody.closest('table').parentElement;
//        tableContainer.innerHTML = `
//            <div class="empty-state">
//                <i class="fas fa-inbox empty-state-icon"></i>
//                <h3 class="empty-state-title">Không có dữ liệu BMI</h3>
//                <p class="empty-state-description">
//                    Hiện tại chưa có thông tin BMI nào trong hệ thống.<br>
//                    Hãy thêm mới hoặc kiểm tra lại điều kiện lọc của bạn.
//                </p>
//                <div class="empty-state-actions">
//                    <button class="empty-state-btn empty-state-btn-secondary" onclick="resetAllFilters()">
//                        <i class="fas fa-refresh"></i> Làm mới dữ liệu
//                    </button>
//                </div>
//            </div>
//        `;
//    }
//
//    function updatePagination(totalPages, currentPage, currentSize, totalSize) {
//        if (!totalPages || totalPages <= 0) {
//            paginationWrapper.innerHTML = `<div style="padding: 10px">Show 0 of 0 items</div>`;
//            return;
//        }
//
//        let html = `<div style="padding: 10px">Show ${currentSize || 0} of ${totalSize || 0} items</div>`;
//        
//        if (totalPages > 1) {
//            html += `<div class="pagination">`;
//
//            // Previous button
//            if (currentPage > 1) {
//                html += `<a href="#" class="prev pagination-link" data-page="${currentPage - 1}">&laquo; Previous</a>`;
//            }
//
//            // Page numbers
//            for (let i = 1; i <= totalPages; i++) {
//                if (i === currentPage) {
//                    html += `<span class="current">${i}</span>`;
//                } else if (i <= currentPage + 2 && i >= currentPage - 2) {
//                    html += `<a href="#" class="pagination-link" data-page="${i}">${i}</a>`;
//                } else if (i === currentPage - 3 || i === currentPage + 3) {
//                    html += `<span class="ellipsis">...</span>`;
//                }
//            }
//
//            // Next button
//            if (currentPage < totalPages) {
//                html += `<a href="#" class="next pagination-link" data-page="${currentPage + 1}">Next &raquo;</a>`;
//            }
//
//            html += `</div>`;
//        }
//        
//        paginationWrapper.innerHTML = html;
//    }
//
//    function showErrorMessage(message) {
//        const errorDiv = document.createElement('div');
//        errorDiv.className = 'alert alert-danger';
//        errorDiv.style.cssText = 'position: fixed; top: 20px; right: 20px; z-index: 9999; padding: 15px; background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; border-radius: 4px;';
//        errorDiv.innerHTML = `
//            <strong>Lỗi!</strong> ${message}
//            <button type="button" style="float: right; background: none; border: none; font-size: 18px; color: #721c24; cursor: pointer;" onclick="this.parentElement.remove()">×</button>
//        `;
//        document.body.appendChild(errorDiv);
//        setTimeout(() => {
//            if (errorDiv.parentElement) {
//                errorDiv.remove();
//            }
//        }, 5000);
//    }
//    window.showAddModal = function() {
//        console.log('Show add BMI modal');
//        alert('Chức năng thêm BMI sẽ được triển khai');
//    };
//
//    window.resetAllFilters = function() {
//
//        form.querySelector('input[name="input_search"]').value = '';
//        form.querySelector('select[name="sortOrderDe"]').value = '';
//        form.querySelector('select[name="sortOrderTarget"]').value = '';
//        form.querySelector('select[name="sortOrderID"]').value = '';
//        
//        sendAjax(1);
//    };
//
//    console.log('🚀 Loading initial BMI data...');
//    sendAjax(1);
//});
