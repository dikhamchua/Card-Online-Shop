<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <title>Nhập OTP</title>
        <meta name="keywords" content="otp, authentication, card trading, verification">
        <meta name="description" content="Enter OTP for verification">
        <meta name="author" content="Your Company">
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
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
            .text-danger {
                color: #e63976;
                font-size: 14px;
                margin-top: 10px;
                display: block;
                text-align: center;
            }
        </style>
    </head>
    <body class="w-full h-full relative font-Poppins font-normal overflow-x-hidden">
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>
        <!-- Enter OTP section -->
        <section class="gi-otp py-[40px] max-[767px]:py-[30px]">
            <div class="flex flex-wrap justify-between items-center mx-auto min-[1600px]:max-w-[1600px] min-[1400px]:max-w-[1320px] min-[1200px]:max-w-[1140px] min-[992px]:max-w-[960px] min-[768px]:max-w-[720px] min-[576px]:max-w-[540px]">
                <div class="section-title-2 w-full mb-[20px] pb-[20px] flex flex-col justify-center items-center">
                    <h2 class="gi-title mb-[0] font-manrope text-[26px] font-semibold text-[#FF1493] relative inline p-[0] capitalize leading-[1]">Xác Thực OTP</h2>
                    <p class="max-w-[400px] mt-[15px] text-[14px] text-[#777] text-center leading-[23px]">Vui lòng nhập mã OTP được gửi đến email của bạn để xác thực tài khoản.</p>
                </div>
                <div class="gi-otp-content max-w-[1000px] m-auto flex flex-row max-[991px]:flex-col max-[1199px]:px-[12px] max-[991px]:w-full" style="margin-top: 50px;">
                    <div class="gi-otp-box w-[50%] px-[15px] max-[991px]:w-full max-[991px]:p-[0]">
                        <div class="gi-otp-wrapper max-w-[530px] my-[0] mx-auto">
                            <div class="gi-otp-container p-[30px] max-[575px]:p-[15px] border-[1px] border-solid border-[#eee] rounded-[5px] text-left bg-[#fff]">
                                <div class="gi-otp-form">
                                    <form id="register-form" action="ValidateOtp1" role="form" autocomplete="off" class="flex flex-col" method="post">
                                        <span class="gi-otp-wrap flex flex-col mb-4">
                                            <label for="otp" class="mb-[10px] text-[#4b5966] text-[15px] font-medium tracking-[0] leading-[1]">Nhập OTP*</label>
                                            <input id="otp" name="otp" placeholder="Nhập OTP" class="px-[15px] bg-transparent border-[1px] border-solid border-[#eee] rounded-[5px] text-[#777] text-[14px] outline-[0] h-[50px]" type="text" pattern="[0-9]*" required="required">
                                        </span>
                                        <div class="flex justify-center items-center space-x-4 mb-4">
                                            <button type="submit" class="gi-btn-1 btn py-[14px] px-[30px] bg-[#FF1493] text-[#fff] border-[0] transition-all duration-[0.3s] rounded-[5px] hover:bg-[#5caf90] hover:text-[#fff]">Xác Thực</button>
                                            <button type="button" id="resend-otp-btn" class="btn py-[14px] px-[30px] bg-[#f0f0f0] text-[#FF1493] border-[1px] border-solid border-[#FF1493] rounded-[5px] hover:bg-[#FF1493] hover:text-[#fff]" onclick="resendOtp()">Gửi Lại OTP</button>
                                        </div>
                                        <% if (request.getAttribute("message") != null) { %>
                                        <span class="text-danger"><%= request.getAttribute("message") %></span>
                                        <% } %>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="gi-otp-box w-[50%] px-[15px] max-[991px]:w-full max-[991px]:p-[0] max-[991px]:hidden">
                        <img src="${pageContext.request.contextPath}/assets/img/common/logo.jpeg" alt="login" class="w-[80%] rounded-[5px]">
                    </div>
                </div>
            </div>
        </section>
                    <jsp:include page="../common/homepage/footer.jsp"></jsp:include>
        <!-- Enter OTP section End -->
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
                                                    $('#resend-otp-btn').on('click', function () {
                                                        var button = $(this);
                                                        button.prop('disabled', true);
                                                        button.text('Gửi lại OTP (60s)');

                                                        // Send a request to the server to resend OTP
                                                        $.ajax({
                                                            url: '${pageContext.request.contextPath}/resendEmail', // URL to your servlet
                                                            method: 'POST',
                                                            success: function (response) {
                                                                Swal.fire({
                                                                    icon: 'success',
                                                                    title: 'OTP đã được gửi lại',
                                                                    showConfirmButton: false,
                                                                    timer: 1500
                                                                });
                                                            },
                                                            error: function () {
                                                                Swal.fire({
                                                                    icon: 'error',
                                                                    title: 'Có lỗi xảy ra khi gửi lại OTP.',
                                                                    showConfirmButton: false,
                                                                    timer: 1500
                                                                });
                                                                button.prop('disabled', false);
                                                                button.text('Gửi lại OTP');
                                                            }
                                                        });

                                                        var countdown = 60;
                                                        var interval = setInterval(function () {
                                                            countdown--;
                                                            button.text('Gửi lại OTP (' + countdown + 's)');
                                                            if (countdown <= 0) {
                                                                clearInterval(interval);
                                                                button.prop('disabled', false);
                                                                button.text('Gửi lại OTP');
                                                            }
                                                        }, 1000);
                                                    });
                                                });
        </script>
    </body>
</html>
