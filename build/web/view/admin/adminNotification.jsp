<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Thông báo Quản trị</title>
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/colReorder-bootstrap4.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
            .container {
                margin-top: 50px;
            }
            #successMessage, #errorMessage {
                display: none;
            }
            .pagination {
                justify-content: center;
            }
            #notificationFormDiv {
                display: none;
                margin-top: 20px;
            }
        </style>
    </head>
    <body id="page-top">
        <jsp:include page="navigationBar.jsp" />
        <div id="wrapper">
            <jsp:include page="sideBar.jsp" />
            <div id="content-wrapper">
                <div class="container-fluid">
                    <jsp:include page="breadCumb.jsp" />
                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-bell"></i>
                            Thông báo
                            <button class="btn btn-primary float-right" id="showForm">Tạo thông báo mới</button>
                        </div>
                        <div class="card-body">
                            <div id="notificationFormDiv">
                                <h3>Tạo thông báo mới</h3>
                                <form id="notificationForm">
                                    <div class="form-group">
                                        <label for="message">Nội dung thông báo:</label>
                                        <textarea class="form-control" id="message" name="message" rows="3" required></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="userId">ID người dùng (để trống để thông báo cho tất cả người dùng):</label>
                                        <input type="text" class="form-control" id="userId" name="userId">
                                    </div>
                                    <button type="submit" class="btn btn-primary">Gửi thông báo</button>
                                </form>
                            </div>
                            <div id="successMessage" class="alert alert-success mt-3">Thông báo đã được gửi thành công!</div>
                            <div id="errorMessage" class="alert alert-danger mt-3">Lỗi khi gửi thông báo.</div>
                            <div class="table-responsive mt-3">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Nội dung</th>
                                            <th>Ngày tạo</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="notification" items="${notifications}">
                                            <tr>
                                                <td>${notification.message}</td>
                                                <td>${notification.createdAt}</td>
                                                <td>
                                                    <button class="btn btn-danger deleteNotification" data-id="${notification.notificationId}">Xóa</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <nav>
                                <ul class="pagination">
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/notifications?page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
                <jsp:include page="stickFooter.jsp" />
            </div>
        </div>
        <jsp:include page="../user/scrollUpToButton.jsp" />
        <jsp:include page="../user/logOutModal.jsp" />
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.easing.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#showForm').click(function () {
                    $('#notificationFormDiv').toggle();
                });

                $('#notificationForm').on('submit', function (event) {
                    event.preventDefault();
                    var formData = {
                        message: $('#message').val(),
                        userId: $('#userId').val()
                    };

                    $.ajax({
                        url: '${pageContext.request.contextPath}/admin/notifyUsers',
                        type: 'POST',
                        data: formData,
                        success: function (response) {
                            $('#successMessage').show().delay(3000).fadeOut();
                            $('#notificationForm')[0].reset();
                            location.reload();
                        },
                        error: function (xhr, status, error) {
                            $('#errorMessage').show().delay(3000).fadeOut();
                        }
                    });
                });

                $('.deleteNotification').click(function () {
                    var notificationId = $(this).data('id');
                    $.ajax({
                        url: '${pageContext.request.contextPath}/admin/deleteNotification',
                        type: 'POST',
                        data: {notificationId: notificationId},
                        success: function (response) {
                            location.reload();
                        },
                        error: function (xhr, status, error) {
                            $('#errorMessage').show().delay(3000).fadeOut();
                        }
                    });
                });
            });
        </script>
    </body>
</html>
