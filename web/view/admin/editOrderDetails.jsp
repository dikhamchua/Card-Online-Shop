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

        <title>Chi tiết đơn hàng</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">


        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/colReorder-bootstrap4.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/switch-button.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <style>
            .error {
                color: red;
            }
        </style>
    </head>

    <body id="page-top">
        <jsp:include page="navigationBar.jsp"></jsp:include>

            <div id="wrapper">

                <!-- Sidebar -->
            <jsp:include page="sideBar.jsp"></jsp:include>

                <div id="content-wrapper">

                    <div class="container-fluid">

                        <!-- Breadcrumbs-->
                    <jsp:include page="breadCumb.jsp"></jsp:include>

                        <div class="card mb-3">
                            <div class="card-header">
                                <i class="fas fa-table"></i>
                                Chi tiết đơn hàng đã đặt
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th style="width: 3%;">STT</th>
                                                <th style="width: 12%;">Tên sản phẩm</th>
                                                <th style="width: 15%;">Mức giá</th>
                                                <th style="width: 8%;">Số lượng</th>
                                                <th style="width: 33%;">Tổng tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${listOrderDetails}" var="od" varStatus="status">
                                            <c:set var = "card" value ="" />
                                            <c:set var = "cardtypePrice" value ="" />
                                            <c:set var = "cardtype" value ="" />
                                            <c:set var = "price" value ="" />

                                            <c:forEach items="${listCards}" var="c">
                                                <c:if test="${c.getID() == od.getCardID() }">
                                                    <c:set var="card" value="${c}" />
                                                </c:if>
                                            </c:forEach>

                                            <c:forEach items="${listCardType_Prices}" var="ctp">
                                                <c:if test="${card.getCardType_Price() == ctp.getID()}">
                                                    <c:set var="cardtypePrice" value="${ctp}" />
                                                </c:if>
                                            </c:forEach>

                                            <c:forEach items="${listCardTypes}" var="ct">
                                                <c:if test="${ct.getID() == cardtypePrice.getCardTypeID()}">
                                                    <c:set var="cardtype" value="${ct}" />
                                                </c:if>
                                            </c:forEach>

                                            <c:forEach items ="${listPrice}" var ="p">
                                                <c:if test="${p.getID() == cardtypePrice.getPriceID()}">
                                                    <c:set var="price" value="${p}" />
                                                </c:if>
                                            </c:forEach>
                                            <tr>
                                                <!-- No -->
                                                <td>${status.index + 1}</td>
                                                <!-- Tên sản phẩm -->
                                                <td>${cardtype.getCardTypeName()}</td>
                                                <!-- Giá cả -->
                                                <td class="price-format">${price.getPrice()}đ</td>
                                                <!-- Số lượng -->
                                                <td>${od.getQuantity()}</td>
                                                <!-- Tổng tiền -->
                                                <td class="price-format">${price.getPrice() * od.getQuantity()}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody> 
                                </table>
                                <div class="row">
                                    <div class="col-12 d-flex justify-content-center">
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination">
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
<!--                                                    <a class="page-link" href="${pageContext.request.contextPath}/dashboardOrder?page=${currentPage > 1 ? currentPage - 1 : 1 }&keyword=${param.keyword}&action=${param.action}" aria-label="Previous">-->
                                                    <a class="page-link" href="${pageControl.urlPattern}&page=${pageControl.page - 1}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                        <span class="sr-only">Previous</span>
                                                    </a>
                                                </li>
                                                <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                                                    <li class="page-item ${currentPage == pageNumber ? 'active' : ''}">
                                                        <a class="page-link" href="${pageControl.urlPattern}&page=${pageControl.page}">${pageNumber}</a>
                                                    </li>
                                                </c:forEach>
                                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <a class="page-link" href="${pageControl.urlPattern}&page=${pageControl.page + 1}" aria-label="Next">
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

            </div>
            <!-- /.container-fluid -->

            <!-- Sticky Footer -->
            <jsp:include page="stickFooter.jsp"></jsp:include>


            </div>
            <!-- /.content-wrapper -->

            <!-- /#wrapper -->

            <!-- Scroll to Top Button-->
        <jsp:include page="scrollUpToButton.jsp"></jsp:include>


            <!-- Logout Modal-->
        <jsp:include page="logOutModal.jsp"></jsp:include>
        <jsp:include page="editCategoryModal.jsp"></jsp:include>
        <jsp:include page="addCategoryModal.jsp"></jsp:include>
        <jsp:include page="deleteCategoryModal.jsp"></jsp:include>

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