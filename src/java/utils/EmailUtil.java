package utils;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Random;

public class EmailUtil {

    public static final String USERNAME = "isp1804cardweb3@gmail.com";
    public static final String PASSWORD = "pchn xlef opnr bhca";

    public static boolean sendMail(String to, String subject, String content) throws AddressException, MessagingException {
        Properties props = new Properties();
         // Thiết lập các thuộc tính cho phiên gửi mail
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(USERNAME));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setContent(content, "text/html; charset=UTF-8");

        Transport.send(message);
        return true;
    }

    public static int sendOTPMail(String to) {
        int otp = generateOTP(6); // Sử dụng phương thức generateOTP để tạo OTP
        String subject = "Mã OTP";
        String content = "Mã OTP của bạn để kích hoạt tài khoản là: " + otp;

        try {
            sendMail(to, subject, content);
        } catch (MessagingException ex) {
            Logger.getLogger(EmailUtil.class.getName()).log(Level.SEVERE, null, ex);
        }

        return otp;
    }

    private static int generateOTP(int length) {
        Random rand = new Random();
        StringBuilder otp = new StringBuilder();

        for (int i = 0; i < length; i++) {
            otp.append(rand.nextInt(10));
        }

        return Integer.parseInt(otp.toString());
    }
}
