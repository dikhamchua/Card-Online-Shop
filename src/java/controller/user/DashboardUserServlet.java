package controller.user;

import dal.implement.ActivityLogDAO;
import dal.implement.UsersDAO;
import entity.ActivityLog;
import entity.Users;
import jakarta.mail.internet.MimeUtility;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import utils.DesEncDec;
import utils.EmailAlertThread;

/**
 *
 * @author Tom
 */
@MultipartConfig(maxFileSize = 10 * 1024 * 1024)
public class DashboardUserServlet extends HttpServlet {

    UsersDAO userDAO = new UsersDAO();
    ActivityLogDAO activityLogDAO = new ActivityLogDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set no-cache headers
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("users") == null) {
            response.sendRedirect(request.getContextPath() + "/view/authen/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = ""; // Gán giá trị mặc định cho action
        }

        switch (action) {
            case "profile":
                Users account = (Users) session.getAttribute("users");
                String profileImage = account.getProfilePicture();
                request.setAttribute("profileImage", profileImage);
                request.getRequestDispatcher("view/user/dashboardUser.jsp").forward(request, response);
                break;
            case "change-password-user":
                request.getRequestDispatcher("view/user/change-password.jsp").forward(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0); // Proxies.

        HttpSession session = request.getSession(false); // Sử dụng getSession(false) để không tạo session mới
        if (session == null || session.getAttribute("users") == null) {
            response.sendRedirect(request.getContextPath() + "/view/authen/login.jsp"); // Điều hướng về trang đăng nhập
            return;
        }
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        String url = null;
        switch (action) {
            case "change-password-user":
                url = changePassword(request, response);
                break;
            case "change-image-profile":
                updateProfilePicture(request, session);
                url = "view/user/dashboardUser.jsp"; // Thêm URL này để điều hướng sau khi cập nhật ảnh đại diện
                break;
            default:
                throw new AssertionError();
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url;
        String password = request.getParameter("password");
        String newPassword = request.getParameter("newPassword");
        String newPassword2 = request.getParameter("newPassword2");
        HttpSession session = request.getSession();
        Users accountSession = (Users) session.getAttribute("users");

        // Check if any field is empty
        if (password == null || password.isEmpty() || newPassword == null || newPassword.isEmpty() || newPassword2 == null || newPassword2.isEmpty()) {
            request.setAttribute("error", "Tất cả các trường đều không được để trống.");
            url = "/view/user/change-password.jsp";
            return url;
        }

        // Check if new passwords match
        if (!newPassword.equals(newPassword2)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            url = "/view/user/change-password.jsp";
            return url;
        }

        try {
            if (!accountSession.getPasswordHash().equals(DesEncDec.encrypt(password))) {
                request.setAttribute("error", "Mật khẩu cũ không đúng.");
                url = "/view/user/change-password.jsp";
                return url;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi kiểm tra mật khẩu cũ.");
            url = "/view/user/change-password.jsp";
            return url;
        }

        try {
            // Encrypt the new password
            newPassword = DesEncDec.encrypt(newPassword);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Mã hóa thất bại.");
            url = "/view/user/change-password.jsp";
            return url;
        }

        userDAO.updatePassword(accountSession.getEmail(), newPassword);
        accountSession.setPasswordHash(newPassword);
        session.setAttribute("users", accountSession);

        // Ghi lại log hoạt động đổi mật khẩu
        ActivityLog activityLog = new ActivityLog();
        activityLog.setUserId(accountSession.getID());
        activityLog.setAction("Change Password");
        activityLog.setDetails("Đổi mật khẩu thành công");
        activityLogDAO.insertActivity(activityLog);

        // Gửi email cảnh báo
        sendPasswordChangeAlert(accountSession.getEmail());

        request.setAttribute("successMessage", "Đổi mật khẩu thành công.");
        url = "/view/user/change-password.jsp";
        return url;
    }

    private void updateProfilePicture(HttpServletRequest request, HttpSession session) throws ServletException, IOException {
        Users account = (Users) session.getAttribute("users");
        String imagePath = null;
        // Get image
        try {
            Part part = request.getPart("profilePicture");
            if (part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().isEmpty()) {
                // Use current image
                imagePath = request.getParameter("currentImage");
            } else {
                try {
                    String path = request.getServletContext().getRealPath("/assets/img/avt");
                    File dir = new File(path);
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }

                    File image = new File(dir, part.getSubmittedFileName());
                    if (!image.exists()) {
                        part.write(image.getAbsolutePath());
                    }
                    imagePath = request.getContextPath() + "/assets/img/avt/" + image.getName();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        // Update profile picture in session and database
        account.setProfilePicture(imagePath);
        userDAO.updateProfilePicture(account.getEmail(), imagePath);
        session.setAttribute("users", account); // Update session with new account information
    }

    private void updateProfileDoPost(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        Users users = Users.builder()
                .UserName(username)
                .PasswordHash(password)
                .Email(email)
                .build();
        userDAO.updateProfile(users);
        //update lai account vao session
        HttpSession session = request.getSession();
        Users UserNew = (Users) session.getAttribute(Constant.SESSION_USER);
        UserNew.setEmail(email);
        session.setAttribute(Constant.SESSION_USER, UserNew);

    }

    private void sendPasswordChangeAlert(String email) {
        String subject = "Thông báo thay đổi mật khẩu";
        String message = "Mật khẩu của bạn đã được thay đổi vào lúc " + new Date() + ". Nếu không phải bạn, vui lòng kiểm tra tài khoản của bạn.";
        try {
            subject = MimeUtility.encodeText(subject, StandardCharsets.UTF_8.toString(), "B");
        } catch (Exception e) {
            e.printStackTrace();
        }
        EmailAlertThread emailAlertThread = new EmailAlertThread(email, subject, message);
        emailAlertThread.start();
    }
}
