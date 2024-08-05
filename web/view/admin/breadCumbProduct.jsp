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
<ol class="breadcrumb">
    <li class="breadcrumb-item">
        <a href="#">Quản lý kho</a>
    </li>
    <li class="breadcrumb-item ml-auto">
        <button class="btn btn-success" type="button" data-toggle="modal" data-target="#addProductModal">
            <i class="fas fa-plus"></i> Thêm sản phẩm
        </button>
        <button class="btn btn-success ml-3" type="button" data-toggle="modal" data-target="#uploadExcelModal">
            <i class="fas fa-upload"></i> Tải lên Excel
        </button>
    </li>
</ol>
