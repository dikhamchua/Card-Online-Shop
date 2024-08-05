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
<div class="modal fade" id="editCustomerModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editBookModalLabel">Thay đổi mật khẩu</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editBookForm" action="/admin/dashboard?action=change-password-admin" method="POST">
                    <!--id-->
                    <div class="form-group" >
                        <label for="name">Tài khoản:</label>
                        <input type="text" class="form-control" id="UserName" name="UserName" readonly="">
                    </div>
                    <!--Name-->
                    <div class="form-group">
                        <label for="name">Mật khẩu mới:</label>
                        <input type="text" class="form-control" id="password" name="password" required="">
                        <div id="nameEditError" class="error"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary" form="editBookForm"
                        onclick="validateForm2()">Đồng ý</button>
            </div>
        </div>
    </div>
</div>

<script>
    // Hàm để đặt tên người dùng khi modal được hiển thị
    function editModal(button) {
        var username = $(button).data('username');
        $('#UserName').val(username);
        console.log("CustomerName: " + username);
    }

    function validateForm2() {
        alert("Thay đổi thành công");
        return true;
    }
</script>
