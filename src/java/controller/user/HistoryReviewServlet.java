package controller.user;

import dal.implement.HistoryReviewDAO;
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

@WebServlet(name = "HistoryReviewServlet", urlPatterns = {"/historyReview"})
public class HistoryReviewServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private HistoryReviewDAO historyReviewDAO = new HistoryReviewDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Users user = (Users) request.getSession().getAttribute("users");

        if (user == null) {
            response.sendRedirect("authen?action=login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "edit":
                showEditReviewPage(request, response);
                break;
            case "update":
                updateReview(request, response);
                break;
            case "delete":
                deleteReview(request, response);
                break;
            default:
                showHistoryReviews(request, response, user);
                break;
        }
    }

    private void showEditReviewPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("id"));
        Review review = historyReviewDAO.getReviewById(reviewId);
        request.setAttribute("review", review);
        request.getRequestDispatcher("view/user/editReview.jsp").forward(request, response);
    }

    private void updateReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String title = request.getParameter("title");

        Review review = Review.builder()
                .id(reviewId)
                .rating(rating)
                .title(title)
                .updatedAt(LocalDateTime.now())
                .build();

        boolean isUpdated = historyReviewDAO.updateReview(review);
        if (isUpdated) {
            request.setAttribute("message", "Đánh giá đã được cập nhật thành công.");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại.");
        }

        response.sendRedirect(request.getContextPath() + "/historyReview");
    }

    private void deleteReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("id"));
        boolean isDeleted = historyReviewDAO.deleteReview(reviewId);
        if (isDeleted) {
            request.setAttribute("message", "Đánh giá đã được xóa thành công.");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại.");
        }

        response.sendRedirect(request.getContextPath() + "/historyReview");
    }

    private void showHistoryReviews(HttpServletRequest request, HttpServletResponse response, Users user)
            throws ServletException, IOException {
        int page = 1;
        int recordsPerPage = 10;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        LocalDateTime startDate = null;
        LocalDateTime endDate = null;

        try {
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = LocalDateTime.parse(startDateStr + "T00:00:00");
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = LocalDateTime.parse(endDateStr + "T23:59:59");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        int userId = user.getID();
        List<Review> list = historyReviewDAO.getReviewsByUserIDAndDateRange(userId, (page - 1) * recordsPerPage, recordsPerPage, startDate, endDate);
        int noOfRecords = historyReviewDAO.getNoOfRecords();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

        request.setAttribute("listReview", list);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("startDate", startDateStr);
        request.setAttribute("endDate", endDateStr);

        request.getRequestDispatcher("view/user/historyReview.jsp").forward(request, response);
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
        return "History Review Servlet";
    }
}