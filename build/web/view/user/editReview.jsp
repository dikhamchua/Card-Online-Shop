<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <title>CardLord-Trading - Chỉnh sửa đánh giá dịch vụ</title>
        <meta name="keywords" content="cardlord, trading, đánh giá, chỉnh sửa">
        <meta name="description" content="Chỉnh sửa đánh giá dịch vụ CardLord-Trading">
        <meta name="author" content="CardLord-Trading">
        <!-- Favicon -->
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- Main Style -->
        <link rel="stylesheet" id="main_style" href="${pageContext.request.contextPath}/assets/css/style.css">
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
            .container {
                max-width: 1200px;
            }
            th {
                font-weight: 600;
            }
            td {
                font-weight: 400;
            }
            .bg-pink-200 {
                background-color: #FFB6C1;
            }
            .text-pink-700 {
                color: #FF1493;
            }
            .hover\:bg-pink-300:hover {
                background-color: #FF69B4;
            }
            .bg-pink-500 {
                background-color: #FF1493;
            }
            .textarea-border {
                border: 2px solid #FF1493;
                padding: 8px;
                border-radius: 5px;
            }
            .star-rating {
                display: flex;
                justify-content: center;
                gap: 5px;
            }
            .star {
                cursor: pointer;
                font-size: 2rem;
                color: #d1d5db;
            }
            .star.selected,
            .star:hover,
            .star:hover ~ .star {
                color: #ff1493;
            }
        </style>
    </head>
    <body class="w-full h-full relative font-Poppins font-normal overflow-x-hidden" style="background-color: #FFF0F6">
        <!-- Header start  -->
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>

            <div class="container mx-auto px-4 py-8">
                <div class="bg-white rounded-lg shadow-lg p-6">
                    <h2 class="text-center text-2xl font-semibold text-[#FF1493] mb-6">Chỉnh sửa đánh giá sản phẩm</h2>

                    <!-- Display success message if present -->
                    <c:if test="${not empty message}">
                    <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4">
                        <span class="block sm:inline">${message}</span>
                    </div>
                </c:if>
                <!-- Display error message if present -->
                <c:if test="${not empty error}">
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4">
                        <span class="block sm:inline">${error}</span>
                    </div>
                </c:if>

                <!-- Order Details -->
                <div>
                    <p><strong>Mã đơn hàng:</strong> ${review.orderID}</p>
                </div>

                <!-- Rating and Review Form -->
                <form action="${pageContext.request.contextPath}/historyReview?action=update" method="post" class="mt-6">
                    <input type="hidden" name="reviewId" value="${review.id}">
                    <input type="hidden" name="rating" id="rating" value="${review.rating}">

                    <div class="mb-4">
                        <label for="rating" class="block text-gray-700">Đánh giá của bạn:</label>
                        <div class="star-rating">
                            <i class="fas fa-star star" data-value="1"></i>
                            <i class="fas fa-star star" data-value="2"></i>
                            <i class="fas fa-star star" data-value="3"></i>
                            <i class="fas fa-star star" data-value="4"></i>
                            <i class="fas fa-star star" data-value="5"></i>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="title" class="block text-gray-700">Nhận xét:</label>
                        <textarea id="title" name="title" rows="4" class="form-textarea mt-1 block w-full textarea-border">${review.title}</textarea>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="px-4 py-2 bg-pink-500 text-white text-base font-medium rounded-md w-full shadow-sm hover:bg-pink-700 focus:outline-none focus:ring-2 focus:ring-pink-300">
                            Cập nhật đánh giá
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Footer Start -->
        <jsp:include page="../common/homepage/footer.jsp"></jsp:include>
            <!-- Footer Area End -->

            <!-- Main Js -->
            <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                const stars = document.querySelectorAll('.star');
                const ratingInput = document.getElementById('rating');

                stars.forEach(star => {
                    star.addEventListener('click', () => {
                        stars.forEach(s => s.classList.remove('selected'));
                        star.classList.add('selected');
                        let previousSibling = star.previousElementSibling;
                        while (previousSibling) {
                            previousSibling.classList.add('selected');
                            previousSibling = previousSibling.previousElementSibling;
                        }
                        let nextSibling = star.nextElementSibling;
                        while (nextSibling) {
                            nextSibling.classList.remove('selected');
                            nextSibling = nextSibling.nextElementSibling;
                        }
                        ratingInput.value = star.getAttribute('data-value');
                    });

                    star.addEventListener('mouseover', () => {
                        stars.forEach(s => s.classList.remove('hover'));
                        star.classList.add('hover');
                        let previousSibling = star.previousElementSibling;
                        while (previousSibling) {
                            previousSibling.classList.add('hover');
                            previousSibling = previousSibling.previousElementSibling;
                        }
                    });

                    star.addEventListener('mouseout', () => {
                        stars.forEach(s => s.classList.remove('hover'));
                    });
                });

                // Set initial star ratings based on the value from the backend
                const initialRating = ratingInput.value;
                stars.forEach(star => {
                    if (star.getAttribute('data-value') <= initialRating) {
                        star.classList.add('selected');
                    }
                });
            });
        </script>
    </body>
</html>