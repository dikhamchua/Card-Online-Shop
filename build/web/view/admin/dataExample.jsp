<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<div class="card mb-3">
    <div class="card-header">
        <i class="fas fa-table"></i>
        Danh Sách Sản Phẩm
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Loại thẻ</th>
                        <th>Mệnh giá</th>
                        <th>Mã thẻ</th>
                        <th>Mã Seri</th>
                        <th>Ngày hết hạn</th> <!-- Thêm cột này -->
                        <th>Chỉnh sửa</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listProduct}" var="product">
                        <tr>
                            <td name="productID">${product.getID()}</td>
                            <c:forEach items="${listCardType_Price}" var="cp">
                                <c:if test="${product.getCardType_Price() == cp.getID()}">
                                    <c:forEach items="${listCardTypes}" var="ct">
                                        <c:if test="${cp.getCardTypeID() == ct.getID()}">
                                            <td name="CardTypeName">${ct.getCardTypeName()}</td>
                                        </c:if>
                                    </c:forEach>
                                    <c:forEach items="${listPrices}" var="price">
                                        <c:if test="${cp.getPriceID() == price.getID()}">
                                            <td name="price" class="price-format">${price.getPrice()}</td>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                            </c:forEach>
                            <td name="cardCode">${product.getCardCode()}</td>
                            <td name="serialNumber">${product.getSerialNumber()}</td>
                            <td name="expirationDate">
                                <fmt:formatDate value="${product.getExpirationDate()}" pattern="dd/MM/yyyy" /> <!-- Sử dụng phương thức mới -->
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;
                                <button type="button" class="btn btn-danger"
                                        data-toggle="modal"
                                        data-target="#delete-modal"
                                        onclick="deleteProductModal(${product.getID()})">
                                    Xóa
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <!-- Pagination -->
            <div class="row">
                <div class="col-12 d-flex justify-content-center">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <li class="page-item <c:if test="${currentPage == 1}">active</c:if>">
                                    <a class="page-link" href="?page=1">1</a>
                                </li>
                            <c:if test="${beginPage > 2}">
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                </c:if>
                                <c:forEach begin="${beginPage}" end="${endPage}" var="i">
                                    <c:if test="${i > 1 && i < totalPageProduct}">
                                    <li class="page-item <c:if test="${currentPage == i}">active</c:if>">
                                        <a class="page-link" href="?page=${i}">${i}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            <c:if test="${endPage < totalPageProduct - 1}">
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                </c:if>
                            <li class="page-item <c:if test="${currentPage == totalPageProduct}">active</c:if>">
                                <a class="page-link" href="?page=${totalPageProduct}">${totalPageProduct}</a>
                            </li>
                            <li class="page-item <c:if test="${currentPage == totalPageProduct}">disabled</c:if>">
                                <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        let priceElements = document.querySelectorAll('.price-format');
        priceElements.forEach(function (el) {
            let price = parseFloat(el.innerText);
            el.innerText = price.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'}).replace('₫', '');
        });
    });
</script>
