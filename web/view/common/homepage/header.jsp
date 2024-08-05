<%-- 
    Document   : header
    Created on : Jun 4, 2024, 9:55:24 AM
    Author     : Tom
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>



<!-- Header start  -->
<header class="gi-header bg-[#FFFAFA] z-[14] max-[991px]:z-[16] relative">
    <!-- Header Bottom  Start -->
    <div class="gi-header-bottom py-[5px] max-[991px]:py-[15px] max-[991px]:border-b-[1px] border-solid border-[#eee]">
        <div class="flex flex-wrap justify-between relative items-center mx-auto min-[1600px]:max-w-[1600px] min-[1400px]:max-w-[1320px] min-[1200px]:max-w-[1140px] min-[992px]:max-w-[960px] min-[768px]:max-w-[720px] min-[576px]:max-w-[540px]">
            <div class="w-full flex flex-wrap px-[12px]">
                <div class="gi-flex flex flex-row justify-between w-full max-[575px]:flex-col">
                    <!-- Header Logo Start -->
                    <div class="self-center gi-header-logo max-[575px]:mb-[15px]">
                        <div class="header-logo text-left">
                            <a href="home"><img src="${pageContext.request.contextPath}/assets/img/logo/logo1001.jpg" alt="Site Logo" class="w-[144px] max-[1199px]:w-[130px] max-[991px]:w-[120px] max-[767px]:w-[100px] "></a>
                        </div>
                    </div>
                    <!-- Header Logo End -->


                    <!-- Header Button Start -->
                    <div class="gi-header-action self-center max-[991px]:hidden">
                        <div class="gi-header-bottons flex justify-end">
                            <c:if test="${users != null}">
                                <!-- Notification -->
                                <div class="gi-acc-drop relative">
                                    <div class="gi-header-btn-container flex justify-around items-center w-full">
                                        <a href="notifications" class="gi-header-btn gi-header-user dropdown-toggle gi-user-toggle transition-all duration-[0.3s] ease-in-out flex text-[#4b5966] items-center whitespace-nowrap">
                                            <div class="gi-btn-desc flex flex-col uppercase ml-[10px]">
                                                <span class="gi-btn-title transition-all duration-[0.3s] ease-in-out text-[12px] leading-[1] text-[#FF1493] mb-[6px] tracking-[0.6px] capitalize font-medium" style="font-size: medium">
                                                    <i class="fas fa-bell" style="color: #FF1493; font-size: 16px;"></i> Thông Báo
                                                    <c:if test="${unreadCount > 0}">
                                                        (${unreadCount})
                                                    </c:if>
                                                </span>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </c:if>
                            <!-- Header User Start -->
                            <c:if test="${users == null}">
                                <!-- LOGIN -->
                                <div class="gi-acc-drop relative">
                                    <a href="authen?action=login" class="gi-header-btn gi-header-user dropdown-toggle gi-user-toggle mr-[30px] transition-all duration-[0.3s] ease-in-out relative flex text-[#4b5966] w-[auto] items-center whitespace-nowrap">
                                        <div class="gi-btn-desc flex flex-col uppercase ml-[10px]">
                                            <span class="gi-btn-title transition-all duration-[0.3s] ease-in-out text-[12px] leading-[1] text-[#FF1493] mb-[6px] tracking-[0.6px] capitalize font-medium" style="font-size: medium"><i class="fas fa-user" style="color: #FF1493; font-size: 16px;"></i> Đăng Nhập</span>
                                        </div>
                                    </a>
                                </div>    
                            </c:if>
                            <c:if test="${users != null}">
                                <!-- Wallet -->
                                <!--                                <div class="gi-acc-drop relative">
                                                                        <div class="gi-header-btn-container flex justify-around items-center w-full">
                                                                            <a href="#" class="gi-header-btn gi-header-user dropdown-toggle gi-user-toggle transition-all duration-[0.3s] ease-in-out flex text-[#4b5966] items-center whitespace-nowrap">
                                                                                <div class="gi-btn-desc flex flex-col uppercase ml-[10px]">
                                                                                    <span class="gi-btn-title transition-all duration-[0.3s] ease-in-out text-[12px] leading-[1] text-[#FF1493] mb-[6px] tracking-[0.6px] capitalize font-medium" style="font-size: medium">
                                                                                        <i class="fas fa-dollar-sign" style="color: #FF1493; font-size: 16px;"></i> Số dư tài khoản: 100.000đ
                                                                                    </span>
                                                                                </div>
                                                                            </a>
                                                                        </div>
                                                                </div>    -->
                                <!-- Management -->
                                <c:if test="${users.getRoleID() == 1}">
                                    <div class="gi-acc-drop relative" style="margin-right: 10px;">
                                        <div class="gi-header-btn-container flex justify-around items-center w-full">
                                            <a href="admin/dashboard?action=profile" class="gi-header-btn gi-header-user dropdown-toggle gi-user-toggle transition-all duration-[0.3s] ease-in-out flex text-[#4b5966] items-center whitespace-nowrap">
                                                <div class="gi-btn-desc flex flex-col uppercase ml-[10px]">
                                                    <span class="gi-btn-title transition-all duration-[0.3s] ease-in-out text-[12px] leading-[1] text-[#FF1493] mb-[6px] tracking-[0.6px] capitalize font-medium" style="font-size: medium">
                                                        <i class="fas fa-cogs" style="color: #FF1493; font-size: 16px;"></i> Quản Lí
                                                    </span>
                                                </div>
                                            </a>
                                        </div>    
                                    </div>
                                </c:if>
                                <div class="gi-acc-drop relative">
                                    <div class="gi-header-btn-container flex justify-around items-center w-full">
                                        <a href="feedback" class="gi-header-btn gi-header-user dropdown-toggle gi-user-toggle transition-all duration-[0.3s] ease-in-out flex text-[#4b5966] items-center whitespace-nowrap"> 
                                            <span class="gi-btn-title transition-all duration-[0.3s] ease-in-out text-[12px] leading-[1] text-[#FF1493] mb-[6px] tracking-[0.6px] capitalize font-medium" style="font-size: medium">
                                                <i class="fas fa-comment-dots" style="color: #FF1493; font-size: 16px;"></i> Hỗ Trợ
                                            </span>
                                        </a>
                                    </div>    
                                </div>
                                <!-- MY ACCOUNT -->
                                <div class="gi-acc-drop relative">
                                    <div class="gi-header-btn-container flex justify-around items-center w-full">
                                        <a href="dashboard?action=profile" class="gi-header-btn gi-header-user dropdown-toggle gi-user-toggle transition-all duration-[0.3s] ease-in-out flex text-[#4b5966] items-center whitespace-nowrap">
                                            <div class="gi-btn-desc flex flex-col uppercase ml-[10px]">
                                                <span class="gi-btn-title transition-all duration-[0.3s] ease-in-out text-[12px] leading-[1] text-[#FF1493] mb-[6px] tracking-[0.6px] capitalize font-medium" style="font-size: medium">
                                                    <i class="fas fa-user" style="color: #FF1493; font-size: 16px;"></i> Tài Khoản <i class="fas fa-caret-down" style="color: #FF1493"></i>
                                                </span>
                                            </div>
                                        </a>
                                    </div>
                                    <ul class="gi-dropdown-menu min-w-[150px] py-[5px] transition-all duration-[0.3s] ease-in-out mt-[25px] absolute z-[16] text-left bg-[#fff] block opacity-0 invisible left-[0] right-[auto] border-[1px] border-solid border-[#eee] rounded-[5px]" style="min-width: auto; white-space: nowrap;">
                                        <!-- Wallet -->
                                        <li>
                                            <a class="dropdown-item py-[10px] px-[20px] block w-full font-normal text-[16px] text-[#FF1493] hover:bg-transparent hover:text-[#5caf90]" style="font-size: medium" href="addWallet">
                                                <i class="fas fa-dollar-sign" style="color: #FF1493; font-size: 16px;"></i> Số dư tài khoản: <fmt:formatNumber value="${sessionScope.wallet.getWallet()}" minFractionDigits="0"/> VNĐ
                                            </a>
                                        </li>
                                        <!-- MY ACCOUNT -->
                                        <li>
                                            <a class="dropdown-item py-[10px] px-[20px] block w-full font-normal text-[16px] text-[#FF1493] hover:bg-transparent hover:text-[#5caf90]" style="font-size: medium" href="dashboard?action=profile">
                                                <i class="fas fa-user" style="color: #FF1493; font-size: 16px;"></i> Thông tin cá nhân
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item py-[10px] px-[20px] block w-full font-normal text-[16px] text-[#FF1493] hover:bg-transparent hover:text-[#5caf90]" style="font-size: medium" href="UserOrdersServlet">
                                                <i class="fas fa-history" style="color: #FF1493; font-size: 16px;"></i> Đơn Hàng Của Bạn 
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item py-[10px] px-[20px] block w-full font-normal text-[16px] text-[#FF1493] hover:bg-transparent hover:text-[#5caf90]" style="font-size: medium" href="historyWallet">
                                                <i class="fas fa-history" style="color: #FF1493; font-size: 16px;"></i> Lịch sử giao dịch 
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item py-[10px] px-[20px] block w-full font-normal text-[16px] text-[#FF1493] hover:bg-transparent hover:text-[#5caf90]" style="font-size: medium" href="historyReview">
                                                <i class="fas fa-star" style="color: #FF1493; font-size: 16px;"></i> Lịch sử đánh giá
                                            </a>
                                        </li>
                                        <!-- LOGOUT -->
                                        <li>
                                            <a class="dropdown-item py-[10px] px-[20px] block w-full font-normal text-[16px] text-[#FF1493] hover:bg-transparent hover:text-[#5caf90]" style="font-size: medium" href="authen?action=log-out">
                                                <i class="fas fa-sign-out-alt" style="color: #FF1493; font-size: 16px;"></i> Đăng xuất
                                            </a>
                                        </li>
                                    </ul>
                                </div> 
                            </c:if>
                            <!-- Cart  -->
                            <div class="gi-acc-drop relative">
                                <div class="gi-header-btn-container flex justify-around items-center w-full">  
                                    <a href="payment" class="gi-header-btn gi-header-user dropdown-toggle gi-user-toggle transition-all duration-[0.3s] ease-in-out flex text-[#4b5966] items-center whitespace-nowrap">
                                        <div class="gi-btn-desc flex flex-col uppercase ml-[10px]">
                                            <span class="gi-btn-title transition-all duration-[0.3s] ease-in-out text-[12px] leading-[1] text-[#FF1493] mb-[6px] tracking-[0.6px] capitalize font-medium" style="font-size: medium"><i class="fas fa-shopping-cart" style="color: #FF1493; font-size: 16px;"></i> Giỏ Hàng</span>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <!-- Header User End -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Header Button End -->

    <!-- Header menu -->
    <div class="gi-header-cat transition-all duration-[0.3s] ease-in-out bg-[#FFFAFA] border-t-[1px] border-b-[1px] border-solid border-[#eee] hidden min-[992px]:block">
        <div class="flex flex-wrap justify-between items-center mx-auto min-[1600px]:max-w-[1600px] min-[1400px]:max-w-[1320px] min-[1200px]:max-w-[1140px] min-[992px]:max-w-[960px] min-[768px]:max-w-[720px] min-[576px]:max-w-[540px] relative">
            <div class="gi-nav-bar flex flex-row justify-between relative w-full px-[12px]">
                <!-- Main Menu Start -->
                <div id="gi-main-menu-desk" class="w-full flex items-center min-[992px]:block hidden">
                    <div class="nav-desk">
                        <div class="w-full flex flex-wrap px-[12px] min-[1400px]:relative">
                            <div class="basis-auto w-full self-center">
                                <div class="gi-main-menu flex">
                                    <ul class="w-full flex justify-center flex-wrap pl-[0]">
                                        <li class="dropdown drop-list relative ml-[20px] mr-[30px] transition-all duration-[0.3s] ease-in-out max-[1199px]:ml-[15px]">
                                            <a href="home" class="dropdown-arrow relative transition-all duration-[0.3s] ease-in-out text-[15px] leading-[60px] capitalize text-[#FF1493] flex items-center font-medium" style="font-size: larger">
                                                <i class="fas fa-home" style="margin-right: 8px;"></i>  Trang Chủ
                                            </a>
                                        </li>
                                        <li class="dropdown drop-list relative ml-[20px] mr-[30px] transition-all duration-[0.3s] ease-in-out max-[1199px]:ml-[15px]">
                                            <a href="news" class="dropdown-arrow relative transition-all duration-[0.3s] ease-in-out text-[15px] leading-[60px] capitalize text-[#FF1493] flex items-center font-medium" style="font-size: larger">
                                                <i class="fas fa-newspaper" style="margin-right: 8px;"></i>  Tin tức
                                            </a>
                                        </li>
                                        <li class="dropdown drop-list relative ml-[20px] mr-[30px] transition-all duration-[0.3s] ease-in-out max-[1199px]:ml-[15px]">
                                            <a href="home?action=buy-card" class="dropdown-arrow relative transition-all duration-[0.3s] ease-in-out text-[15px] leading-[60px] capitalize text-[#FF1493] flex items-center font-medium" style="font-size:larger "> 
                                                <i class="fas fa-gamepad" style="margin-right: 8px;"></i>  Mua Thẻ
                                            </a>
                                        </li>
                                        <c:if test="${users != null}">
                                            <li class="dropdown drop-list relative ml-[20px] mr-[30px] transition-all duration-[0.3s] ease-in-out max-[1199px]:ml-[15px]">
                                                <a href="addWallet" class="dropdown-arrow relative transition-all duration-[0.3s] ease-in-out text-[15px] leading-[60px] capitalize text-[#FF1493] flex items-center font-medium" style="font-size:larger "> 
                                                    <i class="fas fa-dollar-sign" style="margin-right: 8px;"></i>  Nạp tiền 
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Header menu End -->
</header>
<!-- Header End  -->
