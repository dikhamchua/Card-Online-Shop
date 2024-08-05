package utils;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class ValidateOtp
 */
@WebServlet("/ValidateOtp")
public class ValidateOtp extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String value = request.getParameter("otp");
        HttpSession session = request.getSession();
        String otp = String.valueOf(session.getAttribute("otp")); // Đảm bảo otp được lấy ra dưới dạng String
        Integer attempts = (Integer) session.getAttribute("otpAttempts");
        if (attempts == null) {
            attempts = 0;
        }

        RequestDispatcher dispatcher = null;

        if (value == null || value.isEmpty()) {
            request.setAttribute("message", "Mã OTP không được để trống.");
            dispatcher = request.getRequestDispatcher("view/authen/enterOTP.jsp");
        } else if (value.equals(otp)) {
            request.setAttribute("email", session.getAttribute("email"));
            request.setAttribute("status", "success");
            session.setAttribute("otpAttempts", 0); // Reset attempts on success
            dispatcher = request.getRequestDispatcher("view/authen/newpassword.jsp");
        } else {
            attempts++;
            session.setAttribute("otpAttempts", attempts);
            request.setAttribute("message", "Mã của bạn không chính xác. Hãy kiểm tra lại!");
            dispatcher = request.getRequestDispatcher("view/authen/enterOTP.jsp");
        }

        dispatcher.forward(request, response);
    }
}
