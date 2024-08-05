<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CardLord-Trading - Nạp Tiền</title>
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/logo/logo100.jpg" sizes="32x32">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
        <script src="https://cdn.tailwindcss.com"></script>
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
                background-color: #f0f2f5;
                background-image: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            }
            .container {
                max-width: 1000px;
                margin: 3rem auto;
                padding: 2rem;
                background-color: white;
                border-radius: 1rem;
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            }
            .header-title {
                color: #FF1493;
                font-size: 2.5rem;
                font-weight: bold;
                text-align: center;
                margin-bottom: 2rem;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
                letter-spacing: 1px;
            }
            .balance-card {
                background: linear-gradient(45deg, #FF69B4, #FF1493);
                color: white;
                border-radius: 1rem;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 10px 15px -3px rgba(255, 20, 147, 0.3);
                position: relative;
                overflow: hidden;
            }
            .balance-card::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.2) 0%, transparent 60%);
                transform: rotate(30deg);
            }
            .balance-title {
                font-size: 1.2rem;
                margin-bottom: 0.5rem;
                position: relative;
                z-index: 1;
            }
            .balance-amount {
                font-size: 2.2rem;
                font-weight: bold;
                position: relative;
                z-index: 1;
            }
            .deposit-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                border-radius: 1rem;
                overflow: hidden;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                margin-top: 2rem;
            }
            .deposit-table th, .deposit-table td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid #e2e8f0;
            }
            .deposit-table th {
                background-color: #FF1493;
                color: white;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .deposit-table tr:last-child td {
                border-bottom: none;
            }
            .deposit-table tr:nth-child(even) {
                background-color: #f8f9fa;
            }
            .deposit-table tr:hover {
                background-color: #e9ecef;
            }
            .form-control, .form-select {
                width: 100%;
                padding: 0.75rem;
                border: 2px solid #e2e8f0;
                border-radius: 0.5rem;
                transition: all 0.3s ease;
                background-color: rgba(255,255,255,0.8);
            }
            .form-control:focus, .form-select:focus {
                outline: none;
                border-color: #FF1493;
                box-shadow: 0 0 0 3px rgba(255, 20, 147, 0.1);
                transform: translateY(-2px);
            }
            .btn-primary {
                background-color: #FF1493;
                color: white;
                border: none;
                padding: 0.75rem 1rem;
                font-weight: bold;
                border-radius: 0.5rem;
                transition: all 0.3s ease;
                cursor: pointer;
                width: 100%;
                text-align: center;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .btn-primary:hover {
                background-color: #FF69B4;
                transform: translateY(-2px);
                box-shadow: 0 4px 6px rgba(255, 20, 147, 0.2);
            }
        </style>
    </head>

    <body class="bg-gray-100">
        <jsp:include page="../common/homepage/header.jsp"></jsp:include>

            <div class="container">
                <h1 class="header-title">Tạo Yêu Cầu Nạp Tiền</h1>

                <div class="balance-card">
                    <div class="balance-title">Số dư tài khoản hiện tại:</div>
                    <div class="balance-amount">
                    <fmt:formatNumber value="${requestScope.total.getWallet()}" minFractionDigits="0" /> VNĐ
                </div>
            </div>

            <form action="addWallet" method="post" id="moneyForm">
                <table class="deposit-table">
                    <thead>
                        <tr>
                            <th>Nạp Tiền</th>
                            <th>Hạn mức và Phí</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <label for="amount">Số tiền muốn nạp:</label>
                                <input type="number" name="amount" class="form-control" id="amount" required placeholder="Nhập số tiền">
                            </td>
                            <td>
                                <p>Số tiền tối thiểu: 5,000 VND</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="preset-amounts">Chọn số tiền:</label>
                                <select class="form-select" id="preset-amounts">
                                    <option value="" selected>Chọn số tiền</option>
                                    <option value="10000">10,000 VNĐ</option>
                                    <option value="20000">20,000 VNĐ</option>
                                    <option value="50000">50,000 VNĐ</option>
                                    <option value="100000">100,000 VNĐ</option>
                                    <option value="200000">200,000 VNĐ</option>
                                    <option value="500000">500,000 VNĐ</option>
                                    <option value="1000000">1,000,000 VNĐ</option>
                                </select>
                            </td>
                            <td>
                                <p>Số tiền tối đa: 500,000,000 VND</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <button type="submit" class="btn-primary">Nạp Tiền</button>
                            </td>
                            <td>
                                <p>Phí giao dịch: 0 VND</p>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>

        <jsp:include page="../common/homepage/footer.jsp"></jsp:include>

            <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

        <script>
            document.getElementById('preset-amounts').addEventListener('change', function () {
                var amount = this.value;
                document.getElementById('amount').value = amount;
            });

            document.getElementById('moneyForm').addEventListener('submit', function (event) {
                var amount = document.getElementById('amount').value;
                var vndFormat = /^\d+000$/;  // Accepts digits ending with three zeros
                if (!vndFormat.test(amount) || (amount < 5000 || amount > 500000000)) {
                    event.preventDefault();
                    alert('Vui lòng nhập giá tiền từ 5.000 VNĐ đến 500.000.000 VNĐ');
                }
            });
        </script>
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