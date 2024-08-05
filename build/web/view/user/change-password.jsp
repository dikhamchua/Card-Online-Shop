<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Đổi Mật Khẩu</title>

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
        </style>
        <style>
            .error {
                color: red;
            }
            .success {
                color: green;
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

                        <!-- DataTables Example -->
                        <div class="container-fluid">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-12 text-center">
                                            <h4>Thay đổi mật khẩu</h4>
                                            <hr>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 justify-content-center">
                                            <form class="justify-content-center"
                                                  action="${pageContext.request.contextPath}/dashboard?action=change-password-user"
                                            method="POST" onsubmit="return validateForm(this);">
                                            <!-- Password -->
                                            <div class="form-group justify-content-center row">
                                                <label for="password" class="col-2 col-form-label">Mật khẩu hiện tại</label>
                                                <div class="col-6">
                                                    <input id="password" name="password" placeholder="" class="form-control here"
                                                           type="password" value="" >
                                                </div>
                                            </div>
                                            <!-- New password -->
                                            <div class="form-group justify-content-center row">
                                                <label for="newPassword" class="col-2 col-form-label">Mật khẩu mới</label>
                                                <div class="col-6">
                                                    <input id="newPassword" name="newPassword" placeholder="" class="form-control here"
                                                           type="password" value="" >
                                                </div>
                                            </div>
                                            <!-- Re enter passoword -->
                                            <div class="form-group justify-content-center row">
                                                <label for="newPassword2" class="col-2 col-form-label">Xác nhận mật khẩu</label>
                                                <div class="col-6">
                                                    <input id="newPassword2" name="newPassword2" placeholder=""
                                                           class="form-control here" type="password" value="" >
                                                </div>
                                            </div>
                                            <!--Error-->
                                            <div class="form-group justify-content-center row">
                                                <label for="newPassword" class="col-2 col-form-label"></label>
                                                <div class="col-6">
                                                    <div id="errorDiv" class="error">
                                                        <c:if test="${not empty error}">${error}</c:if>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Success -->
                                            <div class="form-group justify-content-center row">
                                                <label for="newPassword" class="col-2 col-form-label"></label>
                                                <div class="col-6">
                                                    <div id="successDiv" class="success">
                                                        <c:if test="${not empty successMessage}">${successMessage}</c:if>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group justify-content-center row">
                                                <div class="offset-4 col-8">
                                                    <button name="submit" type="submit" class="btn btn-primary">Lưu thông tin</button>
                                                </div>
                                            </div>
                                        </form>
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
            </div>
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

        <script>
                                                function validateForm(button) {
                                                    var newPassword = document.getElementById("newPassword").value;
                                                    var newPassword2 = document.getElementById("newPassword2").value;
                                                    var errorDiv = document.getElementById("errorDiv");

                                                    // Kiểm tra xem tất cả các trường đã được nhập hay chưa
                                                    if (!newPassword || !newPassword2) {
                                                        errorDiv.textContent = "Vui lòng nhập tất cả các mật khẩu.";
                                                        return false; // Ngăn form được submit
                                                    }

                                                    // Kiểm tra xem mật khẩu mới và nhập lại mật khẩu có khớp nhau hay không
                                                    if (newPassword !== newPassword2) {
                                                        errorDiv.textContent = "Mật khẩu mới và nhập lại mật khẩu không khớp.";
                                                        return false; // Ngăn form được submit
                                                    }

                                                    // Nếu tất cả điều kiện kiểm tra đều ổn, cho phép form được submit
                                                    errorDiv.textContent = ""; // Xóa thông báo lỗi nếu có
                                                    return true;
                                                }
        </script>

    </body>

</html>