<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Quản lý đánh giá của người dùng</title>
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
        <!-- DataTables CSS -->
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap4.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }

            .error {
                color: red;
            }

            .dataTables_wrapper .dataTables_paginate .paginate_button {
                padding: 0.1em 0.4em; /* Adjust padding for smaller pagination */
                margin: 0.2em;
                font-size: 0.875em; /* Adjust font size for smaller pagination */
            }

            .dataTables_wrapper .dataTables_filter {
                text-align: left; /* Align search to the left */
            }

            .dataTables_wrapper .dataTables_paginate {
                float: right; /* Align pagination to the right */
                padding-top: 0.25em;
            }

            /* Adjust column widths */
            .table thead th.review-content,
            .table tbody td.review-content {
                width: 45%; /* Adjust the width as needed */
            }
        </style>
    </head>

    <body id="page-top">
        <jsp:include page="navigationBar.jsp" />
        <div id="wrapper">
            <jsp:include page="sideBar.jsp" />
            <div id="content-wrapper">
                <div class="container-fluid">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="#">Quản lý đánh giá</a>
                        </li>
                    </ol>
                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-table"></i>
                            Đánh giá
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-sm" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Tên người dùng</th>
                                            <th>Mã đơn hàng</th>
                                            <th class="review-content">Nội dung đánh giá</th>
                                            <th>Số sao</th>
                                            <th>Thời gian</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="review" items="${reviews}" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td>${userNamesMap[review.userID]}</td>
                                                <td>${review.orderID}</td>
                                                <td class="review-content">${review.title}</td>
                                                <td>${review.rating}</td>
                                                <td class="px-4 py-2 text-center">
                                                    <fmt:parseDate value="${review.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                                    <fmt:formatDate pattern="dd/MM/yyyy HH:mm:ss" value="${parsedDateTime}" />
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="stickFooter.jsp" />
            </div>
        </div>
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>
        <jsp:include page="logOutModal.jsp" />
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/Chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.dataTables.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "pagingType": "simple_numbers", // Use simple pagination
                    "pageLength": 5, // Set default page length
                    "ordering": false, // Disable sorting for all columns
                    "dom": 'ftip', // Hide length menu and information text
                    "language": {
                        "search": "Tìm kiếm:",
                        "paginate": {
                            "previous": "Trước",
                            "next": "Sau"
                        }
                    }
                });
            });
        </script>
    </body>

</html>