<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <title>Đặt lại mật khẩu</title>
        <meta name="keywords" content="tailwindcss, ecommerce, reset password, card trading">
        <meta name="description" content="Reset Password Page">
        <meta name="author" content="Tom">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.3.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/animate.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/swiper-bundle.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/owl.theme.default.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/slick.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/nouislider.css">
        <link rel="stylesheet" id="main_style" href="${pageContext.request.contextPath}/assets/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
        </style>
        <style>
            body {
                background-color: #f5f5f5; /* Màu nền nhẹ nhàng */
            }
            .gi-login-container {
                background-color: #ffffff; /* Màu nền cho container chính */
            }
        </style>
    </head>
    <body class="w-full h-full relative font-Poppins font-normal overflow-x-hidden">

        <!-- Reset password section -->
        <section class="gi-login py-[40px] max-[767px]:py-[30px]">
            <div class="flex flex-wrap justify-between items-center mx-auto min-[1600px]:max-w-[1600px] min-[1400px]:max-w-[1320px] min-[1200px]:max-w-[1140px] min-[992px]:max-w-[960px] min-[768px]:max-w-[720px] min-[576px]:max-w-[540px]">
                <div class="section-title-2 w-full mb-[20px] pb-[20px] flex flex-col justify-center items-center">
                    <h2 class="gi-title mb-[0] font-manrope text-[26px] font-semibold text-[#FF1493] relative inline p-[0] capitalize leading-[1]">Đặt lại mật khẩu</h2>
                    <p class="max-w-[400px] mt-[15px] text-[14px] text-[#777] text-center leading-[23px]">CardLord</p>
                </div>
                <div class="gi-login-content max-w-[1000px] m-auto flex flex-row max-[991px]:flex-col max-[1199px]:px-[12px] max-[991px]:w-full" style="margin-top: 50px;">
                    <div class="gi-login-box w-[50%] px-[15px] max-[991px]:w-full max-[991px]:p-[0]">
                        <div class="gi-login-wrapper max-w-[530px] my-[0] mx-auto">
                            <div class="gi-login-container p-[30px] max-[575px]:p-[15px] border-[1px] border-solid border-[#eee] rounded-[5px] text-left">
                                <div class="gi-login-form">
                                    <form method="post" action="newpassword" class="flex flex-col">
                                        <span class="gi-login-wrap flex flex-col">
                                            <label for="password" class="mb-[10px] text-[#4b5966] text-[15px] font-medium tracking-[0] leading-[1]">Mật khẩu mới:</label>
                                            <input type="password" name="password" id="password" placeholder="Mật khẩu mới" class="mb-[27px] px-[15px] bg-transparent border-[1px] border-solid border-[#eee] rounded-[5px] text-[#777] text-[14px] outline-[0] h-[50px]" >
                                        </span>
                                        <span class="gi-login-wrap flex flex-col">
                                            <label for="confPassword" class="mb-[10px] text-[#4b5966] text-[15px] font-medium tracking-[0] leading-[1]">Xác nhận mật khẩu mới:</label>
                                            <input type="password" name="confPassword" id="confPassword" placeholder="Xác nhận mật khẩu mới" class="mb-[27px] px-[15px] bg-transparent border-[1px] border-solid border-[#eee] rounded-[5px] text-[#777] text-[14px] outline-[0] h-[50px]" >
                                        </span>
                                        <div id="message">
                                            <% String successMessage = (String) request.getAttribute("successMessage"); %>
                                            <% if (successMessage != null) { %>
                                            <p style="color:green;"><%= successMessage %></p>
                                            <script>
                                                setTimeout(function () {
                                                    window.location.href = "<%= request.getContextPath() %>/authen";
                                                }, 1000);
                                            </script>
                                            <% } %>
                                            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                                            <% if (errorMessage != null) { %>
                                            <p style="color:red;"><%= errorMessage %></p>
                                            <% } %>
                                        </div>
                                        <span class="gi-login-wrap gi-login-btn mt-[30px] flex flex-row justify-between items-center">
                                            <button type="submit" class="gi-btn-1 btn py-[14px] px-[190px] bg-[#FF1493] text-[#fff] border-[0] transition-all duration-[0.3s] ease-in-out overflow-hidden text-center text-[14px] font-semibold relative rounded-[5px] hover:bg-[#5caf90] hover:text-[#fff]">Xác nhận</button>
                                        </span>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="gi-login-box w-[50%] px-[15px] max-[991px]:w-full max-[991px]:p-[0] max-[991px]:hidden">
                        <div class="gi-login-img">
                            <img src="${pageContext.request.contextPath}/assets/img/common/logo.jpeg" alt="reset-password" class="w-full rounded-[5px]">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/jquery-3.7.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/swiper-bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/js/fontawesome.min.js" integrity="sha512-1M9vud0lqoXACA9QaA8IY8k1VR2dMJ2Qmqzt9pN2AH7eQHWpNsxBpaayV0kKkUsF7FLVQ2sA2SSc8w5VOm7/mg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/infiniteslidev2.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/jquery.zoom.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/slick.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/nouislider.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins/wow.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
        <script src="https://cdn.tailwindcss.com"></script>

    </body>
</html>