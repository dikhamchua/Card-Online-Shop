<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Modal -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
<link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
<style>
    body {
        font-family: 'Be Vietnam Pro', sans-serif !important;
    }
</style>
<div class="modal fade" id="addCouponTypeModal" tabindex="-1" role="dialog" >
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCouponTypeModalLabel">Thêm chương trình giảm giá</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addCouponTypeForm" action="dashboardCouponType?action=add" method="POST">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>

                    <!-- CouponTypeName -->
                    <div class="form-group">
                        <label for="couponTypeNameInput">Tên chương trình giảm giá:</label>
                        <input type="text" class="form-control" id="couponTypeNameInput" name="CouponTypeName">
                        <div id="couponTypeNameError" class="error-message"></div>
                    </div>
                    <!-- Start date -->
                    <div class="form-group">
                        <label for="couponStartDateInput">Ngày bắt đầu:</label>
                        <input type="date" class="form-control" id="couponStartDateInput" name="couponStartDate">
                        <div id="couponStartDateError" class="error-message"></div>
                    </div>
                    <!-- End date -->
                    <div class="form-group">
                        <label for="couponEndDateInput">Ngày kết thúc:</label>
                        <input type="date" class="form-control" id="couponEndDateInput" name="couponEndDate">
                        <div id="couponEndDateError" class="error-message"></div>
                    </div>
                    <!--                     Status 
                                        <div class="form-group">
                                            <label for="couponStatusInput">Trạng thái:</label>
                                            <input type="text" class="form-control" id="couponStatusInput" name="couponStatus">
                                            <div id="couponStatusError" class="error-message"></div>
                                        </div>-->
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="validateCouponTypeForm()">Add</button>
            </div>
        </div>
    </div>
</div>

<script>
    function validateCouponTypeForm() {
        let couponTypeName = $('#couponTypeNameInput').val();
        let couponStartDate = $('#couponStartDateInput').val();
        let couponEndDate = $('#couponEndDateInput').val();
        let currentDate = new Date().toISOString().split('T')[0]; // Lấy ngày hiện tại định dạng yyyy-mm-dd

        // Clear current error messages
        $('.error-message').html('');
        let hasError = false;

        if (couponTypeName === '') {
            $('#couponTypeNameError').html('Không được bỏ trống mục này!');
            hasError = true;
        }

        if (couponStartDate === '') {
            $('#couponStartDateError').html('Không được bỏ trống mục này!');
            hasError = true;
        } else if (couponStartDate < currentDate) {
            $('#couponStartDateError').html('Ngày bắt đầu không được là ngày quá khứ!');
            hasError = true;
        }

        if (couponEndDate === '') {
            $('#couponEndDateError').html('Không được bỏ trống mục này!');
            hasError = true;
        } else if (couponEndDate < couponStartDate) {
            $('#couponEndDateError').html('Ngày kết thúc không được trước ngày bắt đầu!');
            hasError = true;
        }

        if (!hasError) {
            $('#addCouponTypeForm').submit();
        }
    }

        // Initialize any necessary components
    ;
</script>
