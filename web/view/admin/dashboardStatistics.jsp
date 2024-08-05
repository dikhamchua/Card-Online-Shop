<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Thống Kê</title>
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/switch-button.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
            .error {
                color: red;
            }
            .container-fluid {
                max-width: 1200px;
                margin-top: 20px;
            }
            .btn-submit {
                background-color: #28a745;
                color: white;
            }
            .btn-submit:hover {
                background-color: #218838;
            }
            .card-header i {
                margin-right: 5px;
            }
        </style>
    </head>
    <body id="page-top">

        <!-- Navbar-->
        <jsp:include page="navigationBar.jsp"></jsp:include>

            <div id="wrapper">

                <!-- Sidebar -->
            <jsp:include page="sideBar.jsp"></jsp:include>

                <div id="content-wrapper">
                    <div class="container-fluid">

                        <!-- Breadcrumbs-->
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/admin/statistics">Thống Kê</a>
                        </li>
                    </ol>

                    <!-- Page Content -->
                    <div class="row">
                        <div class="col-md-6">
                            <!-- Thống kê doanh thu và sản phẩm bán được -->
                            <div class="card mb-3">
                                <div class="card-header">
                                    <i class="fas fa-money-bill-wave"></i>
                                    Thống Kê Doanh Thu và Sản Phẩm Bán Được
                                </div>
                                <div class="card-body">
                                    <form method="GET" action="dashboardStatistics">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label for="startDate">Từ ngày:</label>
                                                <input type="date" class="form-control" id="startDate" name="startDate" value="${param.startDate}">
                                            </div>
                                            <div class="col-md-6">
                                                <label for="endDate">Đến ngày:</label>
                                                <input type="date" class="form-control" id="endDate" name="endDate" value="${param.endDate}">
                                            </div>
                                        </div>
                                        <input type="hidden" name="userStartDate" value="${param.userStartDate}">
                                        <input type="hidden" name="userEndDate" value="${param.userEndDate}">
                                        <input type="hidden" name="totalRevenue" value="${totalRevenue}">
                                        <div class="row mt-2">
                                            <div class="col-md-6">
                                                <button type="submit" class="btn btn-primary">Lọc</button>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                <button type="button" class="btn btn-primary" onclick="calculateTotalRevenue()">Tính tổng doanh thu</button>
                                            </div>
                                        </div>
                                    </form>
                                    <div class="row mt-3">
                                        <div class="col-md-6">
                                            <canvas id="revenueChart"></canvas>
                                            <button class="btn btn-primary mt-2" onclick="toggleRevenueChart()">Chuyển đổi biểu đồ</button>
                                        </div>
                                        <div class="col-md-6">
                                            <canvas id="ordersCountChart"></canvas>
                                            <button class="btn btn-primary mt-2" onclick="toggleOrdersCountChart()">Chuyển đổi biểu đồ</button>
                                        </div>
                                    </div>
                                    <table class="table table-bordered mt-3">
                                        <thead>
                                            <tr>
                                                <th>Ngày</th>   
                                                <th>Doanh Thu</th>
                                                <th>Số Lượng Đơn Hàng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="stat" items="${statistics}">
                                                <tr>
                                                    <td>${stat.orderDate}</td>
                                                    <td><fmt:formatNumber value="${stat.revenue}" type="currency" currencySymbol="₫" minFractionDigits="0" maxFractionDigits="0"/></td>
                                                    <td>${stat.ordersCount}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="d-flex justify-content-center mt-4">
                                        <nav aria-label="Page navigation">
                                            <ul class="pagination">
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link" href="dashboardStatistics?page=${currentPage - 1}&startDate=${param.startDate}&endDate=${param.endDate}&userStartDate=${param.userStartDate}&userEndDate=${param.userEndDate}&totalRevenue=${totalRevenue}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>
                                                <c:forEach var="i" begin="1" end="${noOfPages}">
                                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                        <a class="page-link" href="dashboardStatistics?page=${i}&startDate=${param.startDate}&endDate=${param.endDate}&userStartDate=${param.userStartDate}&userEndDate=${param.userEndDate}&totalRevenue=${totalRevenue}">${i}</a>
                                                    </li>
                                                </c:forEach>
                                                <li class="page-item ${currentPage == noOfPages ? 'disabled' : ''}">
                                                    <a class="page-link" href="dashboardStatistics?page=${currentPage + 1}&startDate=${param.startDate}&endDate=${param.endDate}&userStartDate=${param.userStartDate}&userEndDate=${param.userEndDate}&totalRevenue=${totalRevenue}" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-md-12">
                                            <h5>Tổng Doanh Thu: <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" minFractionDigits="0" maxFractionDigits="0"/></h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <!-- Thống kê đơn hàng theo người dùng -->
                            <div class="card mb-3">
                                <div class="card-header">
                                    <i class="fas fa-user"></i>
                                    Thống Kê Đơn Hàng Theo Người Dùng
                                </div>
                                <div class="card-body">
                                    <form method="GET" action="dashboardStatistics">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label for="userStartDate">Từ ngày:</label>
                                                <input type="date" class="form-control" id="userStartDate" name="userStartDate" value="${param.userStartDate}">
                                            </div>
                                            <div class="col-md-6">
                                                <label for="userEndDate">Đến ngày:</label>
                                                <input type="date" class="form-control" id="userEndDate" name="userEndDate" value="${param.userEndDate}">
                                            </div>
                                        </div>
                                        <input type="hidden" name="startDate" value="${param.startDate}">
                                        <input type="hidden" name="endDate" value="${param.endDate}">
                                        <input type="hidden" name="totalRevenue" value="${totalRevenue}">
                                        <div class="row mt-2">
                                            <div class="col-md-12 text-right">
                                                <button type="submit" class="btn btn-primary">Lọc</button>
                                            </div>
                                        </div>
                                    </form>
                                    <table class="table table-bordered mt-3">
                                        <thead>
                                            <tr>
                                                <th>Người Dùng</th>
                                                <th>Số Lượng Đơn Hàng</th>
                                                <th>Doanh Thu</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="userStat" items="${userStatistics}">
                                                <tr>
                                                    <td>${userStat.userName}</td>
                                                    <td>${userStat.orderCount}</td>
                                                    <td><fmt:formatNumber value="${userStat.totalRevenue}" type="currency" currencySymbol="₫" minFractionDigits="0" maxFractionDigits="0"/></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="d-flex justify-content-center mt-4">
                                        <nav aria-label="Page navigation">
                                            <ul class="pagination">
                                                <li class="page-item ${userCurrentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link" href="dashboardStatistics?userPage=${userCurrentPage - 1}&userStartDate=${param.userStartDate}&userEndDate=${param.userEndDate}&startDate=${param.startDate}&endDate=${param.endDate}&totalRevenue=${totalRevenue}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>
                                                <c:forEach var="i" begin="1" end="${userNoOfPages}">
                                                    <li class="page-item ${i == userCurrentPage ? 'active' : ''}">
                                                        <a class="page-link" href="dashboardStatistics?userPage=${i}&userStartDate=${param.userStartDate}&userEndDate=${param.userEndDate}&startDate=${param.startDate}&endDate=${param.endDate}&totalRevenue=${totalRevenue}">${i}</a>
                                                    </li>
                                                </c:forEach>
                                                <li class="page-item ${userCurrentPage == userNoOfPages ? 'disabled' : ''}">
                                                    <a class="page-link" href="dashboardStatistics?userPage=${userCurrentPage + 1}&userStartDate=${param.userStartDate}&userEndDate=${param.userEndDate}&startDate=${param.startDate}&endDate=${param.endDate}&totalRevenue=${totalRevenue}" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sticky Footer -->
                <jsp:include page="stickFooter.jsp"></jsp:include>

                    <!-- Scroll to Top Button-->
                    <a class="scroll-to-top rounded" href="#page-top">
                        <i class="fas fa-angle-up"></i>
                    </a>

                    <!-- Logout Modal-->
                <jsp:include page="logOutModal.jsp"></jsp:include>

                    <!-- Bootstrap core JavaScript-->
                    <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.min.js"></script>
                <script src="${pageContext.request.contextPath}/assets/css/vendor/bootstrap.bundle.min.js"></script>

                <!-- Core plugin JavaScript-->
                <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.easing.min.js"></script>

                <!-- Custom scripts for all pages-->
                <script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>

                <!-- jQuery và Bootstrap JS -->
                <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

                <script>
                                                var orderDates = [
                    <c:forEach items="${statistics}" var="stat">
                                                    "${stat.orderDate}",
                    </c:forEach>
                                                ];

                                                var revenues = [
                    <c:forEach items="${statistics}" var="stat">
                        ${stat.revenue},
                    </c:forEach>
                                                ];

                                                var ordersCounts = [
                    <c:forEach items="${statistics}" var="stat">
                        ${stat.ordersCount},
                    </c:forEach>
                                                ];

                                                var revenueCtx = document.getElementById('revenueChart').getContext('2d');
                                                var ordersCountCtx = document.getElementById('ordersCountChart').getContext('2d');

                                                var revenueChartConfig = {
                                                    type: 'bar',
                                                    data: {
                                                        labels: orderDates,
                                                        datasets: [{
                                                                label: 'Doanh thu (VND)',
                                                                data: revenues,
                                                                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                                                borderColor: 'rgba(75, 192, 192, 1)',
                                                                borderWidth: 1
                                                            }]
                                                    },
                                                    options: {
                                                        scales: {
                                                            y: {
                                                                beginAtZero: true
                                                            }
                                                        }
                                                    }
                                                };

                                                var ordersCountChartConfig = {
                                                    type: 'bar',
                                                    data: {
                                                        labels: orderDates,
                                                        datasets: [{
                                                                label: 'Số lượng đơn hàng',
                                                                data: ordersCounts,
                                                                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                                                                borderColor: 'rgba(255, 99, 132, 1)',
                                                                borderWidth: 1
                                                            }]
                                                    },
                                                    options: {
                                                        scales: {
                                                            y: {
                                                                beginAtZero: true,
                                                                stepSize: 1,
                                                                precision: 0
                                                            }
                                                        }
                                                    }
                                                };

                                                var revenueChart = new Chart(revenueCtx, revenueChartConfig);
                                                var ordersCountChart = new Chart(ordersCountCtx, ordersCountChartConfig);

                                                function toggleRevenueChart() {
                                                    if (revenueChartConfig.type === 'bar') {
                                                        revenueChartConfig.type = 'line';
                                                    } else {
                                                        revenueChartConfig.type = 'bar';
                                                    }
                                                    revenueChart.destroy();
                                                    revenueChart = new Chart(revenueCtx, revenueChartConfig);
                                                }

                                                function toggleOrdersCountChart() {
                                                    if (ordersCountChartConfig.type === 'bar') {
                                                        ordersCountChartConfig.type = 'line';
                                                    } else {
                                                        ordersCountChartConfig.type = 'bar';
                                                    }
                                                    ordersCountChart.destroy();
                                                    ordersCountChart = new Chart(ordersCountCtx, ordersCountChartConfig);
                                                }

                                                function calculateTotalRevenue() {
                                                    const urlParams = new URLSearchParams(window.location.search);
                                                    urlParams.set('action', 'calculateTotalRevenue');
                                                    urlParams.set('startDate', document.getElementById('startDate').value);
                                                    urlParams.set('endDate', document.getElementById('endDate').value);
                                                    urlParams.set('userStartDate', document.getElementById('userStartDate').value);
                                                    urlParams.set('userEndDate', document.getElementById('userEndDate').value);
                                                    window.location.search = urlParams.toString();
                                                }
                </script>
            </div>
        </div>
    </body>
</html>
