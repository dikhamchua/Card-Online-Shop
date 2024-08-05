<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Chi tiết giao dịch</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
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

            .error {
                color: red;
            }
        </style>

        <!-- DataTables CSS -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.css">
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
                                <a href="#">Chi tiết giao dịch</a>
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
                                                <th width="33%">Giá tiền</th>
                                                <th>Ngày nạp</th>
                                                <th>Ghi Chú</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${requestScope.list}" var="item" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td class="<c:choose><c:when test="${item.amount >= 0}">text-green-500</c:when><c:otherwise>text-red-500</c:otherwise></c:choose>">
                                                    <c:choose>
                                                        <c:when test="${item.amount >= 0}">
                                                            +<fmt:formatNumber value="${item.amount}" minFractionDigits="0" /> <i class="fas fa-arrow-up transaction-icon"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${item.amount}" minFractionDigits="0" /> <i class="fas fa-arrow-down transaction-icon"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="px-4 py-2 text-center">
                                                    <span class="date-formatter" data-date="${item.createdAt}"></span>
                                                </td>
                                                <td class="px-4 py-2 text-center">
                                                    ${item.status}
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <!-- Pagination -->
                                <div class="row">
                                    <div class="col-12 d-flex justify-content-center">
                                        <a href="transactionHistory?action=viewTransaction&userId=${requestScope.userId}" class="btn btn-secondary mt-4">Quay lại</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sticky Footer -->
            <jsp:include page="stickFooter.jsp"></jsp:include>

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

        <!-- DataTables JavaScript -->
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>

        <!-- Demo scripts for this page-->
        <script src="${pageContext.request.contextPath}/assets/js/chart-area-demo.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>

        <!-- Custom JavaScript for date formatting-->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const dateElements = document.querySelectorAll('.date-formatter');
                dateElements.forEach(function (element) {
                    const date = new Date(element.getAttribute('data-date'));
                    const formattedDate = date.toLocaleDateString('vi-VN', {
                        day: '2-digit',
                        month: '2-digit',
                        year: 'numeric'
                    }) + ' ' + date.toLocaleTimeString('vi-VN', {
                        hour: '2-digit',
                        minute: '2-digit',
                        second: '2-digit'
                    });
                    element.textContent = formattedDate;
                });

                // Initialize DataTable
                $('#dataTable').DataTable({
                    "pagingType": "full_numbers",
                    "lengthMenu": [5, 10, 25, 50, 75, 100],
                    "pageLength": 5,
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.11.3/i18n/vi.json"
                    }
                });
            });
        </script>
    </body>

</html>
