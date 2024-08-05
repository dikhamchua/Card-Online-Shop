<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Quản lý đơn hàng</title>
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }

            .error {
                color: red;
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
                            <a href="#">Quản lý đơn hàng</a>
                        </li>
                    </ol>
                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-table"></i>
                            Đơn hàng
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Mã đơn hàng</th>
                                            <th>Tên khách hàng</th>
                                            <th>Giá tiền</th>
                                            <th>Chi tiết đơn hàng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${ListOrders}" var="c" varStatus="status">
                                            <tr>
                                                <td name="OrderID">${c.getID()}</td>
                                                <c:forEach items="${ListUsers}" var="obj">
                                                    <c:if test="${obj.getID() == c.getUserID()}">
                                                        <td name="UserID">${obj.getUserName()}</td>
                                                    </c:if>
                                                </c:forEach>
                                                <td class="price-format">${c.getTotalMoney()}</td>
                                                <td>
                                                    <a href="dashboardOrder?action=detailsOrder&OrderID=${c.getID()}" class="btn btn-primary" style="margin-right: 5px;">Chi tiết</a>
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
                                            <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                                <a class="page-link" href="${pageContext.request.contextPath}/dashboardOrder?page=${currentPage - 1}&keyword=${param.keyword}&action=${param.action}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <li class="page-item <c:if test="${currentPage == 1}">active</c:if>">
                                                    <a class="page-link" href="?page=1">1</a>
                                                </li>
                                            <c:if test="${beginPage > 2}">
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                                </c:if>
                                                <c:forEach begin="${beginPage}" end="${endPage}" var="i">
                                                    <c:if test="${i > 1 && i < totalPages}">
                                                    <li class="page-item <c:if test="${currentPage == i}">active</c:if>">
                                                        <a class="page-link" href="?page=${i}">${i}</a>
                                                    </li>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${endPage < totalPages - 1}">
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                                </c:if>
                                            <li class="page-item <c:if test="${currentPage == totalPages}">active</c:if>">
                                                <a class="page-link" href="?page=${totalPages}">${totalPages}</a>
                                            </li>
                                            <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                <a class="page-link" href="${pageContext.request.contextPath}/dashboardOrder?page=${currentPage + 1}&keyword=${param.keyword}&action=${param.action}" aria-label="Next">
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
        <script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>
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
        </script>
    </body>

</html>
