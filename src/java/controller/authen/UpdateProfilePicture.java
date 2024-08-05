/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.authen;

import dal.implement.UsersDAO;
import entity.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;

/**
 *
 * @author Admin
 */
@MultipartConfig(maxFileSize = 10 * 1024 * 1024)
public class UpdateProfilePicture extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("view/authen/profile.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users account = (Users) session.getAttribute("users");
         // Get email of current user (you might get it from session or cookies)
        String imagePath = null;
        //get image
        try {

            Part part = request.getPart("profilePicture");
            if (part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().isEmpty()) {
                // Sử dụng ảnh hiện tại và cập nhật đường dẫn (imagePath)
                imagePath = request.getParameter("currentImage");
            } else {
                try {
                    String path = request.getServletContext().getRealPath("/assets/img/avt");
                    File dir = new File(path);
                    //ko có đường dẫn => tự tạo ra
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }

                    File image = new File(dir, part.getSubmittedFileName());
                    if (!image.exists()) {
                        part.write(image.getAbsolutePath());
                    }
                    imagePath = request.getContextPath() + "/images/" + image.getName();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        account.setProfilePicture(imagePath);
        new UsersDAO().updateProfilePicture(account.getEmail(), imagePath);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
