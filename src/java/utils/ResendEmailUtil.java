package utils;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/resendEmail")
public class ResendEmailUtil extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email"); // Retrieve email from session
        int otpvalue = 0;

        if (email != null && !email.equals("")) {
            // Sending OTP
            Random rand = new Random();
            int[] otpArray = new int[6]; // Tạo một mảng 6 số nguyên

            // Tạo mỗi chữ số ngẫu nhiên và gán vào mảng
            for (int i = 0; i < 6; i++) {
                otpArray[i] = rand.nextInt(10); // Tạo một chữ số ngẫu nhiên từ 0 đến 9
            }

            // Chuyển đổi mảng thành chuỗi
            StringBuilder otpValue = new StringBuilder(6);
            for (int digit : otpArray) {
                otpValue.append(digit);
            }
            otpvalue = Integer.parseInt(otpValue.toString());

            String to = email;

            // Get the session object
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
            props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session mailSession = Session.getDefaultInstance(props, new jakarta.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("isp1804cardweb3@gmail.com", "pchn xlef opnr bhca");
                }
            });

            // Compose message
            try {
                MimeMessage message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress("isp1804cardweb3@gmail.com"));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject("Mã OTP ");
                message.setText("Mã OTP: " + otpvalue);
                Transport.send(message);
                System.out.println("Message sent successfully");
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }

            // Update session with new OTP
            session.setAttribute("otp", otpvalue);
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("Mã OTP đã được gửi đến email của bạn.");
        } else {
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("Lỗi: Không tìm thấy email trong phiên.");
        }
    }
}
