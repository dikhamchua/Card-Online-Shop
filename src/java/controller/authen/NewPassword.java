package controller.authen;

import dal.implement.UsersDAO;
import utils.*;
import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/newpassword")
public class NewPassword extends HttpServlet {
    UsersDAO userDAO = new UsersDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String newpassword = request.getParameter("password");
        String confPassword = request.getParameter("confPassword");
        String email = (String) request.getSession().getAttribute("email");

        // Check for empty fields
        if (newpassword.trim().isEmpty() || confPassword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Mật khẩu không được để trống !");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/authen/newpassword.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Check if passwords match
        if (!newpassword.equals(confPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu bạn nhập không trùng khớp !");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/authen/newpassword.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            // Encrypt the new password
            newpassword = DesEncDec.encrypt(newpassword);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Encryption failed");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/authen/newpassword.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        // Attempt to update the password
        boolean updateSuccess = userDAO.updatePassword(email, newpassword);

        if (updateSuccess) {
            // Password updated successfully
            request.setAttribute("successMessage", "Đổi mật khẩu thành công !");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/authen/newpassword.jsp");
            dispatcher.forward(request, response);
        } else {
            // Password update failed
            request.setAttribute("errorMessage", "Failed to change password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/authen/newpassword.jsp");
            dispatcher.forward(request, response);
        }
    }
}
