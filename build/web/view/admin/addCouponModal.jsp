<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
<link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
<style>
    body {
        font-family: 'Be Vietnam Pro', sans-serif !important;
    }
</style>
<!-- Modal -->
<div class="modal fade" id="addCouponModal" tabindex="-1" role="dialog" >
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCouponModalLabel">Add Coupon</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addCouponForm" action="dashboardCoupon?action=add" method="POST">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>

                    <!-- CouponType -->
                    <div class="form-group">
                        <label for="couponTypeInput">Tên loại phiếu giảm giá:</label>
                        <select class="custom-select" id="couponTypeInput" name="coupontypeid">
                            <c:forEach items="${listCouponType}" var="type">
                                <option value="${type.getID()}">${type.getCouponTypeName()}</option>
                            </c:forEach>
                        </select>
                        <div id="couponTypeError" class="error-message"></div>
                    </div>

                    <!-- CouponCode -->
                    <div class="form-group">
                        <label for="couponCodeInput">Mã phiếu giảm giá:</label>
                        <input type="text" class="form-control" id="couponCodeInput" name="couponcode">
                        <div id="couponCodeError" class="error-message"></div>
                    </div>

                    <!-- CouponAmount -->
                    <div class="form-group">
                        <label for="couponAmountInput">Giá trị phiếu giảm giá(%):</label>
                        <input type="number" class="form-control" id="couponAmountInput" name="couponamount">
                        <div id="couponAmountError" class="error-message"></div>
                    </div>

                    <!-- UsageCount -->
                    <div class="form-group">
                        <label for="usageCountInput">Số lần sử dụng:</label>
                        <input type="number" class="form-control" id="usageCountInput" name="usageCount">
                        <div id="usageCountError" class="error-message"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="validateCouponForm()">Add</button>
            </div>
        </div>
    </div>
</div>

<script>
    function validateCouponForm() {
        let couponcode = $('#couponCodeInput').val();
        let coupontypeid = $('#couponTypeInput').val();
        let couponamount = $('#couponAmountInput').val();
        let currentDate = new Date().toISOString().split('T')[0];
        let usageCount = $('#usageCountInput').val();

        // Clear current error messages
        $('.error-message').html('');

        let hasError = false;

        if (couponcode === '') {
            $('#couponCodeError').html('Mã phiếu mua hàng đã tồn tại');
            hasError = true;
        }

        if (coupontypeid === '') {
            $('#couponTypeError').html('Không được để trống!!!');
            hasError = true;
        }

        if (couponamount === '') {
            $('#couponAmountError').html('Không được để trống!!!');
            hasError = true;
        } else if (couponamount > 90) {
            $('#couponAmountError').html('Giá trị phiếu mua hàng không được vượt quá 90%');
            hasError = true;
        }

         if (usageCount === '') {
            $('#usageCountError').html('Không được để trống!!!');
            hasError = true;
        }

        // Check coupon code via AJAX
        if (!hasError) {
            $.ajax({
                url: 'dashboardCoupon?action=checkCouponCode',
                method: 'POST',
                data: {couponcode: couponcode},
                success: function (response) {
                    if (response.trim() === 'exists') {
                        $('#couponCodeError').html('Mã phiếu mua hàng đã tồn tại');
                    } else {
                        $('#addCouponForm').submit();
                    }
                },
                error: function (xhr, status, error) {
                    console.error('AJAX Error:', error);
                }
            });
        }
    }
</script>
