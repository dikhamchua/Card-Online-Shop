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
<div class="modal fade" id="editCategoryModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editBookModalLabel">Chỉnh sửa</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editBookForm" action="dashboardCategory?action=edit" method="POST">
                    <!--id-->
                    <div class="form-group" style="display: none">
                        <input type="text" class="form-control" id="idEditInput" name="ID">
                    </div>
                    <!--Name-->
                    <div class="form-group">
                        <label for="name">Đặt tên thẻ:</label>
                        <input type="text" class="form-control" id="nameEditInput" name="CardTypeName">
                        <div id="nameEditError" class="error text-danger"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary" form="editBookForm" onclick="return validateForm2()">Cập nhật</button>
            </div>
        </div>
    </div>
</div>

<script>
    function editModal(button) {
        let id = $(button).closest('tr').find('td[name="id"]').text().trim();
        let name = $(button).closest('tr').find('td[name="name"]').text().trim();
        $('#idEditInput').val(id);
        $('#nameEditInput').val(name);
    }

    function validateForm2() {
        let name = $('#nameEditInput').val().trim();
        if (name === "") {
            $('#nameEditError').text("Tên thẻ không được để trống.");
            return false;
        } else {
            $('#nameEditError').text("");
            return true;
        }
    }

    // Function to display a success message after the form submission
    $('#editBookForm').on('submit', function (event) {
        event.preventDefault();
        if (validateForm2()) {
            $.ajax({
                url: $(this).attr('action'),
                type: $(this).attr('method'),
                data: $(this).serialize(),
                success: function (response) {
                    $('#editCategoryModal').modal('hide');
                    alert("Cập nhật thành công!");
                    // Optionally, you can refresh the page or update the table row with the new data
                },
                error: function () {
                    alert("Có lỗi xảy ra, vui lòng thử lại.");
                }
            });
        }
    });
</script>
