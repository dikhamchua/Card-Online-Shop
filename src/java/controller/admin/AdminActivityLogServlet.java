package controller.admin;

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

@WebServlet(name = "AdminActivityLogServlet", urlPatterns = {"/admin/activityLog", "/admin/activityLog/details"})
public class AdminActivityLogServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("users");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/authen?action=login");
            return;
        }

        ActivityLogDAO activityLogDAO = new ActivityLogDAO();

        try {
            if (action.equals("/admin/activityLog/details")) {
                //xem chi tiết
                int userId = Integer.parseInt(request.getParameter("userId"));
                List<ActivityLog> activityLogs = activityLogDAO.getActivityLogsByUserId(userId);

                response.setContentType("text/html;charset=UTF-8");
                StringBuilder html = new StringBuilder();
                html.append("<link href='")
                        .append(request.getContextPath())
                        .append("/assets/css/vendor/dataTables.bootstrap4.css' rel='stylesheet'>")
                        .append("<script src='")
                        .append(request.getContextPath())
                        .append("/assets/css/vendor/jquery.dataTables.js'></script>")
                        .append("<script src='")
                        .append(request.getContextPath())
                        .append("/assets/css/vendor/dataTables.bootstrap4.js'></script>")
                        .append("<table id='detailsTable' class='table table-bordered'><thead><tr><th>Hoạt động</th><th>Chi tiết</th><th>Thời gian</th></tr></thead><tbody>");
                for (ActivityLog log : activityLogs) {
                    html.append("<tr>")
                            .append("<td>").append(log.getAction()).append("</td>")
                            .append("<td>").append(log.getDetails()).append("</td>")
                            .append("<td>").append(log.getTimestamp()).append("</td>")
                            .append("</tr>");
                }
                html.append("</tbody></table>")
                        .append("<script>")
                        .append("$(document).ready(function() { $('#detailsTable').DataTable(); });")
                        .append("</script>");
                response.getWriter().write(html.toString());// Gửi phản hồi HTML về phía client
            } else {
                // xem tất cả
                List<ActivityLog> activityLogs = activityLogDAO.getAllActivityLogs();
                request.setAttribute("activityLogs", activityLogs);
                request.getRequestDispatcher("/view/admin/dashboardActivitylog.jsp").forward(request, response);
            }   
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        }
    }
}
