<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
<div class="modal fade" id="editProductModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editProductModalLabel">Edit Product</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editProductForm" action="dashboardcard?action=edit" method="POST" enctype="multipart/form-data">   
                     
                    <div class="form-group">
                        <label for="idEditInput">ID:</label>
                        <input type="text" class="form-control" id="idEditInput" name="ID" readonly="" >
                        <div id="idEditError" class="error"></div>
                    </div>

                    <!-- Name -->
                            <div class="form-group">
                        <label for="category">Loại thẻ: </label>
                        <div class="input-group">
                            <select class="custom-select" id="categoryEditInput" name="cardtypeid">
                                <c:forEach items="${listCardTypes}" var="c">
                                    <option value="${c.getID()}">${c.getCardTypeName()}</option>
                                </c:forEach>
                            </select>
                            
                        </div>
                    </div>
                    
                    <!-- Price -->
                    <div class="form-group">
                        <label for="priceEditInput">Mệnh giá: </label>
                        <input type="text" class="form-control" id="priceEditInput" name="price">
                        <div id="priceEditError" class="error"></div>
                    </div>
                    <!-- Serial Number -->
                    <div class="form-group">
                        <label for="serialNumberEditInput">Mã thẻ:</label>
                        <input type="text" class="form-control" id="serialNumberEditInput" name="serialNumber">
                        <div id="serialNumberEditError" class="error"></div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary" form="editProductForm" onclick="validateForm2(event)">Đồng ý</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function validateForm2(event) {
        let id = $('#idEditInput').val();
        let serialNumber = $('#serialNumberEditInput').val();
        let name = $('#nameEditInput').val();
        let price = $('#priceEditInput').val();

        // Xoá thông báo lỗi hiện tại
        $('.error').html('');

        let valid = true;

        // Kiểm tra các trường
        if (id === '') {
            $('#idEditError').html('Không được để trống');
            valid = false;
        }

        if (serialNumber === '') {
            $('#serialNumberEditError').html('Số serial không được để trống');
            valid = false;
        }

        if (name === '') {
            $('#nameEditError').html('Tên sản phẩm không được để trống');
            valid = false;
        }

        if (price === '') {
            $('#priceEditError').html('Giá của sản phẩm không được để trống');
            valid = false;
        } else if (!$.isNumeric(price) || parseFloat(price) < 0) {
            $('#priceEditError').html('Giá của sản phẩm phải là số và không được nhỏ hơn 0');
            valid = false;
        }

        // Kiểm tra nếu không có lỗi thì submit form
        if (!valid) {
            event.preventDefault();
        } else {
            $('#editProductForm').submit();
        }
    }

    function editModal(element) {
        // Lấy hàng của bảng mà người dùng đã bấm vào
        let row = $(element).closest('tr');

        // Trích xuất dữ liệu sử dụng thuộc tính 'name'
        let productID = row.find('td[name="productID"]').text();
        let categoryText = row.find('td[name="CardTypeName"]').text().trim();
        let serialNumber = row.find('td[name="serialNumber"]').text();
        let productName = row.find('td[name="productName"]').text();
        let price = row.find('td[name="price"]').text();
        

        // Thiết lập dữ liệu cho các trường trong modal
        $('#idEditInput').val(productID);
        $('#categoryEditInput option').each(function() {
            if ($(this).text() === categoryText) {
                $(this).prop('selected', true);
            }
        });
        $('#serialNumberEditInput').val(serialNumber);
        $('#nameEditInput').val(productName);
        $('#priceEditInput').val(price);
        

        // Hiển thị modal
        $('#editProductModal').modal('show');
    }
</script>

