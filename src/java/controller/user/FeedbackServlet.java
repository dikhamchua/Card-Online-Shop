package controller.user;

import dal.implement.FeedbackDAO;
import entity.Feedback;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {

    FeedbackDAO feedbackDAO = new FeedbackDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        if (category != null) {
            request.setAttribute("category", category);
            request.getRequestDispatcher("/view/user/feedbackForm.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/view/user/feedback.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            // Handle the case where the user is not logged in
            response.sendRedirect("authen?action=login");
            return;
        }

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");
        String category = request.getParameter("category");

        Feedback feedback = Feedback.builder()
                .name(name)
                .phone(phone)
                .message(message)
                .created_at(new Timestamp(System.currentTimeMillis()))
                .user_id(userId) // Set user_id from session
                .build();

        feedbackDAO.insert(feedback);

        request.setAttribute("successMessage", "Phản ánh của bạn đã được gửi thành công!");
        request.setAttribute("category", category);
        request.getRequestDispatcher("/view/user/feedbackForm.jsp").forward(request, response);
    }
}
