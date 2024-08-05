<%-- 
    Document   : news
    Created on : Jul 29, 2024, 5:36:03 PM
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
        <title>CardLord-Giao Dịch mọi loại thẻ</title>
        <meta name="keywords"  content="tailwindcss, ecommerce, farming, food market, grocery market, grocery shop, grocery store, grocery supper market, multi vendor, organic food, supermarket, supermarket grocery">
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
            }
            .news-title {
                font-size: 36px;
                font-weight: 700;
                color: #333;
                text-align: center;
                margin: 40px 0;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
            }
            .news-posts {
                background-color: #fff;
                padding: 40px;
                margin: 40px 0;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                max-width: 1200px; /* Đặt chiều rộng tối đa */
                margin: 0 auto; /* Căn giữa div */
            }
            .news-post {
                display: flex;
                align-items: center;
                padding: 20px;
                margin: 20px 0;
                background-color: #f9f9f9;
                border-radius: 10px;
                box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s, box-shadow 0.3s;
            }
            .news-post:hover {
                transform: translateY(-10px);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            }
            .news-post img {
                width: 150px;
                height: 150px;
                object-fit: cover;
                border-radius: 10px;
                margin-right: 20px;
            }
            .news-post-content {
                display: flex;
                flex-direction: column;
            }
            .news-post a {
                font-size: 24px;
                font-weight: bold;
                color: #1a73e8;
                text-decoration: none;
                transition: color 0.2s;
            }
            .news-post a:hover {
                color: #ff1493;
            }
            .news-post p {
                margin: 10px 0 0;
                color: #888;
                font-size: 14px;
            }
            .news-post .date {
                font-size: 12px;
                color: #999;
                margin-top: 5px;
            }
            .filters {
                background-color: #007bff;
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 5px;
                color: #fff;
            }
            .filters input,
            .filters select {
                padding: 5px;
                margin-right: 10px;
            }
            .filters button {
                padding: 5px 10px;
                background-color: #ffa500;
                border: none;
                border-radius: 5px;
                color: #fff;
                cursor: pointer;
            }
            .filters button:hover {
                background-color: #e69500;
            }
            .alert-custom {
                font-family: 'Roboto', sans-serif; /* Sử dụng font Roboto hoặc font khác nếu bạn muốn */
                font-size: 1.25rem; /* Kích thước font lớn hơn */
                text-align: center; /* Căn giữa */
                color: #856404; /* Màu chữ cho thông báo cảnh báo */
                background-color: #fff3cd; /* Màu nền cho thông báo cảnh báo */
                border: 1px solid #ffeeba; /* Đường viền cho thông báo cảnh báo */
                padding: 15px;
                margin-top: 20px;
                border-radius: 5px; /* Bo góc */
                width: 100%;
                max-width: 600px; /* Giới hạn chiều rộng */
                margin-left: auto;
                margin-right: auto;
            }
        </style>
    </head>

    <body class="w-full h-full relative font-Poppins font-normal overflow-x-hidden" style="background-color: #FFF0F6">
        <!-- Header start  -->
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>
            <!-- Header end -->

            <!-- Header Search Start -->
            <div class="gi-header-cat bg-gradient-to-r from-pink-400 to-pink-600 border-t border-b border-pink-300 hidden lg:block py-3">
                <div class="container mx-auto px-4">
                    <div class="gi-nav-bar flex justify-between items-center">
                        <div class="self-center gi-header-search my-0 mx-auto max-[991px]:m-0">
                            <div class="header-search w-full min-w-[700px] px-[30px] relative max-[1399px]:min-w-[500px] max-[1199px]:min-w-[400px] max-[991px]:p-0 max-[767px]:min-w-[350px] max-[480px]:min-w-[300px] max-[320px]:min-w-full">
                                <form class="gi-search-group-form relative flex border-2 border-solid border-[#eee] items-center rounded-[5px] bg-[#FFFAFA]" 
                                      action="${pageContext.request.contextPath}/news" method="get">
                                <input class="form-control gi-search-bar block w-full min-h-[50px] h-[50px] max-[991px]:h-[40px] max-[991px]:min-h-[40px] px-[15px] text-[13px] font-normal leading-[1] text-[#777] bg-transparent outline-0 border-0 tracking-[0.6px]" name="searchQuery" placeholder="Tìm kiếm từ khóa" type="text">
                                <button type="submit" class="search_submit relative flex items-center justify-center w-[50px] h-[50px] max-[991px]:h-[40px] max-[991px]:min-h-[40px] bg-[#FF1493] hover:bg-[#ff69b4] rounded-r-[5px] transition-all duration-300">
                                    <i class="fas fa-search text-white text-[16px]"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Header Search End -->

        <!-- News Posts Start -->
        <div class="container mx-auto my-10">
            <h1 class="news-title">Cập nhật tin tức mới nhất</h1>
            <div class="news-posts">
                <!--Kiểm tra thông báo không có kết quả-->
                <c:if test="${not empty noResultMessage}">
                    <div class="alert alert-custom" role="alert">
                        ${noResultMessage}
                    </div>
                </c:if>
                <!--Tin tuc-->
                <c:forEach items="${listNews}" var="news">
                    <div class="news-post">
                        <img src="${news.getImage()}" alt="news image">
                        <div class="news-post-content">
                            <a href="news-details?id=${news.getID()}">${news.getTitle()}</a>
                            <p class="date">Posted at ${news.getCreatedAt()}</p>
                        </div>
                    </div>
                </c:forEach>

                <!-- Pagination -->
                <div class="mt-10 flex justify-center">
                    <nav aria-label="Page navigation">
                        <ul class="flex pagination">
                            <!-- Previous Page Link --> 
                            <li class="${currentPage == 1 ? 'opacity-50 cursor-not-allowed' : ''}"> 
                                <a class="px-3 py-2 bg-pink-100 text-pink-700 rounded-l-lg hover:bg-pink-200 transition duration-300 ${currentPage == 1 ? 'pointer-events-none' : ''}"
                                   href="${pageContext.request.contextPath}/news?page=${currentPage > 1 ? currentPage - 1 : 1}&searchQuery=${param.searchQuery}&action=${param.action}">
                                    &laquo;
                                </a> 
                            </li>
                            <!-- Page Number Links --> 
                            <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                                <li class="${currentPage == pageNumber ? 'active-page' : ''}"> 
                                    <a class="px-3 py-2 ${currentPage == pageNumber ? 'bg-pink-500 text-white' : 'bg-pink-100 text-pink-700'} hover:bg-pink-200 transition duration-300" 
                                       href="${pageContext.request.contextPath}/home?page=${pageNumber}&searchQuery=${param.searchQuery}&action=${param.action}">
                                        ${pageNumber}
                                    </a>
                                </li> 
                            </c:forEach> 
                            <!-- Next Page Link -->  
                            <li class="${currentPage == totalPages ? 'opacity-50 cursor-not-allowed' : ''}"> 
                                <a class="px-3 py-2 bg-pink-100 text-pink-700 rounded-r-lg hover:bg-pink-200 transition duration-300 ${currentPage == totalPages ? 'pointer-events-none' : ''}" 
                                   href="${pageContext.request.contextPath}/home?page=${currentPage < totalPages ? currentPage + 1 : totalPages}&searchQuery=${param.searchQuery}&action=${param.action}"> 
                                    &raquo;
                                </a>
                            </li> 
                        </ul>  
                    </nav>  
                </div>    
            </div>
        </div>
        <!-- News Posts End -->
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