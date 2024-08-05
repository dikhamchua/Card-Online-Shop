<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Category</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <style>
            .error-message {
                color: red;
                font-size: 0.875rem;
                margin-top: 0.25rem;
            }
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
        </style>
    </head>
    <body>
        <!-- Modal -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="addCategoryModal" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCategoryModal">Thêm loại thẻ</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger">${errorMessage}</div>
                        </c:if>
                        <div class="form-group">
                            <label for="name">Tên loại thẻ:</label>
                            <input type="text" class="form-control" id="nameInput" name="name" required>
                            <div id="nameError" class="error-message"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" onclick="validateForm()">Add</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                            function validateForm() {
                                let name = $('#nameInput').val();
                                $('#nameError').html('');

                                let hasError = false;

                                if (name === '') {
                                    $('#nameError').html('Tên loại thẻ không được để trống');
                                    hasError = true;
                                }

                                if (!hasError) {
                                    $.ajax({
                                        url: 'dashboardCategory?action=add',
                                        method: 'POST',
                                        data: {name: name},
                                        success: function (response) {
                                            if (response === 'exists') {
                                                $('#nameError').html('Loại thẻ đã tồn tại.');
                                            } else {
                                                window.location.href = 'dashboardCategory';
                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            console.error('AJAX Error:', error);
                                        }
                                    });
                                }
                            }
        </script>
    </body>
</html>