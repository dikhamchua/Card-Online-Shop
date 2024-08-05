package controller.admin;

import dal.implement.ReviewDAO;
import dal.implement.UsersDAO;
import entity.Review;
import entity.Users;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DashboardReviewServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        ReviewDAO reviewDAO = new ReviewDAO();
        UsersDAO usersDAO = new UsersDAO();

        // Lấy tất cả danh sách đánh giá đã được sắp xếp
        List<Review> reviews = reviewDAO.findAll();

        // Tạo một bản đồ để lưu thông tin tên người dùng theo userID
        Map<Integer, String> userNamesMap = new HashMap<>();
        for (Review review : reviews) {
            Users user = usersDAO.findById(review.getUserID());
            if (user != null) {
                userNamesMap.put(review.getUserID(), user.getUserName());
            }
        }

        // Đặt thuộc tính cho request
        request.setAttribute("reviews", reviews);
        request.setAttribute("userNamesMap", userNamesMap);

        // Chuyển tiếp đến trang JSP
        request.getRequestDispatcher("view/admin/dashboardReview.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Dashboard Review Servlet";
    }
}
