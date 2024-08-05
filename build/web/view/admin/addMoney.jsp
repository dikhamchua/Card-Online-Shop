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
        <title>Thêm/Trừ Tiền Người Dùng</title>
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">

        <!-- Custom styles for this template-->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
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

            .container-fluid {
                max-width: 800px;
                margin-top: 20px;
            }

            .btn-submit {
                background-color: #28a745;
                color: white;
            }

            .btn-submit:hover {
                background-color: #218838;
            }
        </style>
    </head>

    <body id="page-top">
        <!-- Navbar-->
        <jsp:include page="navigationBar.jsp"></jsp:include>
            <div id="wrapper">
                <!-- Sidebar -->
            <jsp:include page="sideBar.jsp"></jsp:include>
                <div id="content-wrapper">
                    <div class="container-fluid">
                        <!-- Breadcrumbs-->
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/admin/addMoney"> Thêm/Trừ Tiền Người Dùng</a>
                        </li>
                    </ol>
                    <!-- Page Content -->
                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-money-bill-wave"></i>
                            Thêm/Trừ Tiền Người Dùng
                        </div>
                        <div class="card-body">
                            <form action="./addMoney" method="get" id="searchForm">
                                <div class="form-group">
                                    <label for="searchQuery">Tìm Kiếm Người Dùng:</label>
                                    <input type="text" id="searchQuery" name="searchQuery" class="form-control">
                                </div>
                                <button type="submit" class="btn btn-primary">Tìm Kiếm</button>
                            </form>
                            <form action="./addMoney" method="post" id="addMoneyForm">
                                <div class="form-group">
                                    <label for="userId">Chọn Người Dùng:</label>
                                    <select id="userId" name="userId" class="form-control" required>
                                        <c:choose>
                                            <c:when test="${not empty userList}">
                                                <c:forEach var="user" items="${userList}">
                                                    <option value="${user.ID}">${user.userName}</option>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <option disabled>Không có người dùng nào</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="total">Số Tiền:</label>
                                    <input type="number" id="total" name="total" class="form-control" step="1" min="5000" max="500000000" required>
                                </div>
                                <div class="form-group">
                                    <label for="action">Thao Tác:</label>
                                    <select id="action" name="action" class="form-control" required>
                                        <option value="add">Thêm Tiền</option>
                                        <option value="subtract">Trừ Tiền</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-submit">Xác Nhận</button>
                            </form>
                            <c:if test="${param.success != null}">
                                <c:choose>
                                    <c:when test="${param.success == 'add'}">
                                        <p class="text-success mt-2">Thêm tiền thành công!</p>
                                    </c:when>
                                    <c:when test="${param.success == 'subtract'}">
                                        <p class="text-success mt-2">Trừ tiền thành công!</p>
                                    </c:when>
                                </c:choose>
                            </c:if>
                            <c:if test="${param.error != null}">
                                <p class="error mt-2">${param.error}</p>
                            </c:if>
                            <c:if test="${noUserFound}">
                                <script>
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Không tồn tại người dùng này',
                                        text: 'Vui lòng thử lại với từ khóa khác',
                                    });
                                </script>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.content-wrapper -->
        <!-- Sticky Footer -->
        <jsp:include page="stickFooter.jsp"></jsp:include>
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
        <!-- Custom scripts for all pages-->
        <script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>
        <script>
                                    document.getElementById('addMoneyForm').addEventListener('submit', function (event) {
                                        var total = document.getElementById('total').value;
                                        if (total < 5000 || total > 500000000) {
                                            event.preventDefault();
                                            alert('Số tiền phải nằm trong khoảng từ 5,000 VND đến 500,000,000 VND.');
                                        }
                                    });
        </script>
    </body>

</html>