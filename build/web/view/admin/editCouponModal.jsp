<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
<link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
<style>
    body {
        font-family: 'Be Vietnam Pro', sans-serif !important;
    }
</style>
<div class="modal fade" id="editCouponModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editCouponModalLabel">Chỉnh sửa phiếu mua hàng</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editCouponForm" action="dashboardCoupon?action=edit" method="POST">
                    <!-- ID -->
                    <div class="form-group" style="display: none">
                        <input type="text" class="form-control" id="idEditInput" name="ID">
                    </div>
                    <!-- CouponTypeName -->
                    <div class="form-group">
                        <label for="nameEditInput">Tên loại phiếu giảm giá:</label>
                        <select class="custom-select" id="nameEditInput" name="CouponTypeName">
                            <c:forEach items="${listCouponType}" var="type">
                                <option value="${type.getID()}">${type.getCouponTypeName()}</option>
                            </c:forEach>
                        </select>
                        <div id="nameEditError" class="error"></div>
                    </div>
                    <!-- CouponCode -->
                    <div class="form-group">
                        <label for="code">Mã phiếu giảm giá:</label>
                        <input type="text" class="form-control" id="codeEditInput" name="CouponCode">
                        <div id="codeEditError" class="error"></div>
                    </div>
                    <!-- CouponAmount -->
                    <div class="form-group">
                        <label for="amount">Giá trị phiếu giảm giá:</label>
                        <input type="text" class="form-control" id="amountEditInput" name="CouponAmount">
                        <div id="amountEditError" class="error"></div>
                    </div>
                    <!-- UsageCount -->
                    <div class="form-group">
                        <label for="usageCount">Số lần sử dụng:</label>
                        <input type="number" class="form-control" id="usageCountEditInput" name="UsageCount">
                        <div id="usageCountEditError" class="error"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary" form="editCouponForm" onclick="validateForm()">Cập nhật</button>
            </div>
        </div>
    </div>
</div>

<script>
    function editCouponModal(button) {
        let id = $(button).closest('tr').find('td[name="id"]').text().trim();
        let couponTypeName = $(button).closest('tr').find('td[name="couponname"]').text().trim();
        let code = $(button).closest('tr').find('td[name="code"]').text().trim();
        let amount = $(button).closest('tr').find('td[name="amount"]').text().trim();
        let usageCount = $(button).closest('tr').find('td[name="usageCount"]').text().trim();

        $('#idEditInput').val(id);
        $('#nameEditInput option').filter(function () {
            return $(this).text() === couponTypeName;
        }).prop('selected', true);
        $('#codeEditInput').val(code);
        $('#amountEditInput').val(amount);
        $('#usageCountEditInput').val(usageCount);
    }


    function validateForm() {
        let name = $('#nameEditInput').val();
        let code = $('#codeEditInput').val();
        let amount = $('#amountEditInput').val();
        let usageCount = $('#usageCountEditInput').val();

        // Clear current error messages
        $('.error').html('');

        if (name === '') {
            $('#nameEditError').html('Tên loại phiếu mua hàng không được để trống');
        }

        if (code === '') {
            $('#codeEditError').html('Mã phiếu mua hàng không được để trống');
        }

        if (amount === '') {
            $('#amountEditError').html('Giá trị phiếu mua hàng không được để trống');
        } else if (!$.isNumeric(amount) || parseFloat(amount) < 0) {
            $('#amountEditError').html('Giá trị phiếu mua hàng phải là số và không được nhỏ hơn 0');
        } else if (amount > 90) {
            $('#amountEditError').html('Giá trị phiếu mua hàng không được vượt quá 90%');
        }

        if (usageCount === '') {
            $('#usageCountEditError').html('Số lần sử dụng không được để trống');
        } else if (!$.isNumeric(usageCount) || parseInt(usageCount) < 0) {
            $('#usageCountEditError').html('Số lần sử dụng phải là số và không được nhỏ hơn 0');
        }

        // Check if there are any errors before submitting the form
        let error = '';
        $('.error').each(function () {
            error += $(this).html();
        });

        if (error === '') {
            $('#editCouponForm').submit();
        } else {
            event.preventDefault();
        }
    }
</script>
