<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Thông báo</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">

        <!-- Page level plugin CSS-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/dataTables.bootstrap4.css" rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/colReorder-bootstrap4.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">

        <style>
            table {
                width: 100%;
                margin: auto;
                text-align: center;
                border-collapse: collapse;
            }

            th,
            td {
                padding: 10px;
                border: 1px solid #ddd;
            }

            .read-notification {
                background-color: lightgrey;
            }

            .hidden {
                display: none;
            }

            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .pagination .page-item {
                margin: 0 5px;
            }

            .pagination .page-link {
                padding: 10px 15px;
                border: 1px solid #007bff;
                border-radius: 5px;
                color: #007bff;
                text-decoration: none;
            }

            .pagination .page-link:hover {
                background-color: #007bff;
                color: white;
            }

            .pagination .active .page-link {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
            }

            .pagination .disabled .page-link {
                color: #ccc;
                pointer-events: none;
            }
        </style>
    </head>

    <body id="page-top">
        <%@ include file="../user/navigationBar.jsp" %>

        <div id="wrapper">
            <!-- Sidebar -->
            <%@ include file="../user/sideBar.jsp" %>

            <div id="content-wrapper">
                <div class="container-fluid">
                    <!-- Breadcrumbs-->
                    <%@ include file="../user/breadCumb.jsp" %>

                    <!-- Notifications section -->
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12 text-center">
                                        <h4>Thông báo của bạn</h4>
                                        <hr>
                                    </div>
                                </div>
                                <!--                            <div class="text-right mb-3">
                                                                <button type="button" id="mark-all-as-read-btn" class="btn btn-primary">Đánh dấu tất cả đã đọc</button>
                                                            </div>-->
                                <div class="table-responsive">
                                    <c:if test="${not empty notifications}">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>Thông báo</th>
                                                    <th>Lúc nhận thông báo</th>
                                                    <th>Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="notification" items="${notifications}">
                                                <tr class="${notification.read ? 'read-notification' : ''}">
                                                    <td>${notification.message}</td>
                                                    <td>
                                                <fmt:parseDate value="${notification.createdAt}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedDate" />
                                                <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-success mark-as-read-btn ${notification.read ? 'hidden' : ''}" data-notification-id="${notification.notificationId}">Đánh dấu đã đọc</button>
                                                    <button type="button" class="btn btn-warning mark-as-unread-btn ${!notification.read ? 'hidden' : ''}" data-notification-id="${notification.notificationId}">Đánh dấu chưa đọc</button>
                                                </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="pagination">
                                            <ul class="pagination flex justify-center">
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link px-3 py-2 mx-1 rounded border ${currentPage == 1 ? 'text-gray-400 border-gray-300' : 'text-blue-600 border-blue-600'}" href="?page=${currentPage - 1}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>
                                                <c:forEach var="i" begin="1" end="${totalPages}">
                                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                        <a class="page-link px-3 py-2 mx-1 rounded border ${currentPage == i ? 'bg-blue-600 text-white border-blue-600' : 'text-blue-600 border-blue-600'}" href="?page=${i}">${i}</a>
                                                    </li>
                                                </c:forEach>
                                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <a class="page-link px-3 py-2 mx-1 rounded border ${currentPage == totalPages ? 'text-gray-400 border-gray-300' : 'text-blue-600 border-blue-600'}" href="?page=${currentPage + 1}" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </c:if>
                                    <c:if test="${empty notifications}">
                                        <p>No notifications found.</p>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->

                <!-- Sticky Footer -->
                <%@ include file="../user/stickFooter.jsp" %>
            </div>
            <!-- /.content-wrapper -->
        </div>
        <!-- /#wrapper -->

        <!-- Scroll to Top Button-->
        <%@ include file="../user/scrollUpToButton.jsp" %>

        <!-- Logout Modal-->
        <%@ include file="../user/logOutModal.jsp" %>

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

        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

        <script>
            $(document).ready(function () {
                // Mark as Read
                $(".mark-as-read-btn").click(function () {
                    var notificationId = $(this).data("notification-id");
                    updateNotificationStatus(notificationId, true);
                });

                // Mark as Unread
                $(".mark-as-unread-btn").click(function () {
                    var notificationId = $(this).data("notification-id");
                    updateNotificationStatus(notificationId, false);
                });

                // Mark all as Read
                $("#mark-all-as-read-btn").click(function () {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/notifications',
                        type: 'POST',
                        data: {
                            action: 'markAllAsRead'
                        },
                        success: function (response) {
                            location.reload();
                        },
                        error: function (xhr, status, error) {
                            alert('Error: ' + error);
                        }
                    });
                });

                function updateNotificationStatus(notificationId, isRead) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/notifications',
                        type: 'POST',
                        data: {
                            action: isRead ? 'markAsRead' : 'markAsUnread',
                            notificationId: notificationId
                        },
                        success: function (response) {
                            location.reload();
                        },
                        error: function (xhr, status, error) {
                            alert('Error: ' + error);
                        }
                    });
                }
            });
        </script>
    </body>
</html>