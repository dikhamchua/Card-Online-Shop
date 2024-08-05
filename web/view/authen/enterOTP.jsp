<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <title>Nhập OTP - CardLord</title>
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
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
                background-color: #FFF0F6;
            }
            .otp-input {
                margin: 0 auto;
                padding: 40px;
                border-radius: 10px;
                background-color: #FFFFFF;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                max-width: 800px;
                margin-right: 50px;
            }
            .btn-primary {
                background-color: #FF1493;
                border-color: #FF1493;
                color: #ffffff;
                font-size: 18px;
                padding: 12px 40px;
                width: 100%;
            }
            .btn-primary:hover {
                background-color: #e01383;
                border-color: #e01383;
            }
            .btn-secondary {
                background-color: #f0f0f0;
                border-color: #FF1493;
                color: #FF1493;
                font-size: 16px;
                padding: 12px 40px;
                width: 100%;
                transition: all 0.3s;
            }
            .btn-secondary:hover {
                background-color: #FF1493;
                color: #ffffff;
            }
            .form-group {
                margin-bottom: 1.5rem;
            }
            .input-group-addon {
                background-color: #FF1493;
                border: none;
                color: white;
            }
            .input-group .form-control {
                height: 45px;
                border: 2px solid #FF1493;
                border-radius: 5px;
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
        <!-- Header start  -->
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>

            <!-- Enter OTP Section Start -->
            <section class="gi-hero h-full w-full my-[40px] max-[575px]:my-[30px] max-[1199px]:relative">
                <div class="container">
                    <div class="flex flex-wrap justify-center items-center mx-auto min-[1600px]:max-w-[1600px] min-[1400px]:max-w/[1320px] min-[1200px]:max-w/[1140px] min-[992px]:max-w/[960px] min-[768px]:max-w/[720px] min-[576px]:max-w/[540px]">
                        <div class="otp-input">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="text-center">
                                        <h2 class="gi-title mb-[0] font-manrope text-[26px] font-semibold text-[#FF1493] relative inline p-[0] capitalize leading-[1]">Nhập OTP</h2>
                                    <% if (request.getAttribute("message") != null) { %>
                                    <p class="text-danger"><%= request.getAttribute("message") %></p>
                                    <% } %>
                                    <div class="panel-body">
                                        <form id="register-form" action="ValidateOtp" role="form" autocomplete="off" class="form" method="post">
                                            <input type="hidden" id="email" name="email" value="<%= session.getAttribute("email") %>">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-envelope color-blue"></i></span>
                                                    <input id="otp" name="otp" placeholder="Nhập OTP" class="form-control" type="text" required="required">
                                                </div>
                                            </div>
                                            <div class="flex justify-center items-center space-x-4 mb-4">
                                                <button type="submit" class="btn-primary">Xác Nhận</button>
                                                <button type="button" id="resendOtpBtn" class="btn-secondary" onclick="resendOtp()">Gửi Lại OTP</button>
                                            </div>
                                            <input type="hidden" class="hide" name="token" id="token" value="">
                                        </form>
                                        <script>
                                            function getEmail() {
                                                return document.getElementById('email').value;
                                            }
                                            function resetOtpAttempts(email) {
                                                sessionStorage.removeItem(email + '_otpAttempts');
                                            }

                                            function setOtpSentFlag(email) {
                                                sessionStorage.setItem(email + '_otpSent', 'true');
                                            }

                                            function checkOtpSentFlag(email) {
                                                return sessionStorage.getItem(email + '_otpSent') === 'true';
                                            }

                                            document.getElementById('otp').addEventListener('input', function (event) {
                                                this.value = this.value.replace(/[^0-9]/g, '');
                                            });

                                            document.getElementById('register-form').addEventListener('submit', function (event) {
                                                var email = getEmail();
                                                var attemptsKey = email + '_otpAttempts';
                                                var attempts = parseInt(sessionStorage.getItem(attemptsKey)) || 0;

                                                if (attempts >= 3) {
                                                    event.preventDefault();
                                                    alert('Bạn đã nhập sai mã OTP quá số lần quy định. Hãy yêu cầu mã OTP mới!');
                                                    document.getElementById('otp').value = ''; // Reset input field
                                                    return false;
                                                } else {
                                                    sessionStorage.setItem(attemptsKey, attempts + 1);
                                                }
                                            });

                                            document.getElementById('resendOtpBtn').addEventListener('click', function () {
                                                var xhr = new XMLHttpRequest();
                                                xhr.open('POST', 'resendOtp', true);
                                                xhr.onreadystatechange = function () {
                                                    if (xhr.readyState === 4 && xhr.status === 200) {
                                                        alert(xhr.responseText);
                                                        var email = getEmail();
                                                        resetOtpAttempts(email);
                                                        setOtpSentFlag(email);
                                                        disableResendButton();
                                                    }
                                                };
                                                xhr.send();
                                            });
                                            function disableResendButton() {
                                                var resendButton = document.getElementById('resendOtpBtn');
                                                resendButton.disabled = true;
                                                var countdown = 60;
                                                var interval = setInterval(function () {
                                                    if (countdown <= 0) {
                                                        clearInterval(interval);
                                                        resendButton.disabled = false;
                                                        resendButton.textContent = 'Gửi Lại OTP';
                                                    } else {
                                                        resendButton.textContent = 'Gửi Lại OTP (' + countdown + 's)';
                                                        countdown--;
                                                    }
                                                }, 1000);
                                            }

                                            // Reset OTP attempts on page load if a new OTP was sent
                                            window.addEventListener('load', function () {
                                                var email = getEmail();
                                                if (checkOtpSentFlag(email)) {
                                                    resetOtpAttempts(email);
                                                    sessionStorage.removeItem(email + '_otpSent');
                                                }
                                            });
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="w-[40%] px-[15px] max-[991px]:w-full max-[991px]:p-[0] max-[991px]:hidden">
                        <img src="${pageContext.request.contextPath}/assets/img/common/logo.jpeg" alt="login" class="w-[80%] rounded-[5px]">
                    </div>
                </div>
            </div>
        </section>
        <!-- Enter OTP Section End -->

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
