package controller.user;

import dal.implement.OrderDetailsDAO;
import dal.implement.ReviewDAO;
import dal.implement.OrdersDAO;
import entity.Orders;
import entity.Review;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/UserReviewsServlet")
public class UserReviewsServlet extends HttpServlet {

    private ReviewDAO reviewDAO = new ReviewDAO();
    private OrdersDAO ordersDAO = new OrdersDAO();
    private OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Users user = (Users) request.getSession().getAttribute("users");

        if (user != null) {
            int userId = user.getID();
            List<Orders> userOrders = ordersDAO.getOrdersByUserID(userId);
            List<Review> listReview = reviewDAO.getReviewsByUserID(userId);

            // Lấy orderID từ request
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr != null) {
                int orderId = Integer.parseInt(orderIdStr);
                List<String> productNames = orderDetailsDAO.getCardNamesByOrderID(orderId);
                request.setAttribute("productNames", productNames);
            }

            request.setAttribute("orders", userOrders);
            request.setAttribute("listReview", listReview);
            request.getRequestDispatcher("view/user/reviews.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        switch (action) {
            case "add":
                if (addReview(request, response)) {
                    request.setAttribute("message", "Đánh giá thành công!");
                } else {
                    request.setAttribute("error", "Không được để trống nội dung hoặc số sao đánh giá.");
                }
                processRequest(request, response);
                break;
            default:
                processRequest(request, response);
        }
    }

    private boolean addReview(HttpServletRequest request, HttpServletResponse response) {
        String ratingStr = request.getParameter("rating");
        String title = request.getParameter("title");
        String orderIdStr = request.getParameter("orderId");

        if (title == null || title.trim().isEmpty() || ratingStr.equals("0")) {
            return false;
        }

        Users user = (Users) request.getSession().getAttribute("users");
        int userID = user.getID();
        int rating = Integer.parseInt(ratingStr);
        int orderId = Integer.parseInt(orderIdStr);
        LocalDateTime createdAt = LocalDateTime.now();
        LocalDateTime updatedAt = LocalDateTime.now();

        Review newReview = new Review();
        newReview.setUserID(userID);
        newReview.setRating(rating);
        newReview.setTitle(title);
        newReview.setCreatedAt(createdAt);
        newReview.setUpdatedAt(updatedAt);
        newReview.setOrderID(orderId);

        reviewDAO.addReview(newReview);
        return true;
    }

    @Override
    public String getServletInfo() {
        return "Review Servlet";
    }
}
