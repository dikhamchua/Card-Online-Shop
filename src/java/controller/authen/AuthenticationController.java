/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authen;

import dal.implement.ActivityLogDAO;
import dal.implement.CartDAO;
import dal.implement.UsersDAO;
import dal.implement.WalletDAO;
import entity.ActivityLog;
import entity.Cart;
import entity.Users;
import entity.Wallet;
import jakarta.mail.internet.MimeUtility;
import utils.CaptchaUtils;
import utils.DesEncDec;
import utils.EmailSenderThread;
import utils.EmailAlertThread;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.NoSuchPaddingException;

/**
 *
 * @author Tom
 */
public class AuthenticationController extends HttpServlet {

    UsersDAO userDAO = new UsersDAO();
    CartDAO cartDAO = new CartDAO();
    ActivityLogDAO activityLogDAO = new ActivityLogDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get ve action
        String action = request.getParameter("action") != null
                ? request.getParameter("action")
                : "";
        //dua theo action set URL trang can chuyen den
        String url;
        switch (action) {
            case "login":
                createCaptcha(request, response);
                url = "view/authen/login.jsp";
//                url = fakeLogin(request, response);
                break;
            case "log-out":
                url = logOut(request, response);
                break;
            case "register":
                url = "view/authen/register.jsp";
                break;
            case "forgotpassword":
                url = "view/authen/forgotpassword.jsp";
                break;
            default:
                createCaptcha(request, response);
                url = "view/authen/login.jsp";
//                url = fakeLogin(request, response);
        }
        //chuyen trang
        request.getRequestDispatcher(url).forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get ve action
        String action = request.getParameter("action") != null
                ? request.getParameter("action")
                : "";
//dựa theo action để xử lí request
        String url = null;
        switch (action) {
            case "login": {
                try {
                    url = loginDoPost(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(AuthenticationController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            case "register":
                url = signUp(request, response);
                break;
            case "forgotpassword":
                url = forgotpassword(request, response);
                break;
            default:
                url = "view/homepage/home.jsp";
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String loginDoPost(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        String url = null;
        WalletDAO walletDAO = new WalletDAO();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String captcha = request.getParameter("captcha");

        try {
            password = DesEncDec.encrypt(password);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Encryption error!!");
            url = "view/authen/login.jsp";
            return url;
        }

        Users users = Users.builder()
                .UserName(username)
                .PasswordHash(password)
                .build();
        Users accFoundByUsernamePass = userDAO.findByUsernameAndPass(users);
        HttpSession session = request.getSession();
        String sessionCaptcha = (String) session.getAttribute("captcha");

        if (captcha == null || captcha.isEmpty()) {
            request.setAttribute("error", "Captcha is required!!");
            url = "view/authen/login.jsp";
            createCaptcha(request, response);
            request.setAttribute("username", username);
            request.setAttribute("password", request.getParameter("password"));
            return url;
        }

        if (!captcha.equals(sessionCaptcha)) {
            request.setAttribute("error", "Captcha is incorrect!!");
            url = "view/authen/login.jsp";
            createCaptcha(request, response);
            request.setAttribute("username", username);
            request.setAttribute("password", request.getParameter("password"));
            return url;
        }

        if (accFoundByUsernamePass != null) {
            if (accFoundByUsernamePass.isStatus()) {
                Wallet wallet = walletDAO.getWalletByUserID(accFoundByUsernamePass.getID());
                if (wallet == null) {
                    try {
                        walletDAO.insertWalletForNewUser(accFoundByUsernamePass.getID());
                        wallet = walletDAO.getWalletByUserID(accFoundByUsernamePass.getID());
                    } catch (SQLException e) {
                        e.printStackTrace();
                        request.setAttribute("error", "Error creating wallet!!");
                        url = "view/authen/login.jsp";
                        return url;
                    }
                }
                session.setAttribute("wallet", wallet);
                session.setAttribute("users", accFoundByUsernamePass);
                session.setAttribute("user_id", accFoundByUsernamePass.getID());
                Cart cartFoundByUserId = cartDAO.findCartFoundByUserId(accFoundByUsernamePass.getID());
                session.setAttribute("cart", cartFoundByUserId);
                // ly activitylog dang nhap cua nguoi dung
                ActivityLog activityLog = new ActivityLog();
                activityLog.setUserId(accFoundByUsernamePass.getID());
                activityLog.setAction("Login");
                activityLog.setDetails("Đăng nhập thành công");
                activityLogDAO.insertActivity(activityLog);
//                //kiem tra hanh dong dang ngo 
//                boolean isSuspicious = checkSuspiciousActivity(accFoundByUsernamePass.getID());
//                if (isSuspicious) {
//                    sendSuspiciousActivityEmail(accFoundByUsernamePass.getEmail(), "Đăng nhập thành công");
//                }

                url = "view/homepage/home.jsp";
            } else {
                request.setAttribute("error", "Tài khoản đã bị khóa");
                createCaptcha(request, response);
                request.setAttribute("username", username);
                request.setAttribute("password", request.getParameter("password"));
                url = "view/authen/login.jsp";
            }
        } else {
            // Đăng nhập thất bại, ghi log
            ActivityLog activityLog = new ActivityLog();
            Integer userId = userDAO.findUserIdByUsername(username);
            if (userId != null) {
                activityLog.setUserId(userId);
                activityLog.setAction("Login Failed");
                activityLog.setDetails("Đăng nhập thất bại");
                activityLogDAO.insertActivity(activityLog);

                boolean isSuspicious = checkSuspiciousActivity(userId);
                if (isSuspicious) {
                    sendSuspiciousActivityEmail(userDAO.findEmailByUserId(userId), "Đăng nhập thất bại");
                }
            }

            request.setAttribute("error", "Username or password incorrect!!");
            request.setAttribute("username", username);
            createCaptcha(request, response);
            url = "view/authen/login.jsp";
        }
        return url;
    }

    private String logOut(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        // Lấy thông tin người dùng trước khi xóa khỏi session
        Users user = (Users) session.getAttribute("users");

        // Xóa thuộc tính khỏi session
        session.removeAttribute("users");
        session.removeAttribute("cart");

        // Ghi lại hoạt động đăng xuất
        if (user != null) {
            ActivityLogDAO activityLogDAO = new ActivityLogDAO();
            ActivityLog activityLog = new ActivityLog();
            activityLog.setUserId(user.getID());
            activityLog.setAction("Logout");
            activityLog.setDetails("Đăng Xuất");
            activityLogDAO.insertActivity(activityLog);
        }
        return "home";
    }

    private String signUp(HttpServletRequest request, HttpServletResponse response) {
        String url;
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        // Encrypt password
        try {
            password = DesEncDec.encrypt(password);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi mã hóa!!");
            url = "view/authen/register.jsp";
            return url;
        }
        // Check if username and email already exist in the database
        Users users = Users.builder()
                .UserName(username)
                .PasswordHash(password)
                .Email(email)
                .Status(true)
                .build();
        boolean isExistUsername = userDAO.checkUsernameExist(users);
        boolean isExistEmail = userDAO.checkEmailExist(users);
        if (isExistUsername) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!!");
            request.setAttribute("password", request.getParameter("password"));
            request.setAttribute("email", email);
            url = "view/authen/register.jsp";
        } else if (isExistEmail) {
            request.setAttribute("error", "Email đã tồn tại!!");
            request.setAttribute("username", username);
            request.setAttribute("password", request.getParameter("password"));
            url = "view/authen/register.jsp";
        } else {
            // Save user to session for later activation
            HttpSession session = request.getSession();
            session.setAttribute("user", users);
            session.setAttribute("email", email); // Add email to session
            session.setMaxInactiveInterval(300);

            // Gửi OTP
            EmailSenderThread emailSenderThread = new EmailSenderThread(email, session);
            emailSenderThread.start();

            url = "view/authen/registerOTP.jsp";
        }
        return url;
    }

    private void refreshCaptcha(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String base64Image = (String) session.getAttribute("captchaImage");
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        System.out.println(base64Image);
        out.print("" + base64Image);
//        out.flush();
    }

    private String forgotpassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        Users users = Users.builder()
                .Email(email)
                .build();
        boolean isExistEmail = userDAO.checkEmailExist(users);

        if (isExistEmail) {
            if (email == null || email.trim().isEmpty()) {
                // Email is null or empty
                request.setAttribute("errorMessage", "Email cannot be null or empty.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("forgotpassword.jsp");
                dispatcher.forward(request, response);
                return null;
            }
        }

        // Sending OTP
        Random rand = new Random();
        int otpvalue = rand.nextInt(111111);

        String to = email;
        // Code to send email...

        // Forward to EnterOtp.jsp page
        RequestDispatcher dispatcher = request.getRequestDispatcher("enterOTP.jsp");
        request.setAttribute("message", "Please check your email!");
        request.setAttribute("otp", otpvalue);
        request.setAttribute("email", email);
        dispatcher.forward(request, response);

        return null;
    }

    private void createCaptcha(HttpServletRequest request, HttpServletResponse response) {
        String captchaGenerate = CaptchaUtils.generateCaptcha();
        String base64Capcha = CaptchaUtils.createCaptchaBase64Image(captchaGenerate);
        HttpSession session = request.getSession();
        session.setAttribute("captcha", captchaGenerate);
        session.setAttribute("captchaImage", base64Capcha);
    }

    private String fakeLogin(HttpServletRequest request, HttpServletResponse response) {
        String url = null;
// Get user login information
        String username = "admin";
        String password = "123";
        String captcha = request.getParameter("captcha");

        // Encrypt the password
        try {
            password = DesEncDec.encrypt(password);
        } catch (UnsupportedEncodingException | InvalidKeyException | NoSuchAlgorithmException | InvalidKeySpecException | NoSuchPaddingException e) {
            e.printStackTrace();
            request.setAttribute("error", "Encryption error!!");
            url = "view/authen/login.jsp";
            return url;
        }

        // Check if the user information exists in the database
        Users users = Users.builder()
                .UserName(username)
                .PasswordHash(password)
                .build();
        Users accFoundByUsernamePass = userDAO.findByUsernameAndPass(users);
        HttpSession session = request.getSession();
        // If user is found, redirect to home page and set the account in the session
        if (accFoundByUsernamePass != null) {
            //TODO: check status
            if (accFoundByUsernamePass.isStatus()) {
                session.setAttribute("users", accFoundByUsernamePass);
                createCaptcha(request, response);
                url = "view/homepage/home.jsp";
            } else {
                request.setAttribute("error", "Tài khoản đã bị khóa");
                createCaptcha(request, response);
                url = "view/authen/login.jsp";
            }

        } else {
            // If user is not found, go back to login page with an error message
            request.setAttribute("error", "Username or password incorrect!!");
            request.setAttribute("username", username);
            createCaptcha(request, response);
            url = "view/authen/login.jsp";
        }
        return url;
    }

    private boolean checkSuspiciousActivity(int userId) {
        int recentFailedLoginThreshold = 3;
        List<ActivityLog> recentActivities = activityLogDAO.getRecentActivities(userId, 10);

        int failedLoginCount = 0;
        for (ActivityLog activity : recentActivities) {
            if (activity.getAction().equals("Login Failed")) {
                failedLoginCount++;
            }
        }

        return failedLoginCount >= recentFailedLoginThreshold;
    }

    private void sendSuspiciousActivityEmail(String email, String activity) {
        String subject = "Cảnh báo hoạt động đáng ngờ";
        String message = "Chúng tôi phát hiện hoạt động " + activity + " đáng ngờ vào lúc " + new Date() + ". Nếu không phải bạn, vui lòng kiểm tra tài khoản của bạn.";

        try {
            subject = MimeUtility.encodeText(subject, StandardCharsets.UTF_8.toString(), "B");
        } catch (Exception e) {
            e.printStackTrace();
        }

        EmailAlertThread emailAlertThread = new EmailAlertThread(email, subject, message);
        emailAlertThread.start();
    }
}
