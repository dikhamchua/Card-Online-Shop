<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Quản Lý Yêu Cầu Hỗ Trợ</title>
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/colReorder-bootstrap4.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/switch-button.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
            .table-responsive {
                margin: 20px 0;
            }
        </style>
    </head>
    <body id="page-top">
        <jsp:include page="navigationBar.jsp"></jsp:include>
            <div id="wrapper">
            <jsp:include page="sideBar.jsp"></jsp:include>
                <div id="content-wrapper">
                    <div class="container-fluid">
                        <h1 class="h3 mb-2 text-gray-800">Quản Lý Yêu Cầu Hỗ Trợ</h1>
                        <div class="card mb-3">
                            <div class="card-header">
                                <i class="fas fa-table"></i>
                                Danh Sách Yêu Cầu Hỗ Trợ
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Tên</th>
                                                <th>Điện Thoại</th>
                                                <th>Email</th>
                                                <th>Vấn Đề</th>
                                                <th>Ngày Gửi</th>
                                                <th>Trạng Thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${feedbackList}" var="feedback" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td>${feedback.name}</td>
                                                <td>${feedback.phone}</td>
                                                <td>${feedback.email}</td>
                                                <td>${feedback.message}</td>
                                                <td>${feedback.created_at}</td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/admin/manageFeedbacks" method="post">
                                                        <input type="hidden" name="feedbackId" value="${feedback.id}">
                                                        <c:choose>
                                                            <c:when test="${feedback.isIs_resolved()}">
                                                                <button type="submit" class="btn btn-success" disabled>Đã Xử Lý</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="submit" class="btn btn-success"> Đang Xử Lý</button>
                                                            </c:otherwise>
                                                        </c:choose>
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
                <jsp:include page="stickFooter.jsp"></jsp:include>
                </div>
            </div>
        <jsp:include page="scrollUpToButton.jsp"></jsp:include>
        <jsp:include page="logOutModal.jsp"></jsp:include>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/Chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $('.table').DataTable({
                    "paging": true,
                    "searching": true,
                    "ordering": false,
                    "info": true,
                    "autoWidth": false,
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.11.5/i18n/vi.json"
                    }
                });
            });
        </script>

    </body>
</html>