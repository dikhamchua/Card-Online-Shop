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

        <title>Quản Lý</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">

        <!-- Page level plugin CSS-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/dataTables.bootstrap4.css" rel="stylesheet">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
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
                    <jsp:include page="breadCumbOrder.jsp"></jsp:include>

                        <div class="card mb-3">
                            <div class="card-header">
                                <i class="fas fa-table"></i>
                                Order
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th style="width: 3%;">STT</th>
                                                <th style="width: 12%;">Tên tài khoản</th>
                                                <th style="width: 15%;">Mã vận đơn</th>
                                                <th style="width: 8%;">Tổng Tiền</th>
                                                <th style="width: 33%;">Thời gian mua hàng</th>
                                                <th style="width: 22%;">Hoạt động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${listOrder}" var="order" varStatus="status">
                                            <tr>
                                                <!--No-->
                                                <td>${status.index + 1}</td>
                                                <!--Tên tài khoản-->
                                                <td>
                                                    <c:forEach items="${listAccount}" var="u">
                                                        <c:if test="${u.id == order.accountId}">
                                                            ${u.customerName}
                                                        </c:if>
                                                    </c:forEach>
                                                </td>
                                                <!--Mã vận đơn-->
                                                <td>${order.id}</td>
                                                <!--Tổng Tiền-->
                                                <td name="quantity">${order.amount} VND</td>
                                                <!--Thời gian mua hàng-->
                                                <td >
                                                    <p class="mb-0">
                                                        ${order.getCreateAt()}
                                                    </p>
                                                </td>
                                                <!--Hoạt động-->
                                                <td>
                                                    <form action="orders?action=detailsOrder" method="POST">
                                                        <input type="hidden" name="orderId" value="${order.id}">
                                                        <a href="#" class="btn btn-primary" onclick="return this.closest('form').submit();" style="margin-right: 5px;">Chi tiết</a>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
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

            <!--Add product modal-->
        <jsp:include page="addPRoductModal.jsp"></jsp:include>

            <!--Delete product modal-->
        <jsp:include page="deleteProductModal.jsp"></jsp:include>

            <!--Edit Product Modal-->
        <jsp:include page="editProductModal.jsp"></jsp:include>

            <!-- Bootstrap core JavaScript-->
            <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.easing.min.js"></script>

        <!-- Page level plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/css/vendor/Chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.dataTables.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/dataTables.bootstrap4.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-dataTables-min.js"></script>

        <!-- Demo scripts for this page-->
        <script src="${pageContext.request.contextPath}/assets/js/datatables-demo.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/chart-area-demo.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-dataTables-min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>


    </body>

</html>
