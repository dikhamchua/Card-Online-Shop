<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <title>Chọn Mục Cần Hỗ Trợ</title>
        <meta name="keywords" content="tailwindcss, ecommerce, farming, food market, grocery market, grocery shop, grocery store, grocery supper market, multi vendor, organic food, supermarket, supermarket grocery">
        <meta name="description" content="Multipurpose eCommerce Tailwind CSS Template">
        <meta name="author" content="Maraviya Infotech">

        <!-- site Favicon -->
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">

        <!-- css Icon Font -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vendor/gicons.css">
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
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>

        <div class="container mx-auto my-10">
            <h2 class="text-2xl font-bold mb-5">Chọn Mục Cần Hỗ Trợ</h2>
            <div class="grid grid-cols-2 gap-4">
                <a href="feedback?category=MuaSắm" class="flex items-center p-4 border rounded-md hover:shadow-lg transition duration-200">
                    <img src="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" alt="Mua Sắm" class="w-12 h-12 mr-4">
                    <span class="text-xl">Mua Sắm</span>
                </a>
                <a href="feedback?category=KhuyếnMãiƯuĐãi" class="flex items-center p-4 border rounded-md hover:shadow-lg transition duration-200">
                    <img src="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" alt="Khuyến Mãi & Ưu Đãi" class="w-12 h-12 mr-4">
                    <span class="text-xl">Khuyến Mãi & Ưu Đãi</span>
                </a>
                <a href="feedback?category=ThanhToán" class="flex items-center p-4 border rounded-md hover:shadow-lg transition duration-200">
                    <img src="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" alt="Thanh Toán" class="w-12 h-12 mr-4">
                    <span class="text-xl">Thanh Toán</span>
                </a>
                <a href="feedback?category=ĐơnHàng" class="flex items-center p-4 border rounded-md hover:shadow-lg transition duration-200">
                    <img src="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" alt="Đơn Hàng & Vận Chuyển" class="w-12 h-12 mr-4">
                    <span class="text-xl">Đơn Hàng</span>
                </a>
                <a href="feedback?category=TrảHàngHoànTiền" class="flex items-center p-4 border rounded-md hover:shadow-lg transition duration-200">
                    <img src="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" alt="Trả Hàng & Hoàn Tiền" class="w-12 h-12 mr-4">
                    <span class="text-xl">Trả Hàng & Hoàn Tiền</span>
                </a>
            </div>
        </div>

        <jsp:include page="../common/homepage/footer.jsp"></jsp:include>

        <!-- Plugins JS -->
        <script src="${pageContext.request.contextPath}/assets/js/plugins/jquery-3.7.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/swiper-bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/fontawesome.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/countdownTimer.js"></script>
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
    </body>
</html>
