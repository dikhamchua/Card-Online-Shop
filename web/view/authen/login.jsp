<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <!-- css Icon Font -->
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.3.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
        <!-- css All Plugins Files -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/animate.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/swiper-bundle.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/owl.theme.default.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/slick.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugins/nouislider.css">
        <!-- Main Style -->
        <link rel="stylesheet" id="main_style" href="${pageContext.request.contextPath}/assets/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css">
        <!-- Tailwind CSS -->
        <link href="https://cdn.tailwindcss.com/3.4.3/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
        </style>
    </head>
    <body class="w-full h-full relative font-Poppins font-normal overflow-x-hidden">
        <!-- Login section -->
        <section class="gi-login py-[40px] max-[767px]:py-[30px]">
            <div class="flex flex-wrap justify-between items-center mx-auto min-[1600px]:max-w-[1600px] min-[1400px]:max-w-[1320px] min-[1200px]:max-w-[1140px] min-[992px]:max-w-[960px] min-[768px]:max-w-[720px] min-[576px]:max-w-[540px]">
                <div class="section-title-2 w-full mb-[20px] pb-[20px] flex flex-col justify-center items-center">
                    <h2 class="gi-title mb-[0] font-manrope text-[26px] font-semibold text-[#FF1493] relative inline p-[0] capitalize leading-[1]">Đăng Nhập Tài Khoản CardLord</h2>
                    <p class="max-w-[400px] mt-[15px] text-[14px] text-[#777] text-center leading-[23px]">CardLord</p>
                </div>
                <div class="gi-login-content max-w-[1000px] m-auto flex flex-row max-[991px]:flex-col max-[1199px]:px-[12px] max-[991px]:w-full" style="margin-top: 50px;">
                    <div class="gi-login-box w-[50%] px-[15px] max-[991px]:w-full max-[991px]:p-[0]">
                        <div class="gi-login-wrapper max-w-[530px] my-[0] mx-auto">
                            <div class="gi-login-container p-[30px] max-[575px]:p-[15px] border-[1px] border-solid border-[#eee] rounded-[5px] text-left bg-[#fff]">
                                <div class="gi-login-form">
                                    <form method="post" action="authen?action=login" class="flex flex-col">
                                        <span class="gi-login-wrap flex flex-col">
                                            <label for="username" class="mb-[10px] text-[#4b5966] text-[15px] font-medium tracking-[0] leading-[1]">Tài Khoản*</label>
                                            <input type="text" name="username" value="${username}" id="username" placeholder="Tên Tài Khoản" class="mb-[27px] px-[15px] bg-transparent border-[1px] border-solid border-[#eee] rounded-[5px] text-[#777] text-[14px] outline-[0] h-[50px]" required>
                                        </span>
                                        <span class="gi-login-wrap flex flex-col">
                                            <label for="password" class="mb-[10px] text-[#4b5966] text-[15px] font-medium tracking-[0] leading-[1]">Mật Khẩu*</label>
                                            <input type="password" name="password" value="${password}" id="password" placeholder="*********" class="mb-[15px] px-[15px] bg-transparent border-[1px] border-solid border-[#eee] rounded-[5px] text-[#777] text-[14px] outline-[0] h-[50px]" required>
                                        </span>

                                        <span class="gi-login-wrap flex flex-col">
                                            <label for="captcha" class="mb-[10px] text-[#4b5966] text-[15px] font-medium tracking-[0] leading-[1]">Nhập Captcha*</label>
                                            <div class="relative mb-4 flex items-center">
                                                <input type="text" name="captcha" id="captcha-input" placeholder="Nhập Captcha " class="px-4 pr-8 bg-transparent border border-solid border-zinc-200 rounded-md text-zinc-500 text-sm outline-none h-12 w-full" required />

                                            </div>
                                            <div class="flex items-center">
                                                <img src="data:image/png;base64,${captchaImage}" alt="CAPTCHA image" id="captchaImage" class="h-12 mr-2" style="max-width: 65%;">
                                                <button type="button" id="refreshCaptcha" class=" rounded-r-md">
                                                    <i class="fas fa-sync-alt"></i>
                                                </button>
                                            </div>
                                        </span>
                                        <span class="gi-login-wrap flex flex-col gi-login-fp">
                                            <span class="text-[#777] text-[16px]">
                                                <a href="authen?action=register" class="text-[#4b5966] hover:text-[#5caf90]">Tạo tài khoản</a>
                                                <a href="authen?action=forgotpassword" class="text-[#4b5966] hover:text-[#5caf90]" style="margin-left: 150px;">Quên mật khẩu?</a>
                                            </span>
                                        </span>
                                        <span class="gi-login-wrap gi-login-btn mt-[30px]">
                                            <button type="submit" class="gi-btn-1 btn py-[14px] px-[190px] bg-[#FF1493] text-[#fff] border-[0] transition-all duration-[0.3s] rounded-[5px] hover:bg-[#5caf90] hover:text-[#fff]">Vào</button>
                                        </span>
                                        <span style="color:red">${error}</span>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="gi-login-box w-[50%] px-[15px] max-[991px]:w-full max-[991px]:p-[0] max-[991px]:hidden">
                        <div class="gi-login-img">
                            <img src="${pageContext.request.contextPath}/assets/img/common/logo.jpeg" alt="login" class="w-full rounded-[5px]">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Login section End -->
        <!-- Plugins JS -->
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
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/captchagen.js"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>


        <script>
            $(document).ready(function () {
                $('#refreshCaptcha').on('click', function () {
                    $.ajax({
                        url: '<%=request.getContextPath()%>/refreshCaptcha',
                        method: 'GET',
                        success: function (data) {
                            $('#captchaImage').attr('src', 'data:image/png;base64,' + data);
                        },
                        error: function (err) {
                            console.log("Error refreshing captcha: ", err);
                        }
                    });
                });
            });
        </script>
        <!--        <script>
        $(document).ready(function () {
            $("#login-form").submit(function (event) {
                event.preventDefault();
                var formData = $(this).serialize();
                $.ajax({
                    type: "POST",
                    url: $(this).attr("action"),
                    data: formData,
                    success: function (data) {
                        if (data.indexOf("error") !== -1) {
                            // display error message
                            $("#error-message").text(data);
                        } else {
                            // redirect to homepage
                            window.location.href = "<%=request.getContextPath()%>/home";
                        }
                        // refresh captcha image
                        $.ajax({
                            url: '<%=request.getContextPath()%>/refreshCaptcha',
                            method: 'GET',
                            success: function (data) {
                                $('#captchaImage').attr('src', 'data:image
                </script>-->
    </body>
</html>
