<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="dal.implement.SliderDAO" %>
<%@ page import="entity.Slider" %>
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
            .swiper-container {
                width: 100%;
                height: 100%;
            }
            .swiper-slide {
                text-align: center;
                font-size: 18px;
                background: #fff;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .swiper-slide img {
                width: 100%;
                height: auto;
                object-fit: cover;
            }
        </style>
    </head>

    <body class="w-full h-full relative font-Poppins font-normal overflow-x-hidden" style=" background-color: #FFF0F6">
        <!-- Header start  -->
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>

        <%
            SliderDAO sliderDAO = new SliderDAO();
            List<Slider> listSlider = sliderDAO.findAllDescButHide();
        %>

        <!-- Hero Slider Start -->
        <section class="section gi-hero h-full w-full my-10">
            <div class="container mx-auto">
                <div class="gi-main-content w-full px-3">
                    <!-- Hero Slider Start -->
                    <div class="gi-slider-content h-full">
                        <div class="gi-main-slider">
                            <div class="gi-slider rounded-5 swiper-container main-slider-nav main-slider-dot">
                                <!-- Main slider  -->
                                <div class="swiper-wrapper">
                                    <%
                                        for (Slider slider : listSlider) {
                                    %>
                                    <div class="swiper-slide">
                                        <img src="<%= slider.getImage() %>" alt="Slide Image">
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <div class="swiper-pagination swiper-pagination-white"></div>
                                <div class="swiper-buttons">
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Hero Slider End -->

        <!-- About PR start -->
        <section class="gi-about py-[40px] max-[767px]:py-[30px]" style=" background-color: #F5E6EC" >
            <div class="flex flex-wrap justify-between items-center mx-auto min-[1600px]:max-w-[1600px] min-[1400px]:max-w-[1320px] min-[1200px]:max-w-[1140px] min-[992px]:max-w-[960px] min-[768px]:max-w-[720px] min-[576px]:max-w-[540px] relative">
                <div class="flex flex-wrap" style="margin-left: 90px">
                    <div class="min-[1200px]:w-[50%] min-[768px]:w-full px-[12px]" style="margin-right: -40px;">
                        <div class="gi-about-detail h-full flex flex-col justify-center max-[1199px]:mt-[30px]">
                            <div class="section-title pt-[0] flex flex-col mb-[20px]">
                                <h1 class="mb-[15px] font-manrope text-[30px] font-semibold text-[#4b5966] relative inline p-[0] capitalize leading-[1]"><span class="text-[#FF1493]" style='font-size: larger'>Nạp Thẻ Điện Thoại - Mua Thẻ Game</span></h1>
                                <h1 class="mb-[15px] font-manrope text-[30px] font-semibold text-[#4b5966] relative inline p-[0] capitalize leading-[1]"><span class="text-[#FF1493]" style='font-size: larger'>Ngay Tại CardLord</span></h1>
                            </div>
                            <p class="text-[#777] text-[24px] font-normal mb-[16px]">Nạp thẻ nhanh chóng, mua thẻ game dễ dàng khi sử dụng CardLord:
                            </p>
                            <p class="text-[#777] text-[20px] font-normal mb-[16px]"><i class="fa fa-check" style="color:#FF1493; font-size: 20px"></i>  Mua và nạp tất cả loại thẻ từ các nhà phát hành game uy tín như Zing, Garena, Funtap, Soha, BIT, VGP…</p>
                            <p class="text-[#777] text-[20px] font-normal mb-[16px]"><i class="fa fa-check" style="color:#FF1493; font-size: 20px"></i>  Chiết khấu cao, bao giá tốt, đa dạng mệnh giá thẻ</p>
                            <p class="text-[#777] text-[20px] font-normal mb-[16px]"><i class="fa fa-check" style="color:#FF1493; font-size: 20px"></i>  Thanh toán nhanh chóng, bảo mật tối đa</p>
                        </div>
                    </div>
                    <div class="min-[1200px]:w-[50%] min-[768px]:w-full px-[12px] flex items-center justify-end" style="margin-left: -40px;">
                        <div class="gi-about-img min-[1200px]:max-w-[600px]" style="margin-right: 40px; margin-left: -60px;">
                            <img src="assets/img/logo/banner1.jpg"  class="v-img w-full rounded-[5px] object-cover h-auto min-[1200px]:h-[400px] min-w-[700px] min-h-[350px]" alt="about">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- About PR End -->

        <!-- Service Section -->
        <section class="gi-service-section py-[40px] max-[767px]:py-[30px]">
            <div class="flex flex-wrap justify-between items-center mx-auto min-[1600px]:max-w-[1600px] min-[1400px]:max-w-[1320px] min-[1200px]:max-w-[1140px] min-[992px]:max-w-[960px] min-[768px]:max-w-[720px] min-[576px]:max-w-[540px] relative">
                <div class="section-title-2 w-full mb-[20px] pb-[20px] flex flex-col justify-center items-center">
                    <h2 class="gi-title mb-[0] font-manrope text-[26px] font-semibold text-[#4b5966] relative inline p-[0] capitalize leading-[1]">Our <span class="text-[#FF1493]">Services</span></h2>
                    <p class="max-w-[400px] mt-[15px] text-[14px] text-[#777] text-center leading-[23px]">Customer service should not be a department. It should be the entire company.</p>
                </div>
                <div class="flex flex-wrap w-full my-[-12px]">
                    <div class="py-[12px] px-[12px] min-[992px]:w-[25%] min-[576px]:w-[50%] w-full" data-aos="fade-up" data-aos-duration="2000" data-aos-delay="200">
                        <div class="gi-ser-inner p-[30px] transition-all duration-[0.3s] ease delay-[0s] cursor-pointer border-[1px] border-solid border-[#eee] h-full flex items-center justify-center flex-col text-center nh-[#fff] rounded-[5px]">
                            <div class="gi-service-image mb-[15px]">
                                <i class="fas fa-running fa-3x"></i>
                            </div>
                            <div class="gi-service-desc">
                                <h3 class="mb-[10px] text-[18px] font-medium text-[#FF1493] tracking-[0.6px] font-Poppins leading-[1.2] max-[575px]:text-[18px]"><b>Nhanh chóng, tiện lợi</b></h3>
                                <p class="m-[0] text-[16px] text-[#777] leading-[1.5] tracking-[0.5px] font-light">Tiết kiệm thời gian với các tính năng của CardLord. Chỉ cần vài giây bạn đã thực hiện xong giao dịch</p>
                            </div>
                        </div>
                    </div>
                    <div class="py-[12px] px-[12px] min-[992px]:w-[25%] min-[576px]:w-[50%] w-full" data-aos="fade-up" data-aos-duration="2000" data-aos-delay="400">
                        <div class="gi-ser-inner p-[30px] transition-all duration-[0.3s] ease delay-[0s] cursor-pointer border-[1px] border-solid border-[#eee] h-full flex items-center justify-center flex-col text-center nh-[#fff] rounded-[5px]">
                            <div class="gi-service-image mb-[15px]">
                                <i class="fas fa-headset fa-3x"></i>
                            </div>
                            <div class="gi-service-desc">
                                <h3 class="mb-[10px] text-[18px] font-medium text-[#FF1493] tracking-[0.6px] font-Poppins leading-[1.2] max-[575px]:text-[18px]"><b>Hỗ trợ 24/7</b></h3>
                                <p class="m-[0] text-[16px] text-[#777] leading-[1.5] tracking-[0.5px] font-light">Liên hệ chúng tôi để nhận hỗ trợ 24 tiếng 1 ngày, 7 ngày 1 tuần</p>
                            </div>
                        </div>
                    </div>
                    <div class="py-[12px] px-[12px] min-[992px]:w-[25%] min-[576px]:w-[50%] w-full" data-aos="fade-up" data-aos-duration="2000" data-aos-delay="600">
                        <div class="gi-ser-inner p-[30px] transition-all duration-[0.3s] ease delay-[0s] cursor-pointer border-[1px] border-solid border-[#eee] h-full flex items-center justify-center flex-col text-center nh-[#fff] rounded-[5px]">
                            <div class="gi-service-image mb-[15px]">
                                <i class="fas fa-thumbs-up fa-3x"></i>
                            </div>
                            <div class="gi-service-desc">
                                <h3 class="mb-[10px] text-[18px] font-medium text-[#FF1493] tracking-[0.6px] font-Poppins leading-[1.2] max-[575px]:text-[18px]"><b>Đơn giản dễ sử dụng</b></h3>
                                <p class="m-[0] text-[16px] text-[#777] leading-[1.5] tracking-[0.5px] font-light">CardLord có giao diện thân thiện và đơn giản hóa mọi thao tác. </p>
                            </div>
                        </div>
                    </div>
                    <div class="py-[12px] px-[12px] min-[992px]:w-[25%] min-[576px]:w-[50%] w-full" data-aos="fade-up" data-aos-duration="2000" data-aos-delay="800">
                        <div class="gi-ser-inner p-[30px] transition-all duration-[0.3s] ease delay-[0s] cursor-pointer border-[1px] border-solid border-[#eee] h-full flex items-center justify-center flex-col text-center nh-[#fff] rounded-[5px]">
                            <div class="gi-service-image mb-[15px]">
                                <i class="fas fa-lock fa-3x"></i>
                            </div>
                            <div class="gi-service-desc">
                                <h3 class="mb-[10px] text-[18px] font-medium text-[#FF1493] tracking-[0.6px] font-Poppins leading-[1.2] max-[575px]:text-[18px]"><b>Bảo mật an toàn</b></h3>
                                <p class="m-[0] text-[16px] text-[#777] leading-[1.5] tracking-[0.5px] font-light">Tài khoản và giao dịch của người dùng được bảo vệ ở mức độ an toàn cao</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Service Section End -->

        <!-- Footer Start -->
        <jsp:include page="../common/homepage/footer.jsp"></jsp:include>
            <!-- Footer Area End -->

            <<<<<<< HEAD
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
        =======
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
<!--    <script src="${pageContext.request.contextPath}/assets/js/plugins/tailwindcss3.4.1"></script>-->
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
    >>>>>>> 044937774e58d56faf574b144172ed109d8ed3ea

    <!-- Tailwindcss -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Main Js -->
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/demo-1.js"></script>
</body>
</html>