package controller.homepage;

import entity.Notification;
import dal.implement.NotificationDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.Users;
import jakarta.servlet.http.HttpSession;

@WebServlet("/notifications")
public class NotificationController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("users");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getID();
        int page = 1;
        int recordsPerPage = 10;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        int offset = (page - 1) * recordsPerPage;

        NotificationDAO notificationDAO = new NotificationDAO();
        int unreadCount = notificationDAO.countUnreadNotifications(user.getID());
        int totalRecords = notificationDAO.countNotificationsByUserId(userId);
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        List<Notification> notifications = notificationDAO.findByUserIdWithPagination(userId, offset, recordsPerPage);

        request.setAttribute("unreadCount", unreadCount);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("notifications", notifications);

        request.getRequestDispatcher("/view/homepage/notifications.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        NotificationDAO notificationDAO = new NotificationDAO();

        switch (action) {
            case "markAsRead":
                int notificationIdRead = Integer.parseInt(request.getParameter("notificationId"));
                notificationDAO.updateNotificationStatus(notificationIdRead, true);
                response.getWriter().write("Thông báo đã đọc");
                break;
            case "markAsUnread":
                int notificationIdUnread = Integer.parseInt(request.getParameter("notificationId"));
                notificationDAO.updateNotificationStatus(notificationIdUnread, false);
                response.getWriter().write("Thông báo đã được đánh dấu là chưa đọc");
                break;
            case "markAllAsRead":
                HttpSession session = request.getSession();
                Users user = (Users) session.getAttribute("users");
                if (user != null) {
                    notificationDAO.markAllAsRead(user.getID());
                    response.getWriter().write("Tất cả thông báo đã đọc :D");
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User not logged in");
                }
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
}
