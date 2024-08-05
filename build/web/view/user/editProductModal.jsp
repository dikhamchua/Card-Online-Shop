<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                <form id="editProductForm" action="dashboard?action=edit" method="POST" enctype="multipart/form-data">                   
                    <!--TypeID-->
                    <div class="form-group">
                        <label for="tidEditInput">TypeID:</label>
                        <select class="custom-select" id="tidEditInput" name="typeID">
                            <c:forEach items ="${listCategory}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                        <div id="tidEditError" class="error"></div>
                    </div>
                    <!--Product id-->
                    <div class="form-group" style="display: none">
                        <input type="text" class="form-control" id="idEditInput" name="id">
                    </div>     
                    <!--Name-->
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" class="form-control" id="nameEditInput" name="productName">
                        <div id="nameEditError" class="error"></div>
                    </div>                    
                    <!--Price-->
                    <div class="form-group">
                        <label for="price">Price:</label>
                        <input type="text" class="form-control" id="priceEditInput" name="price">
                        <div id="priceEditError" class="error"></div>
                    </div>
                    <!--Quantity-->
                    <div class="form-group">
                        <label for="quantity">Quantity:</label>
                        <input type="text" class="form-control" id="quantityEditInput" name="quantity">
                        <div id="quantityEditError" class="error"></div>
                    </div>                  
                    <!--Image-->
                    <div class="form-group">
                        <label for="image">Image: </label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">Upload</span>
                            </div>
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="imageEdit" name="image"
                                       onchange="displayImage2(this)">
                                <label class="custom-file-label">Choose file</label>
                            </div>
                        </div>
                        <img id="previewImage2" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="Preview"
                             style="display: none; max-width: 300px; max-height: 300px;">
                        <input type="hidden" id="currentImage" name="currentImage" value="">
                    </div>
                </form>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary" form="editBookForm"
                                onclick="validateForm2()">Update</button>
                    </div>
            </div>
        </div>
    </div>

    <script>
        function validateForm2() {
            let pid = $('#pidEditInput').val();
            let tid = $('#tidEditInput').val();
            let name = $('#nameEditInput').val();           
            let price = $('#priceEditInput').val();
            let quantity = $('#quantityEditInput').val();

            //xoá thông báo lỗi hiện tại
            $('.error').html('');            
            
            if (tid === '') {
                $('#nameEditError').html('Loại sản phẩm không được để trống');
            }
            
            if (name === '') {
                $('#nameEditError').html('Tên sản phẩm không được để trống');
            }
          
            if (price === '') {
                $('#priceEditError').html('Giá của sản phẩm không được để trống');
            } else if (!$.isNumeric(price) || parseFloat(price) < 0) {
                $('#priceEditError').html('Giá của sản phẩm phải là số và không được nhỏ hơn 0');
            }

            if (quantity === '') {
                $('#quantityEditError').html('Số lượng sản phẩm không được để trống');
            } else if (!$.isNumeric(quantity) || parseInt(price) < 0) {
                $('#priceEditError').html('Số lượng của sản phẩm phải là số và không được nhỏ hơn 0');
            }

            // Kiểm tra nếu không có lỗi thì submit form
            let error = '';
            $('.error').each(function () {
                error += $(this).html();
            });
            if (error === '') {
                $('#editProductForm').submit();
            } else {
                event.preventDefault();
            }
        }

        function displayImage2(input) {
            var previewImage = document.getElementById("previewImage2");
            var file = input.files[0];
            var reader = new FileReader();

            reader.onload = function (e) {
                previewImage.src = e.target.result;
                previewImage.style.display = "block";
            }

            reader.readAsDataURL(file);
        }

        function editModal(element) {
            // Lấy hàng của bảng mà người dùng đã bấm vào
            let row = $(element).closest('tr');

            // Trích xuất dữ liệu sử dụng thuộc tính 'name'
            let productID = row.find('td[name="productID"]').text();
            let typeID = row.find('td[name="typeID"]').text();
            let productName = row.find('td[name="productName"]').text();
            let price = row.find('td[name="price"]').text();
            let stockQuantity = row.find('td[name="stockQuantity"]').text();
            let imageSrc = row.find('td[name="image"] img').attr('src');

            // Thiết lập dữ liệu cho các trường trong modal
            $('#idEditInput').val(productID);
            $('#nameEditInput').val(productName);
            $('#priceEditInput').val(price);
            $('#quantityEditInput').val(stockQuantity);
            $('#categoryEditInput').val(typeID);
            $('#previewImage2').attr('src', imageSrc).css('display', 'block');
            $('#currentImage').val(imageSrc);

            // Hiển thị modal
            $('#editProductModal').modal('show');
        }


    </script>
