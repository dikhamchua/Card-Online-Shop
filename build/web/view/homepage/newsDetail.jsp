<%-- 
    Document   : newsDetail
    Created on : Jul 30, 2024
    Author     : Tom
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <title>Chi Tiết Bài Viết - CardLord</title>
        <meta name="keywords"  content="tailwindcss, ecommerce, farming, food market, grocery market, grocery shop, grocery store, grocery supper market, multi vendor, organic food, supermarket, supermarket grocery">
        <meta name="description" content="Chi tiết bài viết trên CardLord">
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
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
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
                background-color: #FFF0F6;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            .back-button {
                display: inline-block;
                margin-top: 20px;
                padding: 5px 10px;
                background-color: #1a73e8;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            .back-button:hover {
                background-color: #155ab6;
            }
            .news-detail {
                display: flex;
                margin: 40px 0;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }
            .news-detail .image-container {
                flex: 1;
                max-width: 30%; /* Giảm kích thước của phần ảnh */
                padding: 20px; /* Thêm khoảng cách giữa ảnh và nội dung */
            }
            .news-detail .image-container img {
                width: 100%;
                height: auto; /* Đảm bảo ảnh giữ tỷ lệ khung hình */
                border-radius: 10px; /* Bo tròn các góc của ảnh */
            }
            .news-detail .content-container {
                flex: 2; /* Tăng kích thước của phần nội dung */
                padding: 40px;
                display: flex;
                flex-direction: column;
            }
            .news-detail .content-container h1 {
                font-size: 36px;
                font-weight: 700;
                color: #1a73e8;
                margin-bottom: 20px;
            }
            .news-detail .content-container .date {
                font-size: 14px;
                color: #888;
                margin-bottom: 20px;
            }
            .news-detail .content-container .content {
                font-size: 18px;
                line-height: 1.6;
                color: #333;
            }
        </style>
    </head>

    <body class="w-full h-full relative font-Poppins font-normal overflow-x-hidden">
        <!-- Header start  -->
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>
            <!-- Header end -->

            <!-- News Detail Start -->
            <div class="container my-10">
                <div class="news-detail">
                    <div class="image-container">
                        <img src="${news.getImage()}" alt="news image">
                </div>
                <div class="content-container">
                    <h1>${news.getTitle()}</h1>
                    <p class="date">Posted at ${news.getCreatedAt()}</p>
                    <div class="content">${news.getContent()}</div><br>
                    <div>
                        <a href="${pageContext.request.contextPath}/news" class="gi-btn-2 transition-all duration-[0.3s] ease-in-out overflow-hidden text-center relative rounded-[5px] py-[10px] max-[767px]:py-[6px] px-[15px] max-[767px]:px-[10px] bg-gradient-to-r from-pink-500 to-pink-700 text-[#fff] border-[0] text-[14px] max-[767px]:text-[13px] tracking-[0] font-medium inline-flex items-center hover:from-pink-700 hover:to-pink-500">
                            Quay trở lại
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!-- News Detail End -->

        <!-- Footer Start -->
        <jsp:include page="../common/homepage/footer.jsp"></jsp:include>
            <!-- Footer Area End -->

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