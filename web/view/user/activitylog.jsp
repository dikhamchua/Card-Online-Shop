<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Lịch sử hoạt động</title>

    <!-- Custom fonts for this template-->
    <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/vendor/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/colReorder-bootstrap4.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Be Vietnam Pro', sans-serif !important;
        }
        .table {
            margin-top: 20px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body id="page-top">
    <%@include file="navigationBar.jsp" %>

    <div id="wrapper">
        <!-- Sidebar -->
        <%@include file="sideBar.jsp" %>

        <div id="content-wrapper">
            <div class="container-fluid">
                <!-- Breadcrumbs-->
                <%@include file="breadCumb.jsp" %>

                <h1 class="mt-4">Lịch sử hoạt động của bạn</h1>
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-history"></i>
                        Lịch sử hoạt động
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Hoạt động</th>
                                        <th>Chi tiết</th>
                                        <th>Thời gian</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="log" items="${activityLogs}">
                                        <tr>
                                            <td>${log.id}</td>
                                            <td>${log.action}</td>
                                            <td>${log.details}</td>
                                            <td>${log.timestamp}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- Sticky Footer -->
                <%@include file="stickFooter.jsp" %>
            </div>
            <!-- /.content-wrapper -->
        </div>
        <!-- /#wrapper -->

        <!-- Scroll to Top Button-->
        <%@include file="scrollUpToButton.jsp" %>

        <!-- Logout Modal-->
        <%@include file="logOutModal.jsp" %>

        <!--Add product modal-->
        <%@include file="addPRoductModal.jsp" %>

        <!--Delete product modal-->
        <%@include file="deleteProductModal.jsp" %>

        <!--Edit Product Modal-->
        <%@include file="editProductModal.jsp" %>

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
        <script src="${pageContext.request.contextPath}/assets/js/datatables-demo.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/chart-area-demo.js"></script>
    </div>
</body>
</html>
