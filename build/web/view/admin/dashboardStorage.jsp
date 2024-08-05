<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý số lượng sản phẩm</title>
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
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
                            <a href="#">Quản lý số lượng sản phẩm</a>
                        </li>
                    </ol>
                    <nav class="navbar navbar-light bg-light">
                        <form class="form-inline" action="${pageContext.request.contextPath}/dashboardStorage" method="GET">
                            <select class="custom-select my-1 mr-sm-2" name="searchName">
                                <option value="">Chọn tên...</option>
                                <option value="viettel" ${param.searchName == 'viettel' ? 'selected' : ''}>Viettel</option>
                                <option value="mobifone" ${param.searchName == 'mobifone' ? 'selected' : ''}>Mobifone</option>
                                <option value="vietnamobile" ${param.searchName == 'vietnamobile' ? 'selected' : ''}>Vietnamobile</option>
                                <option value="vinaphone" ${param.searchName == 'vinaphone' ? 'selected' : ''}>Vinaphone</option>
                                <option value="garena" ${param.searchName == 'garena' ? 'selected' : ''}>Garena</option>
                                <option value="zing" ${param.searchName == 'zing' ? 'selected' : ''}>Zing</option>
                                <option value="vcoin" ${param.searchName == 'vcoin' ? 'selected' : ''}>Vcoin</option>
                                <option value="gate" ${param.searchName == 'gate' ? 'selected' : ''}>Gate</option>
                            </select>
                            <select class="custom-select my-1 mr-sm-2" name="searchValue">
                                <option value="">Chọn mệnh giá...</option>
                                <option value="10000" ${param.searchValue == '10000' ? 'selected' : ''}>10000</option>
                                <option value="20000" ${param.searchValue == '20000' ? 'selected' : ''}>20000</option>
                                <option value="50000" ${param.searchValue == '50000' ? 'selected' : ''}>50000</option>
                                <option value="100000" ${param.searchValue == '100000' ? 'selected' : ''}>100000</option>
                                <option value="200000" ${param.searchValue == '200000' ? 'selected' : ''}>200000</option>
                                <option value="300000" ${param.searchValue == '300000' ? 'selected' : ''}>300000</option>
                                <option value="500000" ${param.searchValue == '500000' ? 'selected' : ''}>500000</option>
                                <option value="1000000" ${param.searchValue == '1000000' ? 'selected' : ''}>1000000</option>
                            </select>
                            <input type="hidden" name="action" value="filter">
                            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Lọc</button>
                        </form>
                    </nav>
                    <nav class="navbar navbar-light bg-light">
                        <form class="form-inline" action="${pageContext.request.contextPath}/dashboardStorage" method="GET">
                            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="keyword" value="${param.keyword}">
                            <input type="hidden" name="action" value="search">
                            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Tìm kiếm</button>
                        </form>
                    </nav>
                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-table"></i>
                            Các loại thẻ
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên loại thẻ</th>
                                            <th>Mệnh giá</th>
                                            <th>Số lượng còn lại</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listCardTypesPrice}" var="c">
                                            <tr>
                                                <td name="CardTypeID">${c.getCardTypeID()}</td>
                                                <c:forEach items="${listCardTypes}" var="obj">
                                                    <c:if test="${obj.getID() == c.getCardTypeID()}">
                                                        <td name="CardTypeName">${obj.getCardTypeName()}</td>
                                                    </c:if>
                                                </c:forEach>
                                                <c:forEach items="${listPrice}" var="ab">
                                                    <c:if test="${ab.getID() == c.getPriceID()}">
                                                        <td name="Price" class="price-format">${ab.getPrice()}</td>
                                                    </c:if>
                                                </c:forEach>
                                                <td name="Quantity">${quantityMap[c.getID()]}</td>
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
                                                <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
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
                                                <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
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
                    el.innerText = price.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'}).replace('₫', '');
                });
            });
        </script>
    </body>
</html>
