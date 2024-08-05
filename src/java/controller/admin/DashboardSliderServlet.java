/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.implement.SliderDAO;
import entity.Slider;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author Tom
 */
@MultipartConfig
public class DashboardSliderServlet extends HttpServlet {

    SliderDAO sliderDAO = new SliderDAO();

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
                editSliderDoGet(request, response);
                break;
            case "add":
                addSliderDoGet(request, response);
                break;
            default:
                //back to dashboard slider
                dashboardSliderDoGet(request, response);
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
            case "addSlider":
                addSlider(request, response);
                break;
            case "editSlider":
                editSlider(request, response);
                break;
            case "hideSlider":
                hideSlider(request, response);
                break;
            case "deleteSlider":
                deleteSlider(request, response);
                break;
            default:
                url = "view/homepage/home.jsp";
        }

        response.sendRedirect(request.getContextPath() + "/admin/slider");
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

    private void addSlider(HttpServletRequest request, HttpServletResponse response) {
        try {
            Part part = request.getPart("image");
            String imagePath = null;
            if (part.getSubmittedFileName() == null
                    || part.getSubmittedFileName().trim().isEmpty()
                    || part == null) {
                imagePath = null;
            } else {
                // duong dan luu anh
                String path = request.getServletContext().getRealPath("/assets/img/logo/");
                File dir = new File(path);
                // xem  ton tai chua
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                File image = new File(dir, part.getSubmittedFileName());
                // ghi file vao trong duong dan
                part.write(image.getAbsolutePath());
                // lay ra cai context path cua project
                imagePath = request.getContextPath() + "/assets/img/logo/" + image.getName();
                Slider slider = Slider.builder()
                        .Image(imagePath)
                        .CreatedAt(Date.valueOf(LocalDate.now()))
                        .Status(true)
                        .build();
                sliderDAO.insert(slider);
                request.setAttribute("successMessage", "Đã thêm ảnh thành công.");
            }
        } catch (NumberFormatException | IOException | ServletException ex) {
            ex.printStackTrace();
        }
    }

    private void editSlider(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
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

            Slider slider = Slider.builder()
                    .ID(id)
                    .Image(imagePath)
                    .UpdatedAt(Date.valueOf(LocalDate.now()))
                    .build();
            sliderDAO.update(slider);
        } catch (NumberFormatException | IOException | ServletException ex) {
            ex.printStackTrace();
        }
    }

    private void hideSlider(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        String sliderId = request.getParameter("sliderId");

        if (sliderId != null) {
            boolean status = "1".equals(request.getParameter("status"));
            Slider slider = new Slider();
            slider.setID(Integer.parseInt(sliderId));
            slider.setStatus(status);

            try {
                boolean updateSuccess = new SliderDAO().updateStatus(slider);
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

    private void deleteSlider(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        sliderDAO.deleteById(id);
    }

    private void dashboardSliderDoGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String statusParam = request.getParameter("status");
        List<Slider> listSlider;

        if (statusParam != null) {
            boolean status = "1".equals(statusParam);
            listSlider = sliderDAO.findByStatus(status);
        } else {
            listSlider = sliderDAO.findAllDesc();
        }

        // Đếm số lượng bài đăng theo trạng thái
        int activeCount = sliderDAO.countByStatus(true);
        int inactiveCount = sliderDAO.countByStatus(false);

        request.setAttribute("activeCount", activeCount);
        request.setAttribute("inactiveCount", inactiveCount);
        request.setAttribute("listSlider", listSlider);

        if (listSlider.isEmpty()) {
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

        int totalRecord = listSlider.size();
        int totalPage = (totalRecord % controller.homepage.Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord / controller.homepage.Constant.RECORD_PER_PAGE)
                : (totalRecord / controller.homepage.Constant.RECORD_PER_PAGE) + 1;
        int start = (page - 1) * controller.homepage.Constant.RECORD_PER_PAGE;
        int end = Math.min(start + controller.homepage.Constant.RECORD_PER_PAGE, totalRecord);
        List<Slider> paginatedList = listSlider.subList(start, end);
        request.setAttribute("listSlider", paginatedList);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("../view/admin/dashboardSlider.jsp").forward(request, response);
    }

    private void addSliderDoGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("../view/admin/addSlider.jsp").forward(request, response);
    }

    private void editSliderDoGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //TODO: GET DATA FROM FRONTEND ID OF NEWS => GET 
        String id = request.getParameter("id");

        Slider slider = new SliderDAO().findById(id);

        //set vao request
        request.setAttribute("slider", slider);
        //sliderchuyen trang
        request.getRequestDispatcher("../view/admin/editSlider.jsp").forward(request, response);
    }

}
