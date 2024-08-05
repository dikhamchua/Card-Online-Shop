<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Quản Lí Phiếu Giảm Giá</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/colReorder-bootstrap4.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/switch-button.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
        </style>
        <style>
            .error {
                color: red;
            }
        </style>

    </head>

    <body id="page-top">

        <!--Navbar-->
        <jsp:include page="navigationBar.jsp"></jsp:include>

            <div id="wrapper">

                <!-- Sidebar -->
            <jsp:include page="sideBar.jsp"></jsp:include>

                <div id="content-wrapper">

                    <div class="container-fluid">

                        <!-- Breadcrumbs-->
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="#">Quản lý phiếu giảm giá</a>
                            </li>
                            <li class="breadcrumb-item ml-auto">
                                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addCouponModal">
                                    Thêm phiếu giảm giá
                                </button>
                            </li>
                        </ol>
                        <!-- Search-->
                        <nav class="navbar navbar-light bg-light">
                            <form class="form-inline" action="${pageContext.request.contextPath}/dashboardCoupon" method="GET">
                            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search"
                                   name="keyword" value="${param.keyword}">
                            <input type="hidden" name="action" value="search">
                            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Tìm kiếm</button>
                        </form>
                    </nav>

                    <!-- DataTables Example -->
                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-table"></i>
                            Các loại phiếu giảm giá
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th width="5%">ID</th>
                                            <th width="10%">Tên chương trình giảm giá</th>
                                            <th width="10%">Mã phiếu giảm giá</th>
                                            <th width="10%">Giá trị phiếu giảm giá(%)</th>
                                            <th width="8%">Số lần sử dụng</th> 
                                            <th width="15%">Chỉnh sửa</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listCoupon}" var="c">
                                            <tr>
                                                <td name="id">${c.getID()}</td>
                                                <c:forEach items="${listCouponType}" var="ct">
                                                    <c:if test="${c.getCouponTypeID() == ct.getID()}">
                                                        <td name="couponname">${ct.getCouponTypeName()}</td>
                                                    </c:if>
                                                </c:forEach>
                                                <td name="code">${c.getCouponCode()}</td>
                                                <td name="amount">${c.getCouponAmount()}</td>
                                                <td name="usageCount">${c.getUsageCount()}</td> 
                                                <td>
                                                    <button type="button" class="btn btn-primary" data-toggle="modal"
                                                            data-target="#editCouponModal" onclick="editCouponModal(this)">
                                                        Sửa
                                                    </button>
                                                    <button type="button" class="btn btn-danger" data-toggle="modal"
                                                            data-target="#deleteCouponModal" onclick="deleteCouponModal(this)">
                                                        Xóa
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- Pagination -->
                            <div class="row">
                                <div class="col-12 d-flex justify-content-center">
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="${pageContext.request.contextPath}/dashboardCoupon?page=${currentPage > 1 ? currentPage - 1 : 1}"
                                                   aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                    <span class="sr-only">Previous</span>
                                                </a>
                                            </li>
                                            <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                                                <li class="page-item ${currentPage == pageNumber ? 'active' : ''}">
                                                    <a class="page-link"
                                                       href="${pageContext.request.contextPath}/dashboardCoupon?page=${pageNumber}">${pageNumber}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="${pageContext.request.contextPath}/dashboardCoupon?page=${currentPage < totalPages ? currentPage + 1 : totalPages}"
                                                   aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                    <span class="sr-only">Next</span>
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

            </div>

        <jsp:include page="logOutModal.jsp"></jsp:include>
        <jsp:include page="editCouponModal.jsp"></jsp:include>
        <jsp:include page="addCouponModal.jsp"></jsp:include>
        <jsp:include page="deleteCouponModal.jsp"></jsp:include>

            <!-- Bootstrap core JavaScript-->
            <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.easing.min.js"></script>

        <!-- Page level plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/css/vendor/Chart.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>

        <!-- Demo scripts for this page-->
        <script src="${pageContext.request.contextPath}/assets/js/chart-area-demo.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>
        <!-- Ajax for pagination-->
        <script>
                                                                $(document).ready(function () {
                                                                    $('.pagination a').on('click', function (e) {
                                                                        e.preventDefault();
                                                                        var pageUrl = $(this).attr('href');

                                                                        $.get(pageUrl, function (data) {
                                                                            var newHtml = $(data).find('.table-responsive').html();
                                                                            $('.table-responsive').html(newHtml);

                                                                            // Đánh dấu số trang hiện tại với lớp CSS mới
                                                                            $('.pagination li').removeClass('active');
                                                                            $(this).parent().addClass('active-page'); // Chỉnh sửa tên lớp thành 'active-page' để sử dụng màu xanh
                                                                        });
                                                                    });
                                                                });
        </script>

    </body>

</html>
