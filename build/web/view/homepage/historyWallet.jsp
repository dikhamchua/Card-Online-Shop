<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <title>CardLord-Trading - Lịch sử nạp tiền</title>
        <meta name="keywords" content="cardlord, trading, nạp tiền, lịch sử">
        <meta name="description" content="Lịch sử nạp tiền CardLord-Trading">
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
        </style>
        <style>
            .transaction-icon {
                font-size: 1em;
                margin-left: 5px;
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
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 30px;
            }
            .page-item {
                margin: 0 5px;
            }
            .page-link {
                padding: 8px 12px; /* Điều chỉnh padding */
                font-size: 1em; /* Điều chỉnh kích thước font chữ */
                color: #FF1493;
                background-color: #fff;
                border: 1px solid #FF1493;
                border-radius: 5px;
                transition: all 0.3s ease;
            }
            .page-item.active .page-link,
            .page-link:hover {
                color: #fff;
                background-color: #FF1493;
            }
            .page-item.disabled .page-link {
                color: #6c757d;
                pointer-events: none;
                background-color: #fff;
                border-color: #dee2e6;
            }
        </style>
    </head>
    <body class="w-full h-full relative font-Poppins font-normal overflow-x-hidden" style="background-color: #FFF0F6">
        <!-- Header start  -->
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>

            <div class="container mx-auto px-4 py-8">
                <div class="bg-white rounded-lg shadow-lg p-6">
                    <h2 class="text-center text-2xl font-semibold text-[#FF1493] mb-6">Lịch sử giao dịch</h2>

                    <!-- Bộ lọc -->
                    <form action="${pageContext.request.contextPath}/historyWallet" method="get" class="mb-6 flex justify-center">
                    <div class="flex items-center space-x-4">
                        <label for="startDate" class="text-[#FF1493]">Từ ngày:</label>
                        <input type="date" id="startDate" name="startDate" value="${startDate}" class="p-2 border border-gray-300 rounded-md">
                        <label for="endDate" class="text-[#FF1493]">Đến ngày:</label>
                        <input type="date" id="endDate" name="endDate" value="${endDate}" class="p-2 border border-gray-300 rounded-md">
                        <button type="submit" class="bg-[#FF1493] text-white px-4 py-2 rounded-md hover:bg-pink-700 transition-all">Lọc</button>
                    </div>
                </form>

                <!-- Tìm kiếm -->
                <form action="${pageContext.request.contextPath}/historyWallet" method="get" class="mb-6 flex justify-center">
                    <div class="flex items-center space-x-4">
                        <input type="text" name="searchKeyword" value="${searchKeyword}" placeholder="Tìm kiếm" class="p-2 border border-gray-300 rounded-md">
                        <button type="submit" class="bg-[#FF1493] text-white px-4 py-2 rounded-md hover:bg-pink-700 transition-all">Tìm kiếm</button>
                    </div>
                </form>

                <div class="overflow-x-auto">
                    <c:if test="${not empty requestScope.list}">
                        <table class="table-auto w-full">
                            <thead>
                                <tr class="bg-[#FF1493] text-white">
                                    <th class="px-4 py-2">Số thứ tự</th>
                                    <th class="px-4 py-2">Giá tiền</th>
                                    <th class="px-4 py-2">Ngày nạp</th>
                                    <th class="px-4 py-2">Ghi Chú</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.list}" var="item">
                                    <tr class="border-b hover:bg-gray-100">
                                        <td class="px-4 py-2 text-center">${item.id}</td>
                                        <td class="px-4 py-2 text-center">
                                            <c:choose>
                                                <c:when test="${item.status == 'Nạp tiền không thành công'}">
                                                    <span class="text-red-500"><fmt:formatNumber value="${item.amount}" minFractionDigits="0"/></span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="<c:choose><c:when test='${item.amount >= 0}'>text-green-500</c:when><c:otherwise>text-red-500</c:otherwise></c:choose>">
                                                        <fmt:formatNumber value="${item.amount}" minFractionDigits="0"/> 
                                                        <i class="fas <c:choose><c:when test='${item.amount >= 0}'>fa-arrow-up</c:when><c:otherwise>fa-arrow-down</c:otherwise></c:choose> transaction-icon"></i>
                                                            </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-4 py-2 text-center">
                                            <fmt:parseDate value="${item.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both"/>
                                            <fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${parsedDateTime}"/>
                                        </td>
                                        <td class="px-4 py-2 text-center">
                                            ${item.status}
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${empty requestScope.list}">
                        <div class="text-center text-red-500 font-semibold">
                            Không có kết quả nào.
                        </div>
                    </c:if>
                </div>

                <!-- Pagination -->
                <div class="mt-4 text-center">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
                                <a class="page-link" href="${pageContext.request.contextPath}/historyWallet?page=${currentPage - 1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <c:forEach var="i" begin="1" end="${noOfPages}">
                                <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                                    <a class="page-link" href="${pageContext.request.contextPath}/historyWallet?page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item <c:if test='${currentPage == noOfPages}'>disabled</c:if>">
                                <a class="page-link" href="${pageContext.request.contextPath}/historyWallet?page=${currentPage + 1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <!-- Footer Start -->
        <jsp:include page="../common/homepage/footer.jsp"></jsp:include>
            <!-- Footer Area End -->

            <!-- Main Js -->
            <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
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