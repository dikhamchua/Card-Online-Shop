<%@page contentType="text/html" pageEncoding="UTF-8"%>
<ul class="sidebar navbar-nav">
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard?action=profile">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Thông Tin Tài khoản</span>
        </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard?action=change-password-user">
            <i class="fas fa-fw fa-table"></i>
            <span>Đổi Mật Khẩu</span></a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="UserOrdersServlet">
            <i class="fas fa-fw fa-table"></i>
            <span>Đơn Hàng Của Tôi</span></a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="ActivityLogServlet">
            <i class="fas fa-fw fa-history"></i>
            <span>Lịch Sử Hoạt Động</span></a>
    </li>
    
</ul>
