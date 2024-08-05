package controller.admin;

import dal.implement.NotificationDAO;
import entity.Notification;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet({"/admin/notifyUsers", "/admin/deleteNotification", "/admin/notifications"})
public class AdminNotificationController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        NotificationDAO notificationDAO = new NotificationDAO();
        List<Notification> notifications = notificationDAO.findAllGlobalNotifications(page, PAGE_SIZE);
        int totalNotifications = notificationDAO.countGlobalNotifications();
        int totalPages = (int) Math.ceil(totalNotifications * 1.0 / PAGE_SIZE);

        request.setAttribute("notifications", notifications);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/view/admin/adminNotification.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        if (action.equals("/admin/notifyUsers")) {
            String message = request.getParameter("message");
            String userIdStr = request.getParameter("userId");
            boolean forAllUsers = (userIdStr == null || userIdStr.trim().isEmpty());

            NotificationDAO notificationDAO = new NotificationDAO();
            Notification notification = new Notification();
            notification.setMessage(message);
            notification.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            notification.setForAllUsers(forAllUsers);

            if (!forAllUsers) {
                try {
                    int userId = Integer.parseInt(userIdStr);
                    notification.setUserID(userId);
                } catch (NumberFormatException e) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Invalid user ID format");
                    return;
                }
            } else {
                notification.setUserID(18);
            }

            if (notificationDAO.addNotification(notification)) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Notification added");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Error adding notification");
            }
        } else if (action.equals("/admin/deleteNotification")) {
            int notificationId = Integer.parseInt(request.getParameter("notificationId"));

            NotificationDAO notificationDAO = new NotificationDAO();
            if (notificationDAO.deleteNotification(notificationId)) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Notification deleted");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Error deleting notification");
            }
        }
    }
}
