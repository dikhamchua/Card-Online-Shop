package utils;

import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.mail.MessagingException;

public class EmailAlertThread extends Thread {

    private String to;
    private String subject;
    private String messageBody;

    public EmailAlertThread(String to, String subject, String messageBody) {
        this.to = to;
        this.subject = subject;
        this.messageBody = messageBody;
    }

    @Override
    public void run() {
        try {
            // Gọi phương thức sendMail từ EmailUtil để gửi email
            EmailUtil.sendMail(to, subject, messageBody);
        } catch (MessagingException e) {
            // Ghi log nếu có lỗi xảy ra khi gửi email
            Logger.getLogger(EmailAlertThread.class.getName()).log(Level.SEVERE, null, e);
        }
    }
}
