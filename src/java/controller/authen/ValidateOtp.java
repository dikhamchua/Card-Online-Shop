package controller.authen;

import dal.implement.UsersDAO;
import entity.Users;
import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

@WebServlet("/ValidateOtp1")
public class ValidateOtp extends HttpServlet {

    private static final long serialVersionUID = 1L;
    UsersDAO userDAO = new UsersDAO();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int value = Integer.parseInt(request.getParameter("otp"));
        HttpSession session = request.getSession();
        Integer otp = (Integer) session.getAttribute("otp");
        Timestamp otpExpireTime = (Timestamp) session.getAttribute("otpExpireTime"); // Sửa tên thuộc tính cho đúng
        RequestDispatcher dispatcher = null;

        if (otp == null || otpExpireTime == null) {
            request.setAttribute("message", "OTP không đúng hoặc đã hết hạn.");
            dispatcher = request.getRequestDispatcher("view/authen/registerOTP.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
        if (currentTime.after(otpExpireTime)) {
            request.setAttribute("message", "OTP đã hết hạn.");
            dispatcher = request.getRequestDispatcher("view/authen/registerOTP.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if (value == otp) {
            Users user = (Users) session.getAttribute("user");
            user.setStatus(true);
            userDAO.updateStatus(user);
            userDAO.insert(user);
            request.setAttribute("email", request.getParameter("email"));
            request.setAttribute("status", "success");
            request.setAttribute("message", "Tài khoản của bạn đã được kích hoạt, vui lòng đăng nhập lại");

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<script type='text/javascript'>");
            out.println("alert('Tài khoản của bạn đã được kích hoạt, vui lòng đăng nhập lại.');");
            out.println("setTimeout(function(){ window.location.href = 'authen'; }, 200);");
            out.println("</script>");
            out.println("</body></html>");
        } else {
            request.setAttribute("message", "OTP sai, vui lòng kiểm tra lại!");
            dispatcher = request.getRequestDispatcher("view/authen/registerOTP.jsp");
            dispatcher.forward(request, response);
        }
    }
}
