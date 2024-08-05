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

        <title>Bảng Điều Khiển Quản Lí</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">

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
            .error {
                color: red;
            }
            .active-page {
                background-color: #007bff;
                color: white;
            }
            .switch {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 34px;
            }
            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }
            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
            }
            .slider:before {
                position: absolute;
                content: "";
                height: 26px;
                width: 26px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                transition: .4s;
            }
            .card-stat {
                position: relative;
                overflow: hidden;
                border-radius: 10px;
                transition: transform 0.2s, box-shadow 0.2s;
            }

            .card-stat:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }

            .card-stat .card-body {
                position: relative;
                z-index: 2;
            }

            .card-stat .card-body h5 {
                font-size: 1.25rem;
                font-weight: bold;
            }

            .card-stat .card-body p {
                font-size: 1.5rem;
                font-weight: bold;
            }

            .card-stat::before {
                content: "";
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: rgba(255, 255, 255, 0.1);
                transform: rotate(45deg);
                transition: opacity 0.5s;
                z-index: 1;
            }

            .card-stat:hover::before {
                opacity: 0.3;
            }

        </style>
    </head>

    <body id="page-top">
        <jsp:include page="navigationBar.jsp"></jsp:include>
            <div id="wrapper">
            <jsp:include page="sideBar.jsp"></jsp:include>
                <div id="content-wrapper">
                    <div class="container-fluid">
                    <jsp:include page="breadCumbNews.jsp"></jsp:include>
                        <nav class="navbar navbar-light bg-light">
                            <form class="form-inline" action="${pageContext.request.contextPath}/admin/news" method="GET">
                            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="keyword" value="${param.keyword}">
                            <input type="hidden" name="action" value="search">
                            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                        </form>
                    </nav>
                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-table"></i>
                            Danh sách tin tức
                        </div>
                        <div class="card-body">
                            <!-- Thống kê số lượng bài đăng -->
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <div class="card bg-success text-white card-stat">
                                        <div class="card-body">
                                            <h5 class="card-title">Số bài đăng hiển thị</h5>
                                            <p class="card-text">
                                            <c:out value="${activeCount}" /> bài đăng
                                            </p>
                                            <button class="btn btn-light" onclick="filterByStatus(1)">Xem bài đăng</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card bg-danger text-white card-stat">
                                        <div class="card-body">
                                            <h5 class="card-title">Số bài đăng bị ẩn</h5>
                                            <p class="card-text">
                                            <c:out value="${inactiveCount}" /> bài đăng
                                            </p>
                                            <button class="btn btn-light" onclick="filterByStatus(0)">Xem bài đăng bị ẩn</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 3%;">STT</th>
                                            <th style="width: 10%;">Ảnh</th>
                                            <th style="width: 30%;">Tiêu Đề</th>
                                            <th style="width: 10%;">Ngày Đăng</th>
                                            <th style="width: 10%;">Ngày Chỉnh Sửa</th>
                                            <th style="width: 15%;">Sửa bài viết</th>
                                            <th style="width: 10%;">Ẩn bài viết</th>
                                            <th style="width: 10%;">Xóa bài</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${listNews}" var="news" varStatus="status">
                                        <tr>
                                            <td name="id">${news.getID()}</td>
                                            <td name="image">
                                                <img src="${news.getImage()}" width="100" height="100" alt="alt">
                                            </td>
                                            <td name="title">${news.getTitle()}</td>
                                            <td name="createdAt">${news.getCreatedAt()}</td>
                                            <td name="updatedAt">${news.getUpdatedAt()}</td>
                                            <td>
                                                <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/news?action=edit&id=${news.getID()}">
                                                    <i class="fas fa-pencil-alt"></i> Xem chi tiết và sửa 
                                                </a>
                                            </td>
                                            <td>
                                                <label class="switch">
                                                    <input type="checkbox" ${news.isStatus() ? 'checked' : ''} data-news-id="${news.getID()}">
                                                    <span class="slider round"></span>
                                                </label>
                                            </td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/admin/news?action=deleteNews" method="POST" enctype="multipart/form-data">
                                                    <input type ="hidden" name="id" value="${news.getID()}"/>
                                                    <button type="submit" class="btn btn-danger">
                                                        <i class="fas fa-trash-alt"></i> Xóa bài 
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- Pagination -->
                            <div class="row">
                                <div class="col-12 d-flex justify-content-center">
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="${pageContext.request.contextPath}/admin/news?page=${currentPage > 1 ? currentPage - 1 : 1 }&keyword=${param.keyword}&action=${param.action}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                    <span class="sr-only">Previous</span>
                                                </a>
                                            </li>
                                            <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                                                <li class="page-item ${currentPage == pageNumber ? 'active' : ''}">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/news?page=${pageNumber}&keyword=${param.keyword}&action=${param.action}">${pageNumber}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="${pageContext.request.contextPath}/admin/news?page=${currentPage < totalPages ? currentPage + 1 : totalPages}&keyword=${param.keyword}&action=${param.action}" aria-label="Next">
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
                </div>
                <jsp:include page="stickFooter.jsp"></jsp:include>
                </div>
            </div>

        <jsp:include page="scrollUpToButton.jsp"></jsp:include>
        <jsp:include page="logOutModal.jsp"></jsp:include>
        <jsp:include page="editCustomerModal.jsp"></jsp:include>

            <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/Chart.min.js"></script>
        <!--<script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>-->
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>
        <script>
                                                function filterByStatus(status) {
                                                    window.location.href = '${pageContext.request.contextPath}/admin/news?status=' + status;
                                                }

                                                $(document).ready(function () {
                                                    $('.pagination a').on('click', function (e) {
                                                        e.preventDefault();
                                                        var pageUrl = $(this).attr('href');
                                                        $.get(pageUrl, function (data) {
                                                            var newHtml = $(data).find('.table-responsive').html();
                                                            $('.table-responsive').html(newHtml);
                                                            $('.pagination li').removeClass('active');
                                                            $(this).parent().addClass('active-page');
                                                        });
                                                    });
                                                });

                                                $(".switch input[type='checkbox']").change(function () {
                                                    var newsId = $(this).data("news-id");
                                                    var status = $(this).is(":checked") ? 1 : 0;
                                                    $.ajax({
                                                        url: '${pageContext.request.contextPath}/admin/news?action=hideNews',
                                                        type: 'POST',
                                                        data: {
                                                            action: 'toggleStatus',
                                                            newsId: newsId,
                                                            status: status
                                                        },
                                                        success: function (response) {
                                                            alert("Cập nhật thành công"); // Trim the response to remove any accidental whitespace
                                                        },
                                                        error: function (xhr, status, error) {
                                                            alert('Error: ' + error);
                                                        }
                                                    });
                                                });

                                                function editNewsModal(button, newsId) {
                                                    var modalBody = $('#editNewsModal .modal-body');
                                                    $.ajax({
                                                        url: '${pageContext.request.contextPath}/admin/news?action=editNews',
                                                        type: 'GET',
                                                        data: {
                                                            newsId: newsId
                                                        },
                                                        success: function (response) {
                                                            modalBody.html(response);
                                                        },
                                                        error: function (xhr, status, error) {
                                                            modalBody.html('<div class="alert alert-danger">Error: ' + error + '</div>');
                                                        }
                                                    });
                                                }

                                                function saveNews() {
                                                    var form = $('#editNewsModal .modal-body form');
                                                    $.ajax({
                                                        url: form.attr('action'),
                                                        type: 'POST',
                                                        data: form.serialize(),
                                                        success: function (response) {
                                                            alert('Bài viết đã được cập nhật thành công.');
                                                            $('#editNewsModal').modal('hide');
                                                            location.reload();
                                                        },
                                                        error: function (xhr, status, error) {
                                                            alert('Error: ' + error);
                                                        }
                                                    });
                                                }
        </script>
    </body>
</html>