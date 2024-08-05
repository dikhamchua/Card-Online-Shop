<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <title>Hỗ Trợ</title>
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
            .form-container {
                max-width: 700px;
                margin: auto;
                padding: 2rem;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            .form-group label {
                font-weight: 600;
            }
            .form-group input, .form-group textarea {
                width: 100%;
                padding: 0.75rem;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-top: 0.5rem;
                font-size: 1rem;
            }
            .form-group textarea {
                resize: vertical;
            }
            .form-group input:focus, .form-group textarea:focus {
                border-color: #3182ce;
                outline: none;
            }
            .btn-submit {
                display: inline-block;
                padding: 0.75rem 1.5rem;
                color: #fff;
                background-color: #3182ce;
                border: none;
                border-radius: 4px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .btn-submit:hover {
                background-color: #2b6cb0;
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>

            <div class="container mx-auto my-10 form-container">
                <h2 class="text-3xl font-bold mb-6 text-center">Hỗ Trợ Khách Hàng</h2>
            <c:if test="${not empty successMessage}">
                <div class="bg-green-100 text-green-700 p-4 rounded-md mb-4">
                    ${successMessage}
                </div>
            </c:if>
            <form action="feedback" method="post">
                <input type="hidden" name="category" value="${category}">
                <div class="form-group mb-4">
                    <label for="name" class="block text-lg font-medium mb-2">Họ Và Tên:</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>
                <div class="form-group mb-4">
                    <label for="phone" class="block text-lg font-medium mb-2">Số Điện Thoại:<span class="text-sm text-gray-500">(Vui Lòng Nhập Chính Xác Để Nhân Viên Có Thể Hỗ Trợ Nhanh Nhất)</span></label>
                    <input type="text" id="phone" name="phone" class="form-control" required>
                </div>
                <div class="form-group mb-4">
                    <label for="message" class="block text-lg font-medium mb-2">Vấn Đề Gặp Phải:</label>
                    <textarea id="message" name="message" class="form-control" rows="4" required>${category}</textarea>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn-submit">Gửi</button>
                </div>
            </form>
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
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                 const category = '${category}';
                const messageField = document.getElementById('message');
                if (category) {
                    const formattedCategory = category.replace(/([a-z])([A-Z])/g, '$1 $2');
                    messageField.value = formattedCategory.replace(/([A-Z])/g, ' $1').trim();
                }
            });
        </script>F
    </body>
</html>

