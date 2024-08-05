package controller.user;

import dal.implement.ActivityLogDAO;
import entity.ActivityLog;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ActivityLogServlet", urlPatterns = {"/ActivityLogServlet"})
public class ActivityLogServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("users");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/authen?action=login");
            return;
        }

        ActivityLogDAO activityLogDAO = new ActivityLogDAO();
        List<ActivityLog> activityLogs = activityLogDAO.getActivityLogsByUserId(user.getID());

        request.setAttribute("activityLogs", activityLogs);
        request.getRequestDispatcher("view/user/activitylog.jsp").forward(request, response);
    }
}
