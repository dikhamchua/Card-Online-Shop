<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <title>CardLord-Payment Success</title>
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

        <style>
            body {
                background-color: #F0F4F8; /* Light background */
                font-family: 'Roboto', sans-serif;
            }

            .success-message {
                background-color: #FFEBF0; /* Light Pink background */
                padding: 10px 20px; /* Reduced padding */
                border-radius: 8px;
                text-align: center;
                color: #FF69B4; /* Pink color */
                font-size: 18px;
                font-weight: bold;
                margin-top: 20px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                max-width: 500px; /* Reduced max width */
                margin-left: auto;
                margin-right: auto;
            }

            .gi-cart-section {
                padding-top: 20px; /* Reduce top padding */
                padding-bottom: 20px; /* Reduce bottom padding */
                min-height: calc(100vh - 100px); /* Ensure section doesn't take full height */
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body class="w-full h-full relative font-Poppins font-normal overflow-x-hidden">
        <!-- Header start  -->
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>

            <!-- Success section -->
            <section class="gi-cart-section flex justify-center items-center">
                <h2 class="hidden">Payment Success</h2>
                <div class="flex justify-center items-center mx-auto w-full">
                    <div class="w-full px-6">
                        <div class="success-message">
                            Mua thẻ thành công, hãy kiểm tra trong kho của bạn.
                        </div>
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
    </body>
</html>
