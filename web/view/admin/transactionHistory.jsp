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

        <title>Lịch sử giao dịch</title>

        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">

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
            .error{
                color:red;
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
                                <a href="#">Lịch sử giao dịch</a>
                            </li>
                        </ol>

                        <!-- DataTables Example -->
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th width="20%">STT</th>
                                                <th width="33%">Tài khoản</th>
                                                <th>Số dư tài khoản</th>
                                                <th>Chi tiết giao dịch</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${listTransactions}" var="w" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <c:forEach items="${listAccount}" var="ac">
                                                    <c:if test="${w.getUserID() == ac.getID()}">
                                                        <td name="username">${ac.getUserName()}</td>
                                                    </c:if>
                                                </c:forEach>
                                                <td name="totalMoney" class="price-format">${w.getWallet()}</td>
                                                <td>
                                                    <a href="transactionHistory?action=detailTransaction&userId=${w.getUserID()}" class="btn btn-primary" style="margin-right: 5px;">Chi tiết</a>
                                                </td>


                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <!-- Pagination -->
                                <div class="row">
                                    <div class="col-12 d-flex justify-content-center">
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination">
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/transactionHistory?page=${currentPage > 1 ? currentPage - 1 : 1 }&keyword=${param.keyword}&action=${param.action}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                        <span class="sr-only">Previous</span>
                                                    </a>
                                                </li>
                                                <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                                                    <li class="page-item ${currentPage == pageNumber ? 'active' : ''}">
                                                        <a class="page-link" href="${pageContext.request.contextPath}/transactionHistory?page=${pageNumber}&keyword=${param.keyword}&action=${param.action}">${pageNumber}</a>
                                                    </li>
                                                </c:forEach>
                                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/transactionHistory?page=${currentPage < totalPages ? currentPage + 1 : totalPages}&keyword=${param.keyword}&action=${param.action}" aria-label="Next">
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
                    </div><!--

                    <!-- Sticky Footer -->
                    <jsp:include page="stickFooter.jsp"></jsp:include>

                    </div>
                    <!-- /.content-wrapper -->

                </div>
                <!-- /#wrapper -->

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