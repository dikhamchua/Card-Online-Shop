<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm sản phẩm</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
            .error-message {
                color: red;
                font-size: 0.875rem;
                margin-top: 0.25rem;
            }
            .success-message {
                color: green;
                font-size: 0.875rem;
                margin-top: 0.25rem;
            }
        </style>
    </head>
    <body>

        <!-- Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalLabel">Thêm sản phẩm</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="addProductForm" action="dashboardcard?action=add" method="POST">
                            <div id="successMessage" class="alert alert-success" style="display: none;"></div>

                            <!-- CardTypeID -->
                            <div class="form-group">
                                <label for="tidInput">Loại thẻ:</label>
                                <select class="custom-select" id="tidInput" name="cardtypeid" onchange="updatePriceOptions()">
                                    <c:forEach items="${listCardTypes}" var="category">
                                        <option value="${category.getID()}">${category.getCardTypeName()}</option>
                                    </c:forEach>
                                </select>
                                <div id="tidError" class="error-message"></div>
                            </div>

                            <!-- Price -->
                            <div class="form-group">
                                <label for="priceInput">Mệnh giá: </label>
                                <select class="custom-select" id="priceInput" name="price">
                                    <!-- Options will be populated dynamically -->
                                </select>
                                <div id="priceError" class="error-message"></div>
                            </div>

                            <!-- CardCode -->
                            <div class="form-group">
                                <label for="codeInput">Mã thẻ:</label>
                                <input type="text" class="form-control" id="codeInput" name="cardcode">
                                <div id="codeError" class="error-message"></div>
                            </div>

                            <!-- SerialNumber -->
                            <div class="form-group">
                                <label for="serialnumberInput">Mã Seri:</label>
                                <input type="text" class="form-control" id="serialnumberInput" name="serialnumber">
                                <div id="serialnumberError" class="error-message"></div>
                            </div>

                            <!-- ExpirationDate -->
                            <div class="form-group">
                                <label for="expirationDateInput">Ngày hết hạn:</label>
                                <input type="date" class="form-control" id="expirationDateInput" name="expirationDate">
                                <div id="expirationDateError" class="error-message"></div>
                            </div>
                        </form>
                        <div id="formError" class="alert alert-danger" style="display: none;"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" onclick="validateForm()">Thêm</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal for Upload Excel -->
        <div class="modal fade" id="uploadExcelModal" tabindex="-1" role="dialog" aria-labelledby="uploadExcelModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="uploadExcelModalLabel">Tải file Excel</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="uploadExcelForm" action="dashboardcard?action=uploadExcel" method="POST" enctype="multipart/form-data">
                            <!--<div id="successMessageExcel" class="alert alert-success" style="display: none;"></div>-->
                            <!--                            <div id="excelFileError" class="error-message"></div>-->
                            <div class="form-group">
                                <label for="excelFile">Chọn file Excel:</label>
                                <input type="file" class="form-control-file" id="excelFile" name="excelFile" accept=".xls,.xlsx" required>
                                <c:if test="${not empty sessionScope.errorMessageExcel}">
                                    <div class="alert alert-danger">${sessionScope.errorMessageExcel}</div>
                                </c:if>
                                <c:if test="${not empty sessionScope.successMessageExcel}">
                                    <div class="alert alert-success">${sessionScope.successMessageExcel}</div>
                                </c:if>
                            </div>
                            <button type="button" class="btn btn-primary" onclick="validateExcelForm()">Đồng ý</button>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                                function uploadExcel() {
                                    document.getElementById('uploadExcelForm').submit();
                                }

                                function validateForm() {
                                    let cardcode = $('#codeInput').val();
                                    let cardtypeid = $('#tidInput').val();
                                    let serialnumber = $('#serialnumberInput').val();
                                    let price = $('#priceInput').val();
                                    let expirationDate = $('#expirationDateInput').val();

                                    // Clear current error messages
                                    $('.error-message').html('');

                                    let hasError = false;

                                    if (cardcode === '') {
                                        $('#codeError').html('Card code is required');
                                        hasError = true;
                                    }

                                    if (cardtypeid === '') {
                                        $('#tidError').html('Card type is required');
                                        hasError = true;
                                    }

                                    if (serialnumber === '') {
                                        $('#serialnumberError').html('Serial number is required');
                                        hasError = true;
                                    }

                                    if (price === '') {
                                        $('#priceError').html('Price is required');
                                        hasError = true;
                                    }

                                    if (expirationDate === '') {
                                        $('#expirationDateError').html('Expiration date is required');
                                        hasError = true;
                                    }

                                    if (!hasError) {
                                        $.ajax({
                                            url: 'dashboardcard?action=checkCardCode',
                                            method: 'POST',
                                            data: {cardcode: cardcode},
                                            success: function (response) {
                                                if (response === 'exists') {
                                                    $('#codeError').html('Mã thẻ đã tồn tại.');
                                                } else {
                                                    // Check serial number via AJAX
                                                    $.ajax({
                                                        url: 'dashboardcard?action=checkSerialNumber',
                                                        method: 'POST',
                                                        data: {serialnumber: serialnumber},
                                                        success: function (response) {
                                                            if (response === 'exists') {
                                                                $('#serialnumberError').html('Số seri đã tồn tại.');
                                                            } else {
                                                                // Check expiration date via AJAX
                                                                $.ajax({
                                                                    url: 'dashboardcard?action=checkExpirationDate',
                                                                    method: 'POST',
                                                                    data: {expirationDate: expirationDate},
                                                                    success: function (response) {
                                                                        if (response.status === 'error') {
                                                                            $('#expirationDateError').html(response.message);
                                                                        } else {
                                                                            $.ajax({
                                                                                url: 'dashboardcard?action=add',
                                                                                method: 'POST',
                                                                                data: $('#addProductForm').serialize(),
                                                                                success: function (response) {
                                                                                    if (response.status === 'success') {
                                                                                        $('#successMessage').html(response.message).show();
                                                                                        setTimeout(function () {
                                                                                            location.reload();
                                                                                        }, 2000); // Thời gian delay 2 giây trước khi reload trang
                                                                                    } else {
                                                                                        $('#formError').html(response.message).show();
                                                                                    }
                                                                                },
                                                                                error: function (xhr, status, error) {
                                                                                    console.error('AJAX Error:', error);
                                                                                }
                                                                            });
                                                                        }
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        console.error('AJAX Error:', error);
                                                                    }
                                                                });
                                                            }
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.error('AJAX Error:', error);
                                                        }
                                                    });
                                                }
                                            },
                                            error: function (xhr, status, error) {
                                                console.error('AJAX Error:', error);
                                            }
                                        });
                                    }
                                }

                                function updatePriceOptions() {
                                    let cardtypeid = $('#tidInput').val();
                                    console.log(cardtypeid);
                                    $.ajax({
                                        url: 'dashboardcard?action=getPricesByCardType',
                                        method: 'GET',
                                        data: {cardtypeid: cardtypeid},
                                        dataType: 'json', // This ensures jQuery parses the response as JSON
                                        success: function (prices) {
                                            let priceSelect = $('#priceInput');
                                            priceSelect.empty();
                                            prices.forEach(function (price) {
                                                priceSelect.append($('<option>', {
                                                    value: price.ID,
                                                    text: formatCurrency(price.Price)
                                                }));
                                            });
                                        },
                                        error: function (xhr, status, error) {
                                            console.error('AJAX Error:', error);
                                        }
                                    });
                                }

                                function formatCurrency(amount) {
                                    return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
                                }

                                $(document).ready(function () {
                                    // Call updatePriceOptions when the page is loaded
                                    updatePriceOptions();

                                    // Add change event for tidInput
                                    $('#tidInput').change(function () {
                                        updatePriceOptions();
                                    });

                                });

                                function validateExcelForm() {
                                    let excelFile = $('#excelFile').val();

                                    // Clear current error messages
                                    $('#excelFileError').html('');

                                    let hasError = false;

                                    if (excelFile === '') {
                                        $('#excelFileError').html('Excel file is required');
                                        hasError = true;
                                    }

                                    if (!hasError) {
                                        $('#uploadExcelForm').submit();
                                    }
                                }

                                $(document).ready(function () {
                                    // Kiểm tra xem có lỗi Excel không
            <c:if test="${not empty sessionScope.successMessageExcel}">
                                    $('#uploadExcelModal').modal('show');
                                    $('#successMessageExcel').html('${successMessageExcel}');
                                    setTimeout(function () {
                                        location.reload();// Thời gian delay 3 giây trước khi reload trang
                                    }, 3000);
                <% session.removeAttribute("successMessageExcel"); %>
                <% session.removeAttribute("showExcelModal"); %>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessageExcel}">
                                    $('#uploadExcelModal').modal('show');
                                    $('#excelFileError').html('${sessionScope.errorMessageExcel}');
                                    $('#successMessageExcel').html('${successMessageExcel}');
                                    setTimeout(function () {
                                        location.reload();// Thời gian delay 3 giây trước khi reload trang
                                    }, 3000);
                                    // Xóa lỗi sau khi hiển thị
                <% session.removeAttribute("errorMessageExcel"); %>
                <% session.removeAttribute("showExcelModal"); %>
                <% session.removeAttribute("successMessageExcel"); %>
                <% session.removeAttribute("showExcelModal"); %>

            </c:if>
                                });
        </script>
    </body>
</html>
