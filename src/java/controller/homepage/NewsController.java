/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.homepage;

import dal.implement.NewsDAO;
import entity.News;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Tom
 */
public class NewsController extends HttpServlet {

    NewsDAO newsDAO = new NewsDAO();

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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String searchQuery = request.getParameter("searchQuery");
        String action = request.getParameter("action");
        List<News> listNews;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            listNews = newsDAO.searchByTitle(searchQuery);
        } else {
            listNews = newsDAO.findAllDescButHide();
        }

        request.setAttribute("listNews", listNews);

        if (listNews.isEmpty()) {
            request.setAttribute("noResultMessage", "Không tồn tại bài viết");
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

        int totalRecord = listNews.size();
        int totalPage = (totalRecord % controller.homepage.Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord / controller.homepage.Constant.RECORD_PER_PAGE)
                : (totalRecord / controller.homepage.Constant.RECORD_PER_PAGE) + 1;
        int start = (page - 1) * controller.homepage.Constant.RECORD_PER_PAGE;
        int end = Math.min(start + controller.homepage.Constant.RECORD_PER_PAGE, totalRecord);
        List<News> paginatedList = listNews.subList(start, end);
        request.setAttribute("listNews", paginatedList);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);

        request.getRequestDispatcher("view/homepage/news.jsp").forward(request, response);
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

}
