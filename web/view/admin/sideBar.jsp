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
<ul class="sidebar navbar-nav">
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Quản Lí Tài Khoản</span>
        </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/statistics">
            <i class="fas fa-fw fa-money-bill"></i>
            <span>Thống Kê</span>
        </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/dashboardCategory">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Quản Lí Loại Thẻ</span></a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboardcard">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Quản Lý Kho</span></a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/dashboardStorage">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Quản Lý Số Lượng Sản Phẩm</span></a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/dashboardCouponType">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Quản Lý Chương Trình Giảm Giá</span></a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/dashboardCoupon">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Quản Lý Phiếu Giảm Giá</span></a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/dashboardOrder">
            <i class="fas fa-fw fa-table"></i>
            <span>Quản Lý Đơn Hàng</span>
        </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/transactionHistory">
            <i class="fas fa-fw fa-money-bill"></i>
            <span>Lịch Sử Giao Dịch</span>
        </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/addMoney">
            <i class="fas fa-fw fa-money-bill"></i>
            <span>Thêm/Trừ Tiền Thủ Công</span>
        </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/activityLog">
            <i class="fas fa-fw fa-history"></i>
            <span>Lịch Sử Hoạt Động</span>
        </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/manageFeedbacks">
            <i class="fas fa-fw fa-envelope"></i>
            <span>Danh Sách Yêu Cầu Hỗ Trợ</span></a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/dashboardReview">
            <i class="fas fa-fw fa-users"></i>
            <span>Danh Sách Người Đánh Giá</span>
        </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/CardListServlet">
            <i class="fas fa-fw fa-box"></i>
            <span>Tổng Quan Chất Lượng Sản Phẩm</span>
        </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/news">
            <i class="fas fa-fw fa-newspaper"></i>
            <span>Quản Lí Trang Tin Tức</span>
        </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/slider">
            <i class="fas fa-fw fa-newspaper"></i>
            <span>Quản Lí Banner Quảng Cáo</span>
        </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/notifyUsers">
            <i class="fas fa-fw fa-box"></i>
            <span>Thông báo cho khách hàng</span>
        </a>
    </li>
</ul>
