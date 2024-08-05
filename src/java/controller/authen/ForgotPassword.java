package controller.authen;

import dal.implement.UsersDAO;
import entity.Users;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.Random;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ForgotPassword")
public class ForgotPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        RequestDispatcher dispatcher = null;
        HttpSession mySession = request.getSession();
        UsersDAO usersDAO = new UsersDAO();
        Users user = new Users();
        user.setEmail(email);

        // Kiểm tra email có tồn tại trong DB không
        if (email != null && !email.equals("") && usersDAO.checkEmailExist(user)) {
            String otpvalue = generateOTP(6); // Sử dụng phương thức generateOTP để tạo OTP
            String to = email;
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
            props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getDefaultInstance(props, new jakarta.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("isp1804cardweb3@gmail.com", "pchn xlef opnr bhca");
                }
            });

            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress("isp1804cardweb3@gmail.com"));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject("Mã OTP yêu cầu đặt lại mật khẩu mới", StandardCharsets.UTF_8.name()); // Sử dụng UTF-8 cho tiêu đề
                message.setText("Mã OTP để đặt lại mật khẩu mới của bạn là: " + otpvalue, StandardCharsets.UTF_8.name()); // Sử dụng UTF-8 cho nội dung
                Transport.send(message);
                System.out.println("message sent successfully");
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }
            dispatcher = request.getRequestDispatcher("view/authen/enterOTP.jsp");
            request.setAttribute("message", "OTP đã được gửi, hãy kiểm tra gmail của bạn!");
            mySession.setAttribute("otp", otpvalue); // Lưu OTP dưới dạng String
            mySession.setAttribute("email", email);
        } else {
            dispatcher = request.getRequestDispatcher("view/authen/forgotpassword.jsp");
            request.setAttribute("errorMessage", "Email không tồn tại trong hệ thống!");
        }
        dispatcher.forward(request, response);
    }

    private String generateOTP(int length) {
        Random rand = new Random();
        StringBuilder otp = new StringBuilder(length);

        while (otp.length() < length) {
            otp.append(rand.nextInt(10));
        }

        return otp.toString();
    }
}
