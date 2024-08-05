<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Profile</title>

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
            #previewImage {
                border: 1px solid #ddd;
                border-radius: 50%;
                padding: 5px;
                width: 150px;
                height: 150px;
                display: block;
                margin: auto;
            }
            .error {
                color: red;
            }

            /* Custom style for pink theme */
            .custom-file-input {
                display: none; /* Ẩn input file mặc định */
            }

            .btn-primary {
                background-color: #FF1493;
                border-color: #FF1493;
                color: #fff;
            }

            .btn-primary:hover {
                background-color: #FF1493;
                border-color: #FF1493;
                color: #fff;
            }

            .btn-primary i {
                margin-right: 10px; /* Khoảng cách giữa biểu tượng và văn bản */
            }

            .avatar-container {
                text-align: center; /* Canh giữa nút và hình ảnh */
            }

            .btn-upload {
                margin-top: 10px; /* Khoảng cách giữa nút và hình ảnh */
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

                    <!-- DataTables Example -->
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12 text-center">
                                        <h4>Thông tin cá nhân</h4>
                                        <hr>
                                    </div>
                                </div>
                                <div class="row">
                                    <!-- Left column for Profile Picture Form -->
                                    <div class="col-md-4">
                                        <form id="imageUploadForm" action="${pageContext.request.contextPath}/dashboard?action=change-image-profile" method="POST" enctype="multipart/form-data">
                                            <div class="form-group avatar-container">
                                                <img id="previewImage" src="${users.getProfilePicture()}" alt="Preview Image">
                                                <label for="profilePicture" class="btn btn-primary btn-upload">
                                                    <i class="fas fa-upload"></i> Ảnh đại diện
                                                    <input type="file" class="custom-file-input" id="profilePicture" name="profilePicture" onchange="displayImage(this)" style="display: none;">
                                                </label>
                                            </div>

                                            <div class="form-group text-center">
                                                <button type="button" id="saveImageButton" class="btn btn-primary">Lưu ảnh</button>
                                            </div>
                                        </form>
                                    </div>

                                    <!-- Right column for Profile Information Form -->
                                    <div class="col-md-8">
                                        <form id="profileForm" action="EditProfileController" method="POST" onsubmit="return validateForm()">
                                            <!-- Hidden fields for currentUsername and email -->
                                            <input type="hidden" name="currentUsername" value="${users.getUserName()}">
                                            <input type="hidden" name="email" value="${users.getEmail()}">

                                            <!-- Username -->
                                            <div class="form-group row">
                                                <label for="username" class="col-3 col-form-label">Tài khoản</label>
                                                <div class="col-9">
                                                    <input id="username" name="username" placeholder="" readonly class="form-control here" type="text" value="${users.getUserName()}">
                                                </div>
                                            </div>
                                            <!-- Email -->
                                            <div class="form-group row">
                                                <label for="email" class="col-3 col-form-label">Email</label>
                                                <div class="col-9">
                                                    <input id="email" name="email" placeholder="Email" class="form-control here" type="text" value="${users.getEmail()}" readonly>
                                                </div>
                                            </div>

                                            <!-- Gender -->
                                            <div class="form-group row">
                                                <label for="gender" class="col-sm-3 col-form-label">Giới tính</label>
                                                <div class="col-sm-9">
                                                    <input id="GenderDisplay" name="GenderDisplay" placeholder="" readonly class="form-control here" type="text" value="${users.getGender()}">
                                                    <select id="gender" name="gender" class="form-control" style="display: none;">
                                                        <option value="Không nói" ${sessionScope.gender == 'Không nói' ? 'selected' : ''}>Không nói</option>
                                                        <option value="Nam" ${sessionScope.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                                                        <option value="Nữ" ${sessionScope.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <!-- Date of Birth -->
                                            <div class="form-group row">
                                                <label for="dateOfBirth" class="col-sm-3 col-form-label">Ngày tháng năm sinh</label>
                                                <div class="col-sm-9">
                                                    <input id="DateOfBirthDisplay" name="DateOfBirthDisplay" placeholder="" readonly class="form-control here" type="text" value="${users.getDateOfBirth()}">
                                                    <input type="date" id="dob" name="dob" value="${users.getDateOfBirth()}" style="display: none;">
                                                </div>
                                            </div>

                                            <!-- Error message display -->
                                            <div class="form-group row">
                                                <div class="offset-sm-3 col-sm-9">
                                                    <span class="error">${empty errorMessage ? '' : errorMessage}</span>
                                                </div>
                                            </div>

                                            <!-- Buttons -->
                                            <div class="form-group row">
                                                <div class="offset-sm-3 col-sm-9">
                                                    <button type="button" id="editButton" class="btn btn-primary" onclick="enableEditing()">Chỉnh sửa thông tin</button>
                                                    <button type="submit" id="saveButton" class="btn btn-danger" style="display: none;">Lưu thông tin</button>
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

        <!-- Script to handle form submission and update UI -->
        <script>
                                                        $(document).ready(function () {
                                                            $('#profileForm').submit(function (event) {
                                                                event.preventDefault(); // Prevent default form submission
                                                                var formData = $(this).serialize(); // Serialize form data
                                                                var actionUrl = $(this).attr('action'); // Form action URL

                                                                // Perform AJAX POST request
                                                                $.ajax({
                                                                    type: 'POST',
                                                                    url: actionUrl,
                                                                    data: formData,
                                                                    success: function (response) {
                                                                        // Update UI with new data without refreshing the page
                                                                        $('#GenderDisplay').val($('#gender').val());
                                                                        $('#DateOfBirthDisplay').val($('#dob').val());

                                                                        // Clear any existing error message
                                                                        $('.error').text('');

                                                                        // Display success message if received in response
                                                                        if (response && response.successMessage) {
                                                                            $('.error').text(response.successMessage); // Display success message
                                                                        } else if (response && response.errorMessage) {
                                                                            $('.error').text(response.errorMessage); // Display error message
                                                                        }
                                                                    },
                                                                    error: function () {
                                                                        // Handle error case if AJAX request fails
                                                                        $('.error').text('Có lỗi xảy ra trong quá trình xử lý. Vui lòng thử lại sau.');
                                                                    }
                                                                });

                                                            });

                                                            $('#saveImageButton').click(function () {
                                                                var fileInput = $('#profilePicture')[0];
                                                                if (!fileInput.files.length) {
                                                                    $('.error').text('Vui lòng chọn một ảnh để tải lên.');
                                                                    return;
                                                                }

                                                                var formData = new FormData($('#imageUploadForm')[0]);
                                                                $.ajax({
                                                                    type: 'POST',
                                                                    url: $('#imageUploadForm').attr('action'),
                                                                    data: formData,
                                                                    processData: false,
                                                                    contentType: false,
                                                                    success: function (response) {
                                                                        if (response && response.errorMessage) {
                                                                            $('.error').text(response.errorMessage);
                                                                        } else {
                                                                            $('.error').text('');
                                                                            alert('Ảnh đã được lưu thành công!');
                                                                        }
                                                                    },
//                                                                    error: function () {
//                                                                        $('.error').text('Có lỗi xảy ra trong quá trình xử lý. Vui lòng thử lại sau.');
//                                                                    }
                                                                });
                                                            });
                                                        });
                                                        function enableEditing() {
                                                            document.getElementById('gender').style.display = 'block';
                                                            document.getElementById('DateOfBirthDisplay').style.display = 'none';
                                                            document.getElementById('dob').style.display = 'block';
                                                            document.getElementById('editButton').style.display = 'none';
                                                            document.getElementById('saveButton').style.display = 'block';
                                                        }
                                                        function afterSave() {
                                                            document.getElementById('gender').style.display = 'none';
                                                            document.getElementById('DateOfBirthDisplay').style.display = 'block';
                                                            document.getElementById('dob').style.display = 'none';
                                                            document.getElementById('editButton').style.display = 'block';
                                                            document.getElementById('saveButton').style.display = 'none';
                                                        }
                                                        function validateForm() {
                                                            const dobInput = document.getElementById('dob');
                                                            const dob = new Date(dobInput.value);
                                                            const today = new Date();
                                                            if (dob > today) {
                                                                alert('Ngày tháng năm sinh không được là ngày tương lai.');
                                                                return false;
                                                            }
                                                            saveToLocalStorage();
                                                            afterSave();
                                                            return true;
                                                        }
                                                        document.addEventListener("DOMContentLoaded", function () {
                                                            const gender = localStorage.getItem('gender');
                                                            const dob = localStorage.getItem('dob');
                                                            if (gender) {
                                                                document.getElementById('GenderDisplay').value = gender;
                                                                document.getElementById('gender').value = gender;
                                                            }
                                                            if (dob) {
                                                                document.getElementById('DateOfBirthDisplay').value = dob;
                                                                document.getElementById('dob').value = dob;
                                                            }
                                                        });
                                                        function saveToLocalStorage() {
                                                            const gender = document.getElementById('gender').value;
                                                            const dob = document.getElementById('dob').value;
                                                            localStorage.setItem('gender', gender);
                                                            localStorage.setItem('dob', dob);
                                                        }
        </script>
    </body>
</html>