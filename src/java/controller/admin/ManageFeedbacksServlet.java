package controller.admin;

import dal.implement.FeedbackDAO;
import entity.Feedback;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/manageFeedbacks")
public class ManageFeedbacksServlet extends HttpServlet {

    private final FeedbackDAO feedbackDAO = new FeedbackDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Feedback> feedbackList = feedbackDAO.findAllWithUserDetails();
        request.setAttribute("feedbackList", feedbackList);
        request.getRequestDispatcher("/view/admin/dashboardSupport.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
        feedbackDAO.markAsResolved(feedbackId); // Đánh dấu phản hồi là đã được giải quyết
        response.sendRedirect(request.getContextPath() + "/admin/manageFeedbacks");
    }
}
    