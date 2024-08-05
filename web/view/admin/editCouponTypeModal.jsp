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
<div class="modal fade" id="editCouponTypeModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editCouponTypeModalLabel">Chỉnh sửa chương trình giảm giá</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editCouponTypeForm" action="dashboardCouponType?action=edit" method="POST" onsubmit="return validateForm2()">
                    <!-- ID -->
                    <div class="form-group" style="display: none">
                        <input type="text" class="form-control" id="idEditInput" name="ID">
                    </div>
                    <!-- CouponTypeName -->
                    <div class="form-group">
                        <label for="name">Tên chương trình giảm giá:</label>
                        <input type="text" class="form-control" id="nameEditInput" name="CouponTypeName">
                        <div id="nameEditError" class="error text-danger"></div>
                    </div>
                    <!-- StartDate -->
                    <div class="form-group">
                        <label for="StartDate">Ngày bắt đầu:</label>
                        <input type="date" class="form-control" id="startDateEditInput" name="StartDate">
                        <div id="startDateEditError" class="error text-danger"></div>
                    </div>
                    <!-- EndDate -->
                    <div class="form-group">
                        <label for="EndDate">Ngày kết thúc:</label>
                        <input type="date" class="form-control" id="endDateEditInput" name="EndDate">
                        <div id="endDateEditError" class="error text-danger"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary" form="editCouponTypeForm">Cập nhật</button>
            </div>
        </div>
    </div>
</div>

<script>
    function editCouponTypeModal(button) {
        let id = $(button).closest('tr').find('td[name="id"]').text().trim();
        let name = $(button).closest('tr').find('td[name="name"]').text().trim();
        let start = $(button).closest('tr').find('td[name="start"]').text().trim();
        let end = $(button).closest('tr').find('td[name="end"]').text().trim();

        $('#idEditInput').val(id);
        $('#nameEditInput').val(name);
        $('#startDateEditInput').val(start);
        $('#endDateEditInput').val(end);
    }

    function validateForm2() {
        let isValid = true;
        let nameInput = $('#nameEditInput').val().trim();
        let startDateInput = $('#startDateEditInput').val().trim();
        let endDateInput = $('#endDateEditInput').val().trim();
        let currentDate = new Date().toISOString().split('T')[0];

        if (nameInput === "") {
            $('#nameEditError').text('Không được bỏ trống mục này!');
            isValid = false;
        } else {
            $('#nameEditError').text('');
        }

        if (startDateInput === "") {
            $('#startDateEditError').text('Không được bỏ trống mục này!');
            isValid = false;
        } else if (startDateInput < currentDate) {
            $('#startDateEditError').text('Ngày bắt đầu không được là ngày quá khứ!');
            isValid = false;
        } else {
            $('#startDateEditError').text('');
        }

        if (endDateInput === "") {
            $('#endDateEditError').text('Không được bỏ trống mục này!');
            isValid = false;
        } else if (endDateInput < startDateInput) {
            $('#endDateEditError').text('Ngày kết thúc không được trước ngày bắt đầu!');
            isValid = false;
        } else {
            $('#endDateEditError').text('');
        }

        return isValid;
    }
</script>

