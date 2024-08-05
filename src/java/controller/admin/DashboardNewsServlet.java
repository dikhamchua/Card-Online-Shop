/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.implement.NewsDAO;
import entity.News;
import entity.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDate;
import java.util.List;
import java.sql.Date;

/**
 *
 * @author Tom
 */
@MultipartConfig
public class DashboardNewsServlet extends HttpServlet {

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

        String action = request.getParameter("action") == null
                ? "default"
                : request.getParameter("action");
        switch (action) {
            case "edit":
                editNewsDoGet(request, response);
                break;
            case "add":
                addNewsDoGet(request, response);
                break;
            default:
                //back to dashboard news
                dashboardNewsDoGet(request, response);
        }
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
        String action = request.getParameter("action") != null
                ? request.getParameter("action")
                : "";
        //dua theo action set URL trang can chuyen den
        String url;
        switch (action) {
            case "addNews":
                addNews(request, response);
                break;
            case "editNews":
                editNews(request, response);
                break;
            case "hideNews":
                hideNews(request, response);
                break;
            case "deleteNews":
                deleteNews(request, response);
                break;
            default:
                url = "view/homepage/news.jsp";
        }

        response.sendRedirect(request.getContextPath() + "/admin/news");
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

    private void addNews(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession();
            Users user = (Users) session.getAttribute("users");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            Part part = request.getPart("image");
            String imagePath = null;
            if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                // Đường dẫn lưu ảnh
                String path = request.getServletContext().getRealPath("/assets/img/logo/");
                File dir = new File(path);
                // Xem tồn tại chưa
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                File image = new File(dir, part.getSubmittedFileName());
                // Ghi file vào trong đường dẫn
                part.write(image.getAbsolutePath());
                // Lấy ra context path của project
                imagePath = request.getContextPath() + "/assets/img/logo/" + image.getName();
                News news = News.builder()
                        .UserID(user.getID())
                        .Title(title)
                        .Content(content)
                        .Image(imagePath)
                        .CreatedAt(Date.valueOf(LocalDate.now()))
                        .Status(true)
                        .build();
                newsDAO.insert(news);
                request.setAttribute("successMessage", "Đã thêm bài viết thành công.");
            }
        } catch (NumberFormatException | IOException | ServletException ex) {
            ex.printStackTrace();
        }
    }

    private void editNews(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            Part part = request.getPart("image");
            String imagePath = null;
            if (part.getSubmittedFileName() == null
                    || part.getSubmittedFileName().trim().isEmpty()
                    || part == null) {
                imagePath = request.getParameter("currentImage");
            } else {
                // duong dan luu anh
                String path = request.getServletContext().getRealPath("/assets/img/logo/");
                File dir = new File(path);
// xem duongd an nay ton tai chua
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                File image = new File(dir, part.getSubmittedFileName());
                // ghi file vao trong duong dan
                part.write(image.getAbsolutePath());
                // lay ra cai context path cua project
                imagePath = request.getContextPath() + "/assets/img/logo/" + image.getName();
            }

            News news = News.builder()
                    .ID(id)
                    .Title(title)
                    .Content(content)
                    .Image(imagePath)
                    .UpdatedAt(Date.valueOf(LocalDate.now()))
                    .build();
            newsDAO.update(news);
        } catch (NumberFormatException | IOException | ServletException ex) {
            ex.printStackTrace();
        }
    }

    private void hideNews(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        String newsId = request.getParameter("newsId");

        if (newsId != null) {
            boolean status = "1".equals(request.getParameter("status"));
            News news = new News();
            news.setID(Integer.parseInt(newsId));
            news.setStatus(status);

            try {
                boolean updateSuccess = new NewsDAO().updateStatus(news);
                if (updateSuccess) {
                    response.setContentType("text/plain");
                    response.getWriter().write("Ẩn bài viết thành công");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error updating news status");
                }
            } catch (IOException e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request");
        }
    }

    private void deleteNews(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        newsDAO.deleteById(id);
    }

    private void dashboardNewsDoGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String statusParam = request.getParameter("status");
        List<News> listNews;

        if (statusParam != null) {
            boolean status = "1".equals(statusParam);
            listNews = newsDAO.findByStatus(status);
        } else if (keyword != null && !keyword.trim().isEmpty()) {
            listNews = newsDAO.searchByTitle(keyword);
        } else {
            listNews = newsDAO.findAllDesc();
        }

        // Đếm số lượng bài đăng theo trạng thái
        int activeCount = newsDAO.countByStatus(true);
        int inactiveCount = newsDAO.countByStatus(false);

        request.setAttribute("activeCount", activeCount);
        request.setAttribute("inactiveCount", inactiveCount);
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
        request.getRequestDispatcher("../view/admin/dashboardNews.jsp").forward(request, response);
    }

    private void editNewsDoGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        //TODO: GET DATA FROM FRONTEND ID OF NEWS => GET 
        String id = request.getParameter("id");

        News news = new NewsDAO().findById(id);

        //set vao request
        request.setAttribute("news", news);
        //chuyen trang
        request.getRequestDispatcher("../view/admin/editNews.jsp").forward(request, response);
    }

    private void addNewsDoGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("../view/admin/addNews.jsp").forward(request, response);
    }

}
