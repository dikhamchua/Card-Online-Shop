<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Quản lý chất lượng sản phẩm</title>
        <link href="${pageContext.request.contextPath}/assets/css/vendor/all.min.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }

            .error {
                color: red;
            }

            .dataTables_wrapper .dataTables_paginate .paginate_button {
                padding: 0.1em 0.4em;
                margin: 0.2em;
                font-size: 0.875em;
            }

            .dataTables_wrapper .dataTables_filter {
                text-align: left;
            }

            .dataTables_wrapper .dataTables_paginate {
                float: right;
                padding-top: 0.25em;
            }

            /* Adjust column widths */
            .table thead th.card-type-name,
            .table tbody td.card-type-name {
                width: 7%;
            }

            .table thead th.average-rating,
            .table tbody td.average-rating {
                width: 15%;
            }

            .table thead th.total-reviews,
            .table tbody td.total-reviews {
                width: 12%;
            }

            .table thead th.details,
            .table tbody td.details {
                width: 17%;
            }
        </style>
    </head>

    <body id="page-top">
        <jsp:include page="navigationBar.jsp" />
        <div id="wrapper">
            <jsp:include page="sideBar.jsp" />
            <div id="content-wrapper">
                <div class="container-fluid">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="#">Quản lý chất lượng sản phẩm</a>
                        </li>
                    </ol>
                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-table"></i>
                            Chất lượng
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-sm" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th class="card-type-name">Loại thẻ</th>
                                            <th class="average-rating">Đánh giá trung bình</th>
                                            <th class="total-reviews">Tổng đánh giá</th>
                                            <th class="details">Chi tiết</th>
                                            <th>Đánh giá chung</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="entry" items="${cardInfoMap.entrySet()}" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td class="card-type-name">${entry.key}</td>
                                                <td class="average-rating"><fmt:formatNumber value="${entry.value.averageRating}" type="number" maxFractionDigits="2" />/5</td>
                                                <td class="total-reviews">${entry.value.totalReviews}</td>
                                                <td class="details">
                                                    <c:forEach var="ratingEntry" items="${entry.value.ratingCount}">
                                                        <p>${ratingEntry.key} sao (${ratingEntry.value} lần đánh giá)</p>
                                                    </c:forEach>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${entry.value.averageRating >= 1 && entry.value.averageRating < 1.5}">
                                                            Người dùng hoàn toàn không hài lòng về dịch vụ hoặc sản phẩm này.
                                                        </c:when>
                                                        <c:when test="${entry.value.averageRating >= 1.5 && entry.value.averageRating < 2}">
                                                            Có nhiều khía cạnh cần cải thiện, không đạt yêu cầu của người dùng.
                                                        </c:when>
                                                        <c:when test="${entry.value.averageRating >= 2 && entry.value.averageRating < 2.5}">
                                                            Người dùng cảm thấy không hài lòng với sản phẩm hoặc dịch vụ này.
                                                        </c:when>
                                                        <c:when test="${entry.value.averageRating >= 2.5 && entry.value.averageRating < 3}">
                                                            Dịch vụ hoặc sản phẩm không nổi bật, nhưng cũng không quá tệ.
                                                        </c:when>
                                                        <c:when test="${entry.value.averageRating >= 3 && entry.value.averageRating < 3.5}">
                                                            Người dùng hài lòng với dịch vụ hoặc sản phẩm, nhưng có vài điểm cần cải thiện.
                                                        </c:when>
                                                        <c:when test="${entry.value.averageRating >= 3.5 && entry.value.averageRating < 4.5}">
                                                            Chất lượng sản phẩm hoặc dịch vụ tốt, giá cả hợp lý, đáp ứng sự hài lòng của người dùng.
                                                        </c:when>
                                                        <c:when test="${entry.value.averageRating >= 4.5 && entry.value.averageRating <= 5}">
                                                            Sản phẩm hoặc dịch vụ vượt qua mong đợi của người dùng, không có bất kỳ phàn nàn nào.
                                                        </c:when>
                                                        <c:otherwise>
                                                            Mô tả không có sẵn.
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="stickFooter.jsp" />
            </div>
        </div>
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>
        <jsp:include page="logOutModal.jsp" />
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/Chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.dataTables.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "pagingType": "simple_numbers",
                    "pageLength": 5,
                    "ordering": false,
                    "dom": 'ftip',
                    "language": {
                        "search": "Tìm kiếm:"
                    }
                });
            });
        </script>
    </body>

</html>