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

        <title>Bảng Điều Khiển</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">

        <!-- Page level plugin CSS-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/dataTables.bootstrap4.css" rel="stylesheet">

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
                                Data Table Example
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th style="width: 3%;">STT</th>
                                                <th style="width: 12%;">Tên sản phẩm</th>
                                                <th style="width: 22%;">Hình ảnh</th>
                                                <th style="width: 15%;">Giá cả</th>
                                                <th style="width: 8%;">Số lượng</th>
                                                <th style="width: 33%;">Tổng tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${listOrderDetails}" var="obj" varStatus="status">
                                            <c:forEach items="${listProduct}" var="product">
                                                <c:if test="${obj.productId == product.productID}">
                                                    <c:set var="o" value="${product}"></c:set>
                                                </c:if>
                                            </c:forEach>
                                            <tr>
                                                <!--No-->
                                                <td>${status.index + 1}</td>
                                                <!--Tên sản phẩm-->
                                                <td>
                                                    ${o.productName}
                                                </td>
                                                <!--Hình ảnh-->
                                                <td>
                                                    <img class="img-fluid rounded" src="${o.image}" name="image">
                                                </td>
                                                <!--Giá cả-->
                                                <td>
                                                    ${o.price}đ   
                                                </td>
                                                <!--Số lượng-->
                                                <td >
                                                    ${obj.quantity}
                                                </td>
                                                <!--Tổng tiền-->
                                                <td>
                                                    ${o.price * obj.quantity}đ
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
