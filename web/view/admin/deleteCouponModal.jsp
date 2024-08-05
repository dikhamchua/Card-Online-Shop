<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
<div class="modal fade" id="deleteCouponModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteCouponModalLabel">Xóa coupon</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="deleteCouponForm" action="${pageContext.request.contextPath}/dashboardCoupon?action=delete" method="POST">
                    <!-- ID -->
                    <div class="form-group" style="display: none">
                        <input type="text" class="form-control" id="idDeleteInput" name="ID">
                    </div>
                    <p>Bạn có chắc chắn muốn xóa coupon này không?</p>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-danger" form="deleteCouponForm">Xóa</button>
            </div>
        </div>
    </div>
</div>

<script>
    function deleteCouponModal(button) {
        let id = $(button).closest('tr').find('td[name="id"]').text().trim();
        $('#idDeleteInput').val(id);
    }
</script>
