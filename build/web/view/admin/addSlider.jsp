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
                background-color: #007bff; /* Màu xanh tương tự như trong ảnh */
                color: white;
            }
            .form-control-lg {
                font-size: 1.25rem; /* Increase the font size */
            }
            .h5 {
                font-size: 1.5rem; /* Increase the label font size */
            }
            .btn-lg {
                font-size: 1.25rem; /* Increase the button font size */
            }
            .btn-create-post {
                display: block;
                margin: 0 auto;
                width: auto;
                font-size: 1.2rem; /* Decrease the button font size */
            }
            .create-post-container {
                max-width: 80%; /* Increase the width of the form container */
                margin: 0 auto; /* Center the form container */
            }
            .card-header {
                font-size: 1.5rem;
                /* Increase the font size of the card header */
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
                        <div class="card mb-3">
                            <!-- Form to create a new post -->
                            <!--<div class="container my-5 create-post-container">-->
                            <div class="card">
                                <div class="card-header bg-primary text-white">
                                    <i class="fas fa-plus"></i>
                                    Thêm ảnh mới
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/admin/slider?action=addSlider" method="POST" enctype="multipart/form-data" onsubmit="return validateForm()">
                                    <!--Image-->
                                    <div class="form-group">
                                        <label for="image">Ảnh: </label>
                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">Upload</span>
                                            </div>
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input" id="image" name="image" onchange="displayImage(this)">
                                                <label class="custom-file-label">Chọn ảnh</label>
                                            </div>
                                        </div>
                                        <img id="previewImage" src="#" alt="Preview" style="display: none; max-width: 500px; max-height: 300px;">
                                        <div id="imageError" class="error" style="display: none;">Vui lòng chọn ảnh.</div>
                                    </div>
                                    <!--Button-->
                                    <button type="submit" class="btn btn-primary btn-create-post">Đăng ảnh</button>
                                </form>
                            </div>
                        </div>
                        <!--</div>-->
                    </div>
                </div>
                <!-- Sticky Footer -->
                <jsp:include page="stickFooter.jsp"></jsp:include>
                </div>
            </div>

            <!-- Scroll to Top Button-->
        <jsp:include page="scrollUpToButton.jsp"></jsp:include>

            <!-- Logout Modal-->
        <jsp:include page="logOutModal.jsp"></jsp:include>

            <!--Edit Customer Modal-->
        <jsp:include page="editCustomerModal.jsp"></jsp:include>

            <!-- Bootstrap core JavaScript-->
            <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/css/vendor/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/css/vendor/jquery.easing.min.js"></script>

        <!-- Page level plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/css/vendor/Chart.min.js"></script>
        <!-- Custom scripts for all pages-->
        <script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>

        <!-- Ajax for pagination-->
        <script>
                                                    $(document).ready(function () {
                                                        $('.pagination a').on('click', function (e) {
                                                            e.preventDefault();
                                                            var pageUrl = $(this).attr('href');

                                                            $.get(pageUrl, function (data) {
                                                                var newHtml = $(data).find('.table-responsive').html();
                                                                $('.table-responsive').html(newHtml);

                                                                // Đánh dấu số trang hiện tại với lớp CSS mới
                                                                $('.pagination li').removeClass('active');
                                                                $(this).parent().addClass('active-page'); // Chỉnh sửa tên lớp thành 'active-page' để sử dụng màu xanh
                                                            });
                                                        });
                                                    });

                                                    function validateForm() {
                                                        var imageInput = document.getElementById("image");
                                                        var imageError = document.getElementById("imageError");

                                                        if (!imageInput.value) {
                                                            imageError.style.display = "block";
                                                            return false; // Ngăn không cho form được gửi đi
                                                        } else {
                                                            imageError.style.display = "none";
                                                            return true; // Cho phép form được gửi đi
                                                        }
                                                    }

                                                    function displayImage(input) {
                                                        var previewImage = document.getElementById("previewImage");
                                                        var file = input.files[0];
                                                        var reader = new FileReader();

                                                        reader.onload = function (e) {
                                                            previewImage.src = e.target.result;
                                                            previewImage.style.display = "block";
                                                        }

                                                        reader.readAsDataURL(file);
                                                    }
        </script>
    </body>
</html>