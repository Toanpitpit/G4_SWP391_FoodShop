<div class="overview-container">
                    <div class="status-overview">
                        <div class="status-chart">
                            <canvas id="statusChart"></canvas>
                        </div>
                        <div class="status-legend">
                            <h3>Th?ng kê theo tr?ng thái</h3>
                            <ul class="legend-list">
                                <li>
                                    <span class="legend-color-box" style="background-color: rgba(75, 192, 192, 0.8);"></span>
                                    <span class="legend-label">Public</span>
                                    <span class="legend-value">${publicCount}</span>
                                </li>
                                <li>
                                    <span class="legend-color-box" style="background-color: rgba(255, 205, 86, 0.8);"></span>
                                    <span class="legend-label">Draft</span>
                                    <span class="legend-value">${draftCount}</span>
                                </li>
                                <li>
                                    <span class="legend-color-box" style="background-color: rgba(255, 99, 132, 0.8);"></span>
                                    <span class="legend-label">Private</span>
                                    <span class="legend-value">${privateCount}</span>
                                </li>
                            </ul>
                            <div class="chart-name">Bi?u ??: S? bài Blog theo tr?ng thái</div>
                        </div>
                    </div>

                    <div class="bmi-overview">
                        <div class="bmi-chart">
                            <canvas id="bmiChart"></canvas>
                        </div>
                        <div class="bmi-legend">
                            <h3>Th?ng kê theo lo?i BMI</h3>
                            <ul class="legend-list">
                                <c:forEach var="i" begin="0" end="${fn:length(typeLabels) - 1}">
                                    <c:set var="colorIdx" value="${i % 6}" />
                                    <li>
                                        <span class="legend-color-box"
                                              style="background-color: var(--bmi-color-${colorIdx});"></span>
                                        <span class="legend-label">${typeLabels[i]}</span>
                                        <span class="legend-value">${typeCounts[i]}</span>
                                    </li>
                                </c:forEach>
                                       
                            </ul>
                            <div class="chart-name">Bi?u ??: S? bài Blog theo lo?i BMI</div>
                        </div>
                    </div>
                </div>
                                    
                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                <script>

                    document.addEventListener('DOMContentLoaded', function () {
                        const ctx = document.getElementById('statusChart').getContext('2d');
                        const data = {
                            labels: ['Public', 'Draft', 'Private'],
                            datasets: [{
                                    data: [
                    ${publicCount},
                    ${draftCount},
                    ${privateCount}
                                    ],
                                    backgroundColor: [
                                        'rgba(75, 192, 192, 0.8)',
                                        'rgba(255, 205, 86, 0.8)',
                                        'rgba(255, 99, 132, 0.8)'
                                    ],
                                    hoverOffset: 4
                                }]
                        };
                        new Chart(ctx, {
                            type: 'pie',
                            data: data,
                            options: {
                                responsive: true,
                                plugins: {
                                    legend: {
                                        display: false
                                    },
                                    tooltip: {
                                        callbacks: {
                                            label: function (context) {
                                                const label = context.label || '';
                                                const value = context.parsed || 0;
                                                return label + ': ' + value;
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    });
                </script>
                <script type="text/javascript">
                    var typeLabels = [
                    <c:forEach var="lbl" items="${typeLabels}" varStatus="st">
                               "${lbl}"<c:if test="${!st.last}">,</c:if>
                        </c:forEach>
                    ];
                    var typeCounts = [
                        <c:forEach var="cnt" items="${typeCounts}" varStatus="st">
                                          ${cnt}<c:if test="${!st.last}">,</c:if>
                    </c:forEach>
                    ];
                                             </script>
                <script>
                        document.addEventListener('DOMContentLoaded', function () {
                        const ctxBmi = document.getElementById('bmiChart').getContext('2d');
                        const colorList = [
                            'rgba(54, 162, 235, 0.8)',
                            'rgba(255, 99, 132, 0.8)',
                            'rgba(255, 205, 86, 0.8)',
                            'rgba(75, 192, 192, 0.8)',
                            'rgba(153, 102, 255, 0.8)',
                            'rgba(255, 159, 64, 0.8)'
                        ];
                        const backgroundColors = typeLabels.map((_, idx) => {
                            return colorList[idx % colorList.length];
                        });

                        const bmiData = {
                            labels: typeLabels,
                            datasets: [{
                                    data: typeCounts,
                                    backgroundColor: backgroundColors,
                                    hoverOffset: 4
                                }]
                        };

                        new Chart(ctxBmi, {
                            type: 'pie',
                            data: bmiData,
                            options: {
                                responsive: true,
                                plugins: {
                                    legend: {display: false},
                                    tooltip: {
                                        callbacks: {
                                            label: function (context) {
                                                const label = context.label || '';
                                                const value = context.parsed || 0;
                                                return label + ': ' + value;
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    });
 </script>
