<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <title>CardLord-Trading All Card</title>
        <meta name="keywords" content="tailwindcss, ecommerce, farming, food market, grocery market, grocery shop, grocery store, grocery supper market, multi vendor, organic food, supermarket, supermarket grocery">
        <meta name="description" content="Multipurpose eCommerce Tailwind CSS Template">
        <meta name="author" content="Maraviya Infotech">

        <!-- site Favicon -->
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">

        <!-- css Icon Font -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vendor/gicons.css">

        <!-- css All Plugins Files -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/animate.css">   
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/swiper-bundle.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/owl.theme.default.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/slick.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/nouislider.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!-- Main Style -->
        <link rel="stylesheet" id="main_style" href="${pageContext.request.contextPath}/assets/css/demo-1.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css">
        <link rel="stylesheet" id="main_style" href="${pageContext.request.contextPath}/assets/css/style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,30...lay=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
        </style>
        <style>
            body {
                background-color: #FFFFFF; /* White */
            }

            .gi-btn-2, .gi-btn-fullwidth {
                background: linear-gradient(to right, #FF69B4, #FF1493) !important;
                transition: all 0.3s ease;
            }

            .gi-btn-2:hover, .gi-btn-fullwidth:hover {
                background: linear-gradient(to right, #FF1493, #FF69B4) !important; /* Reverse Pink Gradient */
            }

            .gi-sidebar-wrap {
                border-color: #FFFFFF !important; /* White */
                box-shadow: 0 0 10px rgba(255, 105, 180, 0.1);
            }
            .cart-table-content table {
                border-collapse: separate;
                border-spacing: 0 10px;
                background-color: #FFFFFF; /* White background for table */
            }

            .cart-table-content tbody tr {
                box-shadow: 0 2px 5px rgba(255, 105, 180, 0.1);
                transition: all 0.3s ease;
                background-color: #FFFFFF; /* White background for rows */
            }

            .cart-table-content tbody tr:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(255, 105, 180, 0.2);
            }

            .quantity-container {
                border-color: #FF69B4;
            }

            .btn-increase, .btn-decrease {
                background-color: #FFFFFF;
                color: #FF1493;
            }

            .gi-sidebar-title {
                color: #FF1493;
                border-bottom: 2px solid #FF69B4;
                padding-bottom: 10px;
                font-size: 24px;
                margin-bottom: 20px;
            }

            input[type="text"], input[type="email"] {
                border-color: #FFC0CB;
                transition: all 0.3s ease;
            }

            input[type="text"]:focus, input[type="email"]:focus {
                border-color: #FF69B4;
                box-shadow: 0 0 5px rgba(255, 105, 180, 0.5);
            }

            .gi-cart-coupan-content {
                margin-top: 20px;
            }

            .gi-btn-fullwidth {
                width: 100%;
            }

            .quantity-container {
                border: 1px solid #FF69B4;
                border-radius: 5px;
                overflow: hidden;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 84px;
                margin: 0 auto;
            }

            .quantity-input {
                border: none;
                text-align: center;
                width: 40px;
                outline: none;
                font-weight: bold;
                height: 35px;
                line-height: 35px;
                background-color: #FFFFFF; /* White background for input */
                color: #FF1493; /* Pink text */
            }

            .btn-increase, .btn-decrease {
                border: none;
                cursor: pointer;
                width: 20px;
                height: 17.5px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
            }

            .btn-increase:hover, .btn-decrease:hover {
                background-color: #FF69B4;
                color: white;
            }

            .gi-cart-summary-total {
                background-color: #FFFFFF; /* White */
                padding: 15px;
                border-radius: 5px;
                margin-top: 20px;
            }
            .gi-cart-pro-name a {
                color: #FF1493;
                font-weight: 500;
            }

            .gi-cart-pro-remove a {
                color: #FF69B4;
            }

            .gi-cart-pro-remove a:hover {
                color: #FF1493;
            }

            .success-message {
                background-color: #FFEBF0; /* Light Pink background */
                padding: 10px 20px; /* Reduced padding */
                border-radius: 8px;
                text-align: center;
                color: #FF69B4; /* Pink color */
                font-size: 18px;
                font-weight: bold;
                margin: 20px auto; /* Center horizontally */
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                max-width: 500px; /* Reduced max width */
            }

            .error-message {
                background-color: #FFE6E6; /* Light Red background */
                padding: 10px 20px; /* Reduced padding */
                border-radius: 8px;
                text-align: center;
                color: #FF3333; /* Red color */
                font-size: 18px;
                font-weight: bold;
                margin: 20px auto; /* Center horizontally */
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                max-width: 500px; /* Reduced max width */
            }

        </style>
    </head>
    <body class="w-full h-full relative font-Poppins font-normal overflow-x-hidden">
        <!-- Header start  -->
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>

            <!-- Success message -->
        <c:if test="${not empty successMessage}">
            <div class="success-message">
                ${successMessage}
            </div>
        </c:if>

        <!-- Error message -->
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                ${errorMessage}
            </div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>
        <!-- Error message for coupon -->
        <c:if test="${not empty sessionScope.couponError}">
            <div class="error-message">
                ${sessionScope.couponError}
            </div>
            <c:remove var="couponError" scope="session"/>
        </c:if>


        <!-- Cart section -->
        <section class="gi-cart-section py-[40px] max-[767px]:py-[30px]">
            <h2 class="hidden">Cart Page</h2>
            <div class="flex flex-wrap justify-between items-center mx-auto min-[1600px]:max-w-[1600px] min-[1400px]:max-w-[1320px] min-[1200px]:max-w-[1140px] min-[992px]:max-w-[960px] min-[768px]:max-w-[720px] min-[576px]:max-w-[540px] relative">
                <div class="flex flex-wrap w-full">
                    <!-- Sidebar Area Start -->
                    <div class="gi-cart-rightside min-[992px]:w-[33.33%] w-full px-[12px]">
                        <div
                            class="gi-sidebar-wrap p-[15px] rounded-[5px] border-[1px] border-solid border-white mb-[0] shadow-lg">
                            <!--Sidebar Summary Block--> 
                            <div class="gi-sidebar-block">
                                <div class="gi-sb-title">
                                    <h3 class="gi-sidebar-title">Chi tiết giao dịch</h3>
                                </div>
                                <div class="gi-sb-block-content mb-[0] border-b-[0] mt-[15px]">
                                    <div class="gi-cart-summary-bottom">
                                        <div class="gi-cart-summary">
                                            <div
                                                class="gi-cart-summary-total border-t-[1px] border-solid border-[#333] pt-[19px] mb-[0] mt-[16px] flex justify-between items-center">
                                                <span
                                                    class="text-left text-[#FF1493] text-[18px] leading-[24px] tracking-[0]">
                                                    Tổng tiền thẻ
                                                </span>
                                                <span id="subtotal" class="price-format text-[#FF1493] text-[18px] leading-[24px] font-medium">
                                                    ${finalAmount}
                                                </span>
                                            </div>
                                            <c:if test="${couponApplied}">
                                                <div class="gi-cart-summary-total border-t-[1px] border-solid border-[#333] pt-[19px] mb-[0] mt-[16px] flex justify-between items-center">
                                                    <span class="text-left text-[#FF1493] text-[18px] leading-[24px] tracking-[0]">
                                                        Phần trăm giảm giá
                                                    </span>
                                                    <span id="discountPercent" class="price-format text-[#FF1493] text-[18px] leading-[24px] font-medium">
                                                        <c:if test="${discountPercent != null}"  >
                                                            ${discountPercent}%
                                                        </c:if>

                                                    </span></div>
                                                <div class="gi-cart-summary-total border-t-[1px] border-solid border-[#333] pt-[19px] mb-[0] mt-[16px] flex justify-between items-center">
                                                    <span class="text-left text-[#FF1493] text-[18px] leading-[24px] tracking-[0]">
                                                        Số tiền giảm
                                                    </span>
                                                    <span id="couponDiscount" class="price-format text-[#FF1493] text-[18px] leading-[24px] font-medium">
                                                        ${couponDiscount}
                                                    </span>
                                                </div>
                                            </c:if>
                                            <div class="gi-cart-coupan-content mb-[0] mt-[20px]">
                                                <form
                                                    class="gi-cart-coupan-form flex border-[1px] border-solid border-[#FFC0CB] p-[5px] rounded-[5px]"
                                                    name="gi-cart-coupan-form" method="post" action="payment?action=apply-coupon">
                                                    <input
                                                        class="gi-coupan inline-block align-top leading-[35px] h-[40px] text-[#777] text-[14px] w-[80%] border-[0] bg-transparent text-left px-[10px] tracking-[0.5px] outline-[0] rounded-[5px]"
                                                        type="text" placeholder="Nhập mã giảm giá" name="gi-coupan"
                                                        value=""><br>
                                                    <button type="submit"
                                                            class="gi-btn-2 transition-all duration-[0.3s] ease-in-out overflow-hidden text-center relative rounded-[5px] py-[12px] max-[767px]:py-[8px] px-[20px] max-[500px]:px-[15px] bg-gradient-to-r from-pink-500 to-pink-700 text-[#fff] border-[0] text-[16px] max-[500px]:text-[14px] tracking-[0] font-medium inline-flex items-center hover:from-pink-700 hover:to-pink-500 ml-auto"
                                                            name="subscribe" value="">
                                                        Nhập
                                                    </button>
                                                </form>
                                            </div>
                                            <div
                                                class="gi-cart-summary-total border-t-[1px] border-solid border-[#333] pt-[19px] mb-[0] mt-[16px] flex justify-between items-center">
                                                <span class="text-left text-[20px] font-medium text-[#FF1493] leading-[24px] tracking-[0]">
                                                    Số tiền cần thanh toán
                                                </span>
                                                <span id="totalCart" class="price-format text-[20px] font-medium text-[#FF1493] leading-[24px] tracking-[0]">
                                                    ${finalAmount - couponDiscount}
                                                </span>
                                            </div>
                                            <div class="gi-cart-summary-total border-t-[1px] border-solid border-[#333] pt-[19px] mb-[0] mt-[16px] flex justify-between items-center">
                                                <form action="payment?action=checkout" method="post">
                                                    <a href="#" onclick="return this.closest('form').submit()" class="gi-btn-2 gi-btn-fullwidth transition-all duration-[0.3s] ease-in-out overflow-hidden text-center relative rounded-[5px] py-[10px] max-[767px]:py-[6px] px-[15px] max-[767px]:px-[10px] bg-gradient-to-r from-pink-500 to-pink-700 text-[#fff] border-[0] text-[20px] max-[767px]:text-[22px] tracking-[0] font-medium flex justify-center items-center hover:from-pink-700 hover:to-pink-500">
                                                        Thanh toán
                                                    </a>
                                                </form>
                                                <form action="payment" method="get">
                                                    <a href="#" onclick="return this.closest('form').submit()" class="gi-btn-2 transition-all duration-[0.3s] ease-in-out overflow-hidden text-center relative rounded-[5px] py-[10px] max-[767px]:py-[6px] px-[15px] max-[767px]:px-[10px] bg-gradient-to-r from-pink-500 to-pink-700 text-[#fff] border-[0] text-[14px] max-[767px]:text-[13px] tracking-[0] font-medium inline-flex items-center hover:from-pink-700 hover:to-pink-500">
                                                        Quay lại giỏ hàng
                                                    </a>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="gi-cart-leftside min-[992px]:w-[66.66%] w-full px-[12px] max-[991px]:mt-[30px]">
                        <!-- cart content Start -->
                        <div class="gi-cart-content">
                            <div class="gi-cart-inner">
                                <div class="flex flex-wrap w-full">
                                    <div class="w-full"><div class="table-content cart-table-content">
                                            <table class="w-full bg-[#fff] ">
                                                <thead class="max-[767px]:border-[0] max-[767px]:h-[1px] max-[767px]:m-[-1px] max-[767px]:overflow-hidden max-[767px]:p-[0] max-[767px]:absolute max-[767px]:w-[1px]">
                                                    <tr class="bg-[#fff] border-b-[2px] border-solid border-[#FFC0CB]">
                                                        <td class="text-[#FF1493] text-[15px] font-medium pt-[15px] pb-[12px] px-[14px] text-left capitalize align-middle whitespace-nowrap leading-[1] tracking-[0]">
                                                            Product</td>
                                                        <td class="text-[#FF1493] text-[15px] font-medium pt-[15px] pb-[12px] px-[14px] text-left capitalize align-middle whitespace-nowrap leading-[1] tracking-[0]">
                                                            Price</td>
                                                        <td class="text-[#FF1493] text-[15px] font-medium pt-[15px] pb-[12px] px-[14px] text-center capitalize align-middle whitespace-nowrap leading-[1] tracking-[0]">
                                                            Quantity</td>
                                                        <td class="text-[#FF1493] text-[15px] font-medium pt-[15px] pb-[12px] px-[14px] text-left capitalize align-middle whitespace-nowrap leading-[1] tracking-[0]">
                                                            Total</td>
                                                        <td></td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${cart.listCart_Item}" var="ci">
                                                        <%--<c:set var="p" value="" />--%>
                                                        <c:set var="cardtp" value="" />
                                                        <c:set var="cardtype" value=""></c:set>
                                                        <c:set var="price" value=""/>
                                                        <!--get card-->
                                                        <%--<c:forEach items="${listProduct}" var="card">--%>
                                                        <%--<c:if test="${card.getID() == ci.getCardID()}">--%>
                                                        <%--<c:set var="p" value="${card}"></c:set>--%>
                                                        <%--</c:if>--%>
                                                        <%--</c:forEach>--%>
                                                        <!--get card type price--><c:forEach items="${listCardType_Price}" var="ctp">
                                                            <c:if test="${ci.getCardType_Price() == ctp.getID()}">
                                                                <c:set var="cardtp" value="${ctp}" />
                                                            </c:if>
                                                        </c:forEach>
                                                        <c:forEach items="${listCardType}" var="ct"> 
                                                            <c:if test="${cardtp.getCardTypeID() == ct.getID()}">
                                                                <c:set var="cardtype" value="${ct}"></c:set>
                                                            </c:if>
                                                        </c:forEach>
                                                        <c:forEach items="${listPrice}" var="priceObj">
                                                            <c:if test="${cardtp.getPriceID() == priceObj.getID()}">
                                                                <c:set var="price" value="${priceObj}"/>
                                                            </c:if>
                                                        </c:forEach>
                                                        <!--get price-->
                                                        <tr class="border-b-[1px] border-solid border-[#FFC0CB] max-[767px]:border-[1px] max-[767px]:block max-[767px]:mb-[15px]">
                                                            <!--Name and image of card type-->
                                                            <td data-label="Product" class="gi-cart-pro-name w-[40%] text-[#FF1493] text-[16px] py-[15px] px-[14px] text-left max-[767px]:w-full max-[767px]:border-b-[1px] max-[767px]:border-solid max-[767px]:border-[#FFC0CB] max-[767px]:flex max-[767px]:justify-between max-[767px]:items-center max-[767px]:text-[14px] max-[767px]:py-[8px] max-[767px]:px-[10px]">
                                                                <a href="#" class="text-[#FF69B4] font-normal text-[14px] flex leading-[1.5] tracking-[0.6px] items-center">
                                                                    <img class="gi-cart-pro-img w-[60px] mr-[15px]" src="${cardtp.getImageDetail()}" alt="">
                                                                    Thẻ ${cardtype.getCardTypeName()}
                                                                </a>
                                                            </td>
                                                            <!--Price--><td data-label="Price" class="gi-cart-pro-price text-[#FF1493] font-medium text-[15px] py-[15px] px-[14px] text-left max-[767px]:border-b-[1px] max-[767px]:border-solid max-[767px]:border-[#FFC0CB] max-[767px]:flex max-[767px]:justify-between max-[767px]:items-center max-[767px]:text-[14px] max-[767px]:py-[8px] max-[767px]:px-[10px]">
                                                                <span class="price-format"> ${price.getPrice()}</span>
                                                            </td>
                                                            <!--Quantity-->
                                                            <!--                                                            <td data-label="Quantity" class="gi-cart-pro-qty text-[#FF1493] text-[16px] py-[15px] px-[14px] text-center max-[767px]:border-b-[1px] max-[767px]:border-solid max-[767px]:border-[#FFC0CB] max-[767px]:flex max-[767px]:justify-between max-[767px]:items-center max-[767px]:text-[14px] max-[767px]:py-[8px] max-[767px]:px-[10px]">
                                                                                                                            <form action="payment?action=change-quantity" method="post">
                                                                                                                                <div class="quantity-container border-[1px] border-solid border-[#FF69B4] rounded-[5px] overflow-hidden flex items-center justify-between w-[84px] mx-auto">
                                                                                                                                    <input type="hidden" name="id" value="${cardtp.getID()}">
                                                                                                                                    <input class="quantity-input text-[#FF1493] text-[14px] text-center w-[40px] outline-none font-semibold" 
                                                                                                                                           type="text" name="quantity" value="${ci.getQuantity()}">
                                                                                                                                    <div class="flex flex-col">
                                                                                                                                        <button type="button" class="btn-increase px-2 py-1" onclick="increaseQuantity(this)">&#9650;</button>
                                                                                                                                        <button type="button" class="btn-decrease px-2 py-1" onclick="decreaseQuantity(this)">&#9660;</button>
                                                                                                                                    </div>/-strong/-heart:>:o:-((:-h</div>
                                                                                                                            </form>
                                                                                                                        </td>-->
                                                            <!--Quantity-->
                                                            <td data-label="Quantity" class="gi-cart-pro-qty text-[#FF1493] text-[16px] py-[15px] px-[14px] text-center max-[767px]:border-b-[1px] max-[767px]:border-solid max-[767px]:border-[#FFC0CB] max-[767px]:flex max-[767px]:justify-between max-[767px]:items-center max-[767px]:text-[14px] max-[767px]:py-[8px] max-[767px]:px-[10px]">
                                                                <div class="quantity-container border-[1px] border-solid border-[#FF69B4] rounded-[5px] overflow-hidden flex items-center justify-between w-[84px] mx-auto">
                                                                    <span class="quantity-input text-[#FF1493] text-[14px] text-center w-[40px] outline-none font-semibold">${ci.getQuantity()}</span>
                                                                </div>
                                                            </td>
                                                            <!--Amount-->
                                                            <td data-label="Total" name="total" class="price-format text-[#FF1493] text-[15px] font-medium py-[15px] px-[14px] text-left max-[767px]:border-b-[1px] max-[767px]:border-solid max-[767px]:border-[#FFC0CB] max-[767px]:flex max-[767px]:justify-between max-[767px]:items-center max-[767px]:text-[14px] max-[767px]:py-[8px] max-[767px]:px-[10px]">
                                                                ${price.getPrice() * ci.getQuantity()}
                                                            </td>
                                                            <!--                                                            Delete button
                                                                                                                        <td data-label="Remove" class="gi-cart-pro-remove text-[#FF1493] w-[90px] text-[16px] py-[15px] px-[14px] text-right max-[767px]:border-b-[1px] max-[767px]:border-solid max-[767px]:border-[#FFC0CB] max-[767px]:flex max-[767px]:justify-between max-[767px]:items-center max-[767px]:text-[14px] max-[767px]:py-[8px] max-[767px]:px-[10px]">
                                                                                                                            <form action="payment?action=delete" method="post">
                                                                                                                                <input type="hidden" name="id" value="${cardtp.getID()}">/-strong/-heart:>:o:-((:-h<a href="#" onclick="return this.closest('form').submit()" class="text-[22px] my-[0] mx-auto"><i class="far fa-trash-alt"></i></a>
                                                                                                                            </form>
                                                                                                                        </td>-->
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="flex flex-wrap">
                                            <div class="w-full">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--cart content End -->
                    </div>
                </div>
        </section>

        <!-- Footer Start -->
        <jsp:include page="../common/homepage/footer.jsp"></jsp:include>

            <!-- Plugins JS -->
            <script src="${pageContext.request.contextPath}/assets/js/plugins/jquery-3.7.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/swiper-bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/fontawesome.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/infiniteslidev2.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/jquery.zoom.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/slick.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/nouislider.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/wow.js"></script>

        <!-- Tailwindcss -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/demo-1.js"></script>
        <script>
                                                        document.addEventListener("DOMContentLoaded", function () {
                                                            let priceElements = document.querySelectorAll('.price-format');
                                                            priceElements.forEach(function (el) {
                                                                let price = parseFloat(el.innerText);
                                                                el.innerText = price.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'}).replace('₫', '');
                                                            });
                                                        });
        </script>
        <script>
            window.onload = updateTotal();

            function updateTotal() {
                let totalPriceOfEachCard = document.querySelectorAll('td[name="total"]');
                console.log(totalPriceOfEachCard);
                let totalCart = 0;
                totalPriceOfEachCard.forEach(e => {

                    let totalPrice = parseFloat(e.textContent.trim());
                    totalCart += totalPrice;
                });
                document.querySelector('#subtotal').innerHTML = totalCart;
//                document.querySelector('#totalCart').innerHTML = totalCart;
            }

            function increaseQuantity(button) {
                var input = button.closest('.quantity-container').querySelector('.quantity-input');
                var quantity = parseInt(input.value);
                input.value = quantity + 1;
                button.closest('form').submit();
            }

            function decreaseQuantity(button) {
                var input = button.closest('.quantity-container').querySelector('.quantity-input');
                var quantity = parseInt(input.value);
                if (quantity > 1) {
                    input.value = quantity - 1;
                    button.closest('form').submit();
                }
            }
        </script>
    </body>
</html>