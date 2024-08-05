/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import controller.user.Constant;
import dal.implement.UsersDAO;
import entity.PageControl;
import entity.Users;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import utils.DesEncDec;

/**
 *
 * @author Tom
 */
public class DashboardServlet extends HttpServlet {

    UsersDAO userDAO = new UsersDAO();
   // private List<Users> Users;

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        List<Users> listAccount;
        String keyword = request.getParameter("keyword");

        if ("search".equals(action)) {
            listAccount = userDAO.findByNameOrEmail(keyword);
        } else {
            listAccount = userDAO.findAll();
        }

        String pageRaw = request.getParameter("page");
        int page;
        try {
            page = Integer.parseInt(pageRaw);
            if (page <= 0) {
                page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        int totalRecord = listAccount.size();
        int totalPage = (totalRecord % Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord / Constant.RECORD_PER_PAGE)
                : (totalRecord / Constant.RECORD_PER_PAGE) + 1;

        int start = (page - 1) * Constant.RECORD_PER_PAGE;
        int end = Math.min(start + Constant.RECORD_PER_PAGE, totalRecord);

        List<Users> paginatedList = listAccount.subList(start, end);
        request.setAttribute("listAccount", paginatedList);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("action", action);

        request.getRequestDispatcher("../view/admin/dashboardAdmin.jsp").forward(request, response);
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
        List<Users> listAccount = userDAO.findAll();
        String action = request.getParameter("action") == null
                ? ""
                : request.getParameter("action");
        switch (action) {
//            case "change-password-admin":
//                changePassword(request, response);
//                break;
            case "ban":
                banUser(request, response);
                break;
            default:
                throw new AssertionError();
        }
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

    private void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newpassword = request.getParameter("password");
        List<Users> listAccount = userDAO.findAll();
        //TAO SESSION
        request.setAttribute("listAccount", listAccount);
        Users account = (Users) request.getSession().getAttribute("users");

        try {
            // Encrypt the new password
            newpassword = DesEncDec.encrypt(newpassword);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Encryption failed.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/changepassword.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Attempt to update the password
        boolean updateSuccess = userDAO.updatePassword(account.getEmail(), newpassword);

        if (updateSuccess) {
            // Đổi mật khẩu thành công
            request.setAttribute("successMessage", "Password changed successfully.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("../view/admin/dashboardAdmin.jsp");
            dispatcher.forward(request, response);
        }

    }

    private void banUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        String userId = request.getParameter("userId");

        System.out.println(action);
        System.out.println(userId);

        if (userId != null) {
            boolean status = "1".equals(request.getParameter("status"));
            Users user = new Users();
            user.setID(Integer.parseInt(userId));
            user.setStatus(status);

            try {
                boolean updateSuccess = new UsersDAO().updateStatus(user);
                if (updateSuccess) {
                    response.getWriter().write("User status updated successfully");
                } else {
                    response.getWriter().write("Error updating user status");
                }
            } catch (Exception e) {
                response.getWriter().write("Error: " + e.getMessage());
            }
        } else {
            response.getWriter().write("Invalid request");
        }

    }
}
