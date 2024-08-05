package controller.user;

import dal.implement.CardDAO;
import dal.implement.CardTypeDAO;
import dal.implement.OrderDetailsDAO;
import dal.implement.OrdersDAO;
import dal.implement.PriceDAO;
import entity.Cards;
import entity.OrderDetails;
import entity.Orders;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import entity.CardTypes;
import entity.Price;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "UserOrdersServlet", urlPatterns = {"/UserOrdersServlet"})
public class UserOrdersServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10; // Number of orders per page

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("users");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/authen?action=login");
            return;
        }

        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        int pageNumber = 1;
        if (request.getParameter("page") != null) {
            pageNumber = Integer.parseInt(request.getParameter("page"));
        }

        OrdersDAO ordersDAO = new OrdersDAO();
        List<Orders> userOrders;

        if (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty()) {
            // Nếu có tham số ngày bắt đầu và kết thúc, lấy danh sách đơn hàng trong khoảng thời gian đó
            userOrders = ordersDAO.findOrdersByUserIDAndDateRange(user.getID(), LocalDate.parse(startDate), LocalDate.parse(endDate), pageNumber, PAGE_SIZE);
        } else {
            userOrders = ordersDAO.findOrdersByUserIDWithPagination(user.getID(), pageNumber, PAGE_SIZE);
        }

        int totalOrders = ordersDAO.countOrdersByUserID(user.getID());
        int totalPages = (int) Math.ceil((double) totalOrders / PAGE_SIZE);

        request.setAttribute("userOrders", userOrders);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.getRequestDispatcher("view/payment/userOrder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("getOrderDetails".equals(action)) {
            getOrderDetails(request, response);
        }
    }

    private void getOrderDetails(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
        CardDAO cardDAO = new CardDAO();

        List<OrderDetails> orderDetails = orderDetailsDAO.findByOrderId(orderId);// Lấy danh sách chi tiết đơn hàng
        StringBuilder htmlResponse = new StringBuilder();

        htmlResponse.append("<table id='detailsTable' class='min-w-full bg-white'>")
                .append("<thead>")
                .append("<tr>")
                .append("<th class='py-2'>Loại Thẻ</th>")
                .append("<th class='py-2'>Giá</th>")
                .append("<th class='py-2'>Số Seri</th>")
                .append("<th class='py-2'>Mã thẻ</th>")
                .append("<th class='py-2'>Hạn Sử Dụng</th>")
                .append("</tr>")
                .append("</thead>")
                .append("<tbody>");

        for (OrderDetails od : orderDetails) {
            Cards card = cardDAO.findById(od.getCardID());
            CardTypes cardType = new CardTypeDAO().findByCardId(card.getID());
            Price price = new PriceDAO().findByCardId(card.getID());
            htmlResponse.append("<tr>")
                    .append("<td>").append(cardType.getCardTypeName()).append("</td>")
                    .append("<td>").append(price.getPrice()).append("</td>")
                    .append("<td>").append(card.getSerialNumber()).append("</td>")
                    .append("<td>").append(card.getCardCode()).append("</td>")
                    .append("<td>").append(card.getExpirationDate()).append("</td>")
                    .append("</tr>");
        }
        htmlResponse.append("</tbody>").append("</table>");

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(htmlResponse.toString());
        out.flush();
    }

}
