<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="entity.Orders" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Lịch sử mua hàng</title>
        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">
        <!-- Page level plugin CSS-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/dataTables.bootstrap4.css" rel="stylesheet">
        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/colReorder-bootstrap4.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <style>
            table {
                width: 100%;
                margin: auto;
                text-align: center;
                border-collapse: collapse;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
            }
            .header-title {
                font-size: 1.5rem;
                font-weight: bold;
            }
            .no-orders {
                font-size: 1.2rem;
                font-weight: bold;
                text-align: center;
                color: #555;
            }
            .filter-form {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }
            .filter-form .form-group {
                margin-right: 10px;
            }
        </style>
    </head>
    <body id="page-top">
        <%@include file="../user/navigationBar.jsp" %>
        <div id="wrapper">
            <!-- Sidebar -->
            <%@include file="../user/sideBar.jsp" %>
            <div id="content-wrapper">
                <div class="container-fluid">
                    <!-- Breadcrumbs-->
                    <%@include file="../user/breadCumb.jsp" %>
                    <!-- Orders section -->
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12 text-center">
                                        <h4 class="header-title">Đơn Hàng Của Bạn</h4>
                                        <hr>
                                    </div>
                                </div>
                                <!-- Filter Form -->
                                <form method="get" action="UserOrdersServlet" class="filter-form">
                                    <div class="form-group">
                                        <label for="startDate">Từ ngày:</label>
                                        <input type="date" class="form-control" id="startDate" name="startDate" value="${param.startDate}">
                                    </div>
                                    <div class="form-group">
                                        <label for="endDate">Đến ngày:</label>
                                        <input type="date" class="form-control" id="endDate" name="endDate" value="${param.endDate}">
                                    </div>
                                    <div class="form-group align-self-end">
                                        <button type="submit" class="btn btn-primary">Lọc</button>
                                    </div>
                                </form>
                                <section class="gi-orders-section py-8 max-[767px]:py-6">
                                    <div class="container mx-auto px-4">
                                        <div class="overflow-x-auto">
                                            <c:if test="${not empty userOrders}">
                                                <table border="1">
                                                    <thead>
                                                        <tr>
                                                            <th>Order ID</th>
                                                            <th>Tổng tiền</th>
                                                            <th>Ngày mua</th>
                                                            <th>Xem chi tiết</th>
                                                            <th>Đánh giá</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:set var="itemsPerPage" value="10" />
                                                        <c:forEach var="order" items="${userOrders}" varStatus="status">
                                                            <c:set var="orderIndex" value="${(currentPage - 1) * itemsPerPage + status.index + 1}" />
                                                            <tr class="border-b">
                                                                <td class="py-3 px-6 text-sm text-gray-700">${orderIndex}</td>
                                                                <td class="price-format py-3 px-6 text-sm text-gray-700">${order.totalMoney}</td>
                                                                <td class="py-3 px-6 text-sm text-gray-700">
                                                                    <fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                                </td>
                                                                <td class="py-3 px-6 text-sm text-gray-700">
                                                                    <button class="text-blue-600" onclick="showOrderDetails('${order.getID()}', '${order.totalMoney}', '<fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm:ss" />')">Chi tiết</button>
                                                                </td>
                                                                <td class="py-3 px-6 text-sm text-gray-700">
                                                                    <a href="${pageContext.request.contextPath}/reviews?orderId=${order.ID}&totalMoney=${order.totalMoney}&orderDate=<fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm:ss" />" class="text-blue-600">Đánh giá</a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </c:if>
                                            <c:if test="${empty userOrders}">
                                                <p class="no-orders">Bạn chưa có đơn hàng nào!</p>
                                            </c:if>
                                        </div>
                                        <c:if test="${totalPages > 1}">
                                            <nav class="mt-6" aria-label="Page navigation">
                                                <ul class="pagination flex justify-center">
                                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                        <a class="page-link px-3 py-2 mx-1 rounded border ${currentPage == 1 ? 'text-gray-400 border-gray-300' : 'text-blue-600 border-blue-600'}" href="?page=${currentPage - 1}&startDate=${param.startDate}&endDate=${param.endDate}" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                            <a class="page-link px-3 py-2 mx-1 rounded border ${currentPage == i ? 'bg-blue-600 text-white border-blue-600' : 'text-blue-600 border-blue-600'}" href="?page=${i}&startDate=${param.startDate}&endDate=${param.endDate}">${i}</a>
                                                        </li>
                                                    </c:forEach>
                                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                        <a class="page-link px-3 py-2 mx-1 rounded border ${currentPage == totalPages ? 'text-gray-400 border-gray-300' : 'text-blue-600 border-blue-600'}" href="?page=${currentPage + 1}&startDate=${param.startDate}&endDate=${param.endDate}" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </c:if>
                                    </div>
                                </section>
                                <!-- Order Details Modal -->
                                <div id="orderDetailsModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full" style="z-index: 1000;">
                                    <div class="relative top-20 mx-auto p-5 border w-2/3 shadow-lg rounded-md bg-white">
                                        <div class="mt-3 text-center">
                                            <h3 class="text-lg leading-6 font-medium text-gray-900">Order Details</h3>
                                            <div class="mt-2">
                                                <p class="text-sm text-gray-500">Order Number: <span id="modalOrderNumber"></span></p>
                                                <p class="text-sm text-gray-500">Total Money: <span id="modalTotalMoney" class="price-format"></span></p>
                                                <p class="text-sm text-gray-500">Order Date: <span id="modalOrderDate"></span></p>
                                            </div>
                                            <div class="mt-4">
                                                <table id="detailsTable" class="min-w-full bg-white">
                                                    <thead>
                                                        <tr>
                                                            <th class="py-2">Loại Thẻ</th>
                                                            <th class="py-2">Giá</th>
                                                            <th class="py-2">Số Seri</th>
                                                            <th class="py-2">Mã thẻ</th>
                                                            <th class="py-2">Hạn Sử Dụng</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="modalOrderItems"></tbody>
                                                </table>
                                            </div>
                                            <div class="items-center px-4 py-3">
                                                <button id="closeModalButton" class="px-4 py-2 bg-blue-500 text-white text-base font-medium rounded-md w-full shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-300">
                                                    Close
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
                <!-- Sticky Footer -->
                <%@include file="../user/stickFooter.jsp" %>
            </div>
            <!-- /.content-wrapper -->
        </div>
        <!-- /#wrapper -->
        <!-- Scroll to Top Button-->
        <%@include file="../user/scrollUpToButton.jsp" %>
        <!-- Logout Modal-->
        <%@include file="../user/logOutModal.jsp" %>
        <!-- Bootstrap core JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/bootstrap.bundle.min.js"></script>
        <!-- Core plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.easing.min.js"></script>
        <!-- Page level plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.dataTables.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/dataTables.bootstrap4.js"></script>
        <!-- Custom scripts for all pages-->
        <script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-dataTables-min.js"></script>
        <!-- Demo scripts for this page-->
        <script src="${pageContext.request.contextPath}/assets/js/chart-area-demo.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>
        <!-- Tailwindcss -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
        <script>
                                                                        document.addEventListener("DOMContentLoaded", function () {
                                                                            let priceElements = document.querySelectorAll('.price-format');
                                                                            priceElements.forEach(function (el) {
                                                                                let price = parseFloat(el.innerText);
                                                                                el.innerText = price.toLocaleString('vi-VN', {
                                                                                    style: 'currency',
                                                                                    currency: 'VND'
                                                                                }).replace('₫', '');
                                                                            });
                                                                        });
//                                                                        document.addEventListener("DOMContentLoaded", function () {
//                                                                            let priceElements = document.querySelectorAll('.price-format');
//                                                                            priceElements.forEach(function (el) {
//                                                                                let price = parseFloat(el.innerText);
//                                                                                el.innerText = price.toLocaleString('vi-VN', {
//                                                                                    style: 'currency',
//                                                                                    currency: 'VND'
//                                                                                }).replace('₫', '');
//                                                                            });
//                                                                        });
                                                                        function showOrderDetails(orderNumber, totalMoney, orderDate) {
                                                                            document.getElementById("modalOrderNumber").innerText = orderNumber;
                                                                            document.getElementById("modalTotalMoney").innerText = totalMoney;
                                                                            document.getElementById("modalOrderDate").innerText = orderDate;
                                                                            document.getElementById("orderDetailsModal").classList.remove("hidden");

                                                                            // Gửi AJAX request để lấy chi tiết đơn hàng
                                                                            $.ajax({
                                                                                url: 'UserOrdersServlet',
                                                                                type: 'POST',
                                                                                data: {
                                                                                    action: 'getOrderDetails',
                                                                                    orderId: orderNumber
                                                                                },
                                                                                success: function (response) {
                                                                                    // Xóa bảng hiện tại
                                                                                    $('#detailsTable').DataTable().destroy(); // Hủy DataTable hiện tại
                                                                                    document.getElementById("detailsTable").innerHTML = response;
                                                                                    $('#detailsTable').html(response);
                                                                                    $('#detailsTable').DataTable(); // Khởi tạo lại DataTable với dữ liệu mới
                                                                                },
                                                                                error: function () {
                                                                                    alert('Failed to retrieve order details.');
                                                                                }
                                                                            });
                                                                        }

                                                                        document.getElementById("closeModalButton").onclick = function () {
                                                                            document.getElementById("orderDetailsModal").classList.add("hidden");
                                                                        };
        </script>
    </body>
</html>