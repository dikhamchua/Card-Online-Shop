package controller.authen;

import com.google.gson.Gson;
import dal.implement.UsersDAO;
import entity.Users;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

public class EditProfileController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check user is authenticated
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("users");
        String currentUsername = currentUser != null ? currentUser.getUserName() : null;
        String currentEmail = currentUser != null ? currentUser.getEmail() : null;

        if (currentUsername == null || currentEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve the new gender and date of birth from the form
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");

        // Convert dobStr to Date object if not null and not empty
        Date dob = null;
        if (dobStr != null && !dobStr.isEmpty()) {
            try {
                dob = Date.valueOf(dobStr);
                if (dob.after(new java.util.Date())) {
                    sendErrorMessage(response, "Bạn chưa được sinh ra");
                    return;
                }
            } catch (IllegalArgumentException e) {
                sendErrorMessage(response, "Lỗi format ngày");
                return;
            }
        }

        if (!isValidGender(gender)) {
            // Set error message and redirect back to the profile page
            request.setAttribute("errorMessage", "Please đừng F12");
            request.getRequestDispatcher("view/user/dashboardUser.jsp").forward(request, response);
            return; // Skip database update
        }

        // Update the database with new gender and/or date of birth
        UsersDAO userDAO = new UsersDAO();
        try {
            boolean isUpdated = userDAO.updateUserProfile(currentUsername, gender, dob);
            if (isUpdated) {
                // Update session with new user information
                Users updatedUser = userDAO.getUserByEmail(currentEmail);
                session.setAttribute("users", updatedUser);

                // Send success response
                Map<String, String> responseData = new HashMap<>();
                responseData.put("errorMessage", "Cập nhật thông tin thành công");
                sendResponse(response, responseData);
                session.setAttribute("gender", gender);
                session.setAttribute("dob", dob);
            } else {
                // Update failed, handle the error gracefully
                sendErrorMessage(response, "Cập nhật thông tin thất bại");
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi truy cập database", e);
        }
    }

    private void sendErrorMessage(HttpServletResponse response, String errorMessage) throws IOException {
        Map<String, String> responseData = new HashMap<>();
        responseData.put("errorMessage", errorMessage);
        sendResponse(response, responseData);
    }

    private void sendResponse(HttpServletResponse response, Map<String, String> responseData) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(responseData));
    }

    private boolean isValidGender(String gender) {
        return "Nam".equals(gender) || "Nữ".equals(gender) || "Không nói".equals(gender);
    }
}
