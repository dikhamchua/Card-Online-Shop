<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dal.implement.CardDAO" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <title>CardLord-Giao Dịch Mọi Loại Thẻ</title>
        <meta name="keywords" content="tailwindcss, ecommerce, farming, food market, grocery market, grocery shop, grocery store, grocery supper market, multi vendor, organic food, supermarket, supermarket grocery">
        <meta name="description" content="Multipurpose eCommerce Tailwind CSS Template">
        <meta name="author" content="Maraviya Infotech">

        <!-- site Favicon -->
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">

        <!-- CSS Icon Font -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vendor/gicons.css">

        <!-- CSS All Plugins Files -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/animate.css">   
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/swiper-bundle.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/owl.theme.default.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/slick.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/nouislider.css">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">

        <!-- Main Style -->
        <link rel="stylesheet" id="main_style" href="${pageContext.request.contextPath}/assets/css/demo-1.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css">
        <link rel="stylesheet" id="main_style" href="${pageContext.request.contextPath}/assets/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/thanhtoan.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
        </style>
        <style>
            /* Các style từ file thứ 2 */
            body {
                padding: 0;
                margin: 0;
            }

            .gi-product-tab {
                margin-left: auto;
                margin-right: auto;
                width: 70%;
                background-color: rgba(255, 255, 255, 0.9);
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            .gi-product-inner {
                transition: all 0.3s ease;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .gi-product-inner:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            }

            .gi-pro-image img {
                transition: all 0.3s ease;
            }

            .gi-product-inner:hover .gi-pro-image img {
                transform: scale(1.05);
            }

            .gi-pro-title a {
                font-weight: 500;
            }

            .price-format {
                color: #FF1493;
                font-weight: bold;
            }

            .gi-btn-group {
                background-color: #FF1493;
                color: white;
            }

            .gi-btn-group:hover {
                background-color: #ff69b4;
            }

            .new-badge {
                position: absolute;
                top: 10px;
                left: 10px;
                background-color: #FF1493;
                color: white;
                padding: 5px 10px;
                border-radius: 3px;
                font-size: 12px;
                font-weight: bold;
                z-index: 2;
            }

            .search_submit {
                background-color: #FF1493;
                color: white;
                border-radius: 0 5px 5px 0;
            }

            .search_submit:hover {
                background-color: #ff69b4;
            }

            .side-banner {
                position: fixed;
                top: 100px;
                width: 12%;
                height: 100%;
                z-index: 1;
            }

            .side-banner.left {
                left: 0;
                width:15%;
            }

            .side-banner.right {
                right: 0;
                width: 15%;
            }

            .side-banner img {
                width: 100%;
                height: 88.5%;
                object-fit: cover;
            }

            @media (max-width: 1000px) {
                .side-banner {
                    display: none;
                }
                .gi-product-tab {
                    max-width: 100%;
                }
            }

            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 30px;
            }

            .page-item {
                margin: 0 5px;
            }

            .page-link {
                padding: 10px 15px;
                color: #FF69B4;
                background-color: #fff;
                border: 1px solid #FF69B4;
                border-radius: 5px;
                transition: all 0.3s ease;
            }
            .page-item.active .page-link,
            .page-link:hover {
                color: #fff;
                background-color: #FF69B4;
            }

            @media (max-width: 768px) {
                .gi-product-tab {
                    width: 95%;
                    padding: 15px;
                }

                .page-item.disabled .page-link {
                    color: #6c757d;
                    pointer-events: none;
                    background-color: #fff;
                    border-color: #dee2e6;
                }
            }

            /* Thêm style từ file thứ nhất nếu cần */
            .out-of-stock {
                opacity: 0.5;
                pointer-events: none;
            }

            .gi-header-cat, .gi-header-search {
                z-index: 2;
                position: relative;
            }

            .gi-product-image {
                width: 100%;
                height: 200px; /* Adjust the height to your desired fixed size */
                object-fit: cover;
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

    <body class="w-full h-full relative font-Poppins font-normal overflow-x-hidden">

        <!-- Header Start  -->
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>

            <!-- Category Toggle -->
            <div class="gi-header-cat bg-gradient-to-r from-pink-400 to-pink-600 border-t border-b border-pink-300 hidden lg:block py-3">
                <div class="container mx-auto px-4">
                    <div class="gi-nav-bar flex justify-between items-center">
                        <!-- Category Toggle -->
                        <div class="gi-category-icon-block relative group">
                            <div class="gi-category-menu">
                                <div class="gi-category-toggle w-64 h-12 px-4 flex items-center bg-white text-pink-600 rounded-full cursor-pointer shadow-md hover:shadow-lg transition-all duration-300">
                                    <i class="fas fa-list text-lg"></i>
                                    <span class="ml-3 text-base font-medium">Các loại thẻ</span>
                                    <i class="fas fa-chevron-down text-sm ml-auto" aria-hidden="true"></i>
                                </div>
                            </div>
                            <!-- Dropdown -->
                            <div class="gi-cat-dropdown w-64 mt-2 p-2 absolute bg-white opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 ease-in-out left-0 z-50 rounded-lg shadow-xl">
                                <ul class="nav-tabs bg-gray-50 rounded-lg" id="myTab">
                                <c:forEach items="${listCardType}" var="ct">
                                    <li class="transition-all duration-300 ease-in-out hover:bg-pink-500 hover:text-white rounded-md">
                                        <a href="${pageContext.request.contextPath}/home?action=category&id=${ct.getID()}"
                                           class="block px-4 py-3 text-sm text-gray-700 font-medium capitalize">
                                            ${ct.getCardTypeName()}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>

                    <!-- Header Search Start -->
                    <div class="self-center gi-header-search my-0 mx-auto max-[991px]:m-0">
                        <div class="header-search w-full min-w-[700px] px-[30px] relative max-[1399px]:min-w-[500px] max-[1199px]:min-w-[400px] max-[991px]:p-0 max-[767px]:min-w-[350px] max-[480px]:min-w-[300px] max-[320px]:min-w-full">
                            <form class="gi-search-group-form relative flex border-2 border-solid border-[#eee] items-center rounded-[5px] bg-[#FFFAFA]" action="${pageContext.request.contextPath}/home" method="get">
                                <input class="form-control gi-search-bar block w-full min-h-[50px] h-[50px] max-[991px]:h-[40px] max-[991px]:min-h-[40px] px-[15px] text-[13px] font-normal leading-[1] text-[#777] bg-transparent outline-0 border-0 tracking-[0.6px]" name="searchQuery" placeholder="Tìm kiếm thẻ hoặc giá..." type="text">
                                <button type="submit" class="search_submit relative flex items-center justify-center w-[50px] h-[50px] max-[991px]:h-[40px] max-[991px]:min-h-[40px] bg-[#FF1493] hover:bg-[#ff69b4] rounded-r-[5px] transition-all duration-300">
                                    <i class="fas fa-search text-white text-[16px]"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                    <!-- Header Search End -->
                </div>
            </div>
        </div>
        <!-- Category Toggle End -->

        <div>
            <!-- Side Banner Left -->
            <div class="side-banner left">
                <img src="${pageContext.request.contextPath}/assets/img/game/reyna.png" alt="Game 3">
            </div>
            <!-- Side Banner Right -->
            <div class="side-banner right">
                <img src="${pageContext.request.contextPath}/assets/img/game/ys.jpg" alt="Game 1">
            </div>
        </div>

        <!-- New Product tab Area Start -->
        <section class="gi-product-tab py-10 wow fadeInUp" data-wow-duration="2s">
            <div class="container mx-auto px-4">
                <!-- Kiểm tra thông báo không có kết quả -->
                <c:if test="${not empty noResultMessage}">
                    <div class="alert alert-custom" role="alert">
                        ${noResultMessage}
                    </div>
                </c:if>
                <!-- New Product -->
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-6">
                    <c:forEach items="${listCardType_Price}" var="ctp">
                        <c:set var="ctpId" value="${ctp.getID()}"/>
                        <% 
                            boolean isOutOfStock = new CardDAO().getQuantityByCardTypeId((Integer)pageContext.getAttribute("ctpId")) <= 0;
                        %>
                        <div class="gi-product-card <%= isOutOfStock ? "out-of-stock" : "" %>">
                            <div class="gi-product-inner border border-pink-200 rounded-lg overflow-hidden transition duration-300 hover:shadow-lg">
                                <div class="gi-pro-image-outer relative">
                                    <a  class="block">
                                        <img class="gi-product-image w-full h-48 object-cover transition duration-300 ease-in-out hover:scale-105" 
                                             src="${ctp.getImageDetail()}" alt="Product">
                                    </a>
                                    <div class="gi-pro-actions absolute bottom-2 left-0 right-0 flex justify-center opacity-0 transition duration-300 group-hover:opacity-100">
                                        <form action="payment?action=add-product" method="post" class="flex items-center">
                                            <input type="hidden" name="id" value="${ctp.getID()}">
                                            <input type="hidden" name="quantity" value="1">
                                            <button type="submit" class="gi-btn-group bg-white text-pink-500 hover:bg-pink-500 hover:text-white rounded-full w-10 h-10 flex items-center justify-center mx-1 transition duration-300" title="Thêm vào giỏ hàng">
                                                <i class="fas fa-shopping-cart text-lg"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                                <div class="gi-pro-content p-4">
                                    <c:forEach items="${listCardType}" var="ct">
                                        <c:if test="${ctp.getCardTypeID() == ct.getID()}">
                                            <c:forEach items="${listPrice}" var="cp">
                                                <c:if test="${ctp.getPriceID() == cp.getID()}">
                                                    <h5 class="text-lg font-semibold mb-2">
                                                        <a href="product-details?id=${ctp.getID()}" class="text-gray-800 hover:text-pink-600 transition duration-300">
                                                            Thẻ ${ct.getCardTypeName()}
                                                        </a>
                                                    </h5>
                                                    <p class="text-pink-600 font-bold">
                                                        <span class="price-format">${cp.getPrice()}</span> VNĐ
                                                    </p>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>
                                    <p>
                                        <span style="font-size: 12px">Số lượng hiện có: ${quantityMap[ctp.getID()]}</span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Pagination -->
                <div class="mt-10 flex justify-center">
                    <nav aria-label="Page navigation">
                        <ul class="flex pagination">
                            <!-- Previous Page Link --> 
                            <li class="${currentPage == 1 ? 'opacity-50 cursor-not-allowed' : ''}"> 
                                <a class="px-3 py-2 bg-pink-100 text-pink-700 rounded-l-lg hover:bg-pink-200 transition duration-300 ${currentPage == 1 ? 'pointer-events-none' : ''}"
                                   href="${pageContext.request.contextPath}/home?page=${currentPage > 1 ? currentPage - 1 : 1}&searchQuery=${param.searchQuery}&action=${param.action}">
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
        </section> 
        <!-- Product tab Area End -->

        <!-- Footer Start -->
        <jsp:include page="../common/homepage/footer.jsp"></jsp:include>

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
                $(document).ready(function () {
                    $('.pagination a').on('click', function (e) {
                        e.preventDefault();
                        var pageUrl = $(this).attr('href');

                        $.get(pageUrl, function (data) {
                            var newHtml = $(data).find('.tab-pro-pane').html();
                            $('.tab-pro-pane').html(newHtml);

                            // Đánh dấu số trang hiện tại với lớp CSS mới
                            $('.pagination li').removeClass('active');
                            $(this).parent().addClass('active-page');
                        });
                    });
                });
            </script>
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
        <!-- Start of LiveChat (www.livechat.com) code -->
        <script>
                window.__lc = window.__lc || {};
                window.__lc.license = 18338046;
                window.__lc.integration_name = "manual_onboarding";
                window.__lc.product_name = "livechat";
                ;
                (function (n, t, c) {
                    function i(n) {
                        return e._h ? e._h.apply(null, n) : e._q.push(n)
                    }
                    var e = {_q: [], _h: null, _v: "2.0", on: function () {
                            i(["on", c.call(arguments)])
                        }, once: function () {
                            i(["once", c.call(arguments)])
                        }, off: function () {
                            i(["off", c.call(arguments)])
                        }, get: function () {
                            if (!e._h)
                                throw new Error("[LiveChatWidget] You can't use getters before load.");
                            return i(["get", c.call(arguments)])
                        }, call: function () {
                            i(["call", c.call(arguments)])
                        }, init: function () {
                            var n = t.createElement("script");
                            n.async = !0, n.type = "text/javascript", n.src = "https://cdn.livechatinc.com/tracking.js", t.head.appendChild(n)
                        }};
                    !n.__lc.asyncInit && e.init(), n.LiveChatWidget = n.LiveChatWidget || e
                }(window, document, [].slice))
        </script>
        <noscript><a href="https://www.livechat.com/chat-with/18338046/" rel="nofollow">Chat with us</a>, powered by <a href="https://www.livechat.com/?welcome" rel="noopener nofollow" target="_blank">LiveChat</a></noscript>
        <!-- End of LiveChat code -->

    </body>
</html>