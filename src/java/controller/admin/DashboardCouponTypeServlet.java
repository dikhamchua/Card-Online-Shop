/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import controller.user.Constant;
import dal.implement.CouponTypeDAO;
import entity.CouponType;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 *
 * @author FPTSHOP
 */
public class DashboardCouponTypeServlet extends HttpServlet {

    CouponTypeDAO couponTypeDAO = new CouponTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<CouponType> listCouponType;

        // Perform search by ID or Name
        if (keyword != null && !keyword.isEmpty()) {
            listCouponType = couponTypeDAO.findByIdOrName(keyword);
        } else {
            listCouponType = couponTypeDAO.findAll();
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

        int totalRecord = listCouponType.size();
        int totalPage = (totalRecord % Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord / Constant.RECORD_PER_PAGE)
                : (totalRecord / Constant.RECORD_PER_PAGE) + 1;

        int start = (page - 1) * Constant.RECORD_PER_PAGE;
        int end = Math.min(start + Constant.RECORD_PER_PAGE, totalRecord);
        List<CouponType> paginatedList = listCouponType.subList(start, end);

        request.setAttribute("listCouponType", paginatedList);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);

        request.getRequestDispatcher("view/admin/dashboardCouponType.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        //TAO SESSION
        HttpSession session = request.getSession();

        String action = request.getParameter("action") == null
                ? ""
                : request.getParameter("action");
        switch (action) {
            case "add":
                add(request, response);
                response.sendRedirect("dashboardCouponType");
                break;
            case "delete":
                delete(request, response);
                response.sendRedirect("dashboardCouponType");
                break;
            case "edit":
                edit(request, response);
                response.sendRedirect("dashboardCouponType");
                break;
            case "active":
                active(request, response);
//                response.sendRedirect("dashboardCouponType");
                break;
            default:
                response.sendRedirect("dashboardCouponType");
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

    private void edit(HttpServletRequest request, HttpServletResponse response) {
        CouponType couponType = new CouponType();
        int ID = Integer.parseInt(request.getParameter("ID"));
        String couponTypeName = request.getParameter("CouponTypeName");
        String startDateStr = request.getParameter("StartDate");
        String endDateStr = request.getParameter("EndDate");

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        java.sql.Date startDateSql = null;
        java.sql.Date endDateSql = null;

        try {
            if (startDateStr != null && !startDateStr.isEmpty()) {
                java.util.Date startDateUtil = formatter.parse(startDateStr);
                startDateSql = new java.sql.Date(startDateUtil.getTime());
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                java.util.Date endDateUtil = formatter.parse(endDateStr);
                endDateSql = new java.sql.Date(endDateUtil.getTime());
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        couponType.setID(ID);
        couponType.setCouponTypeName(couponTypeName);
        couponType.setStartDate(startDateSql);
        couponType.setEndDate(endDateSql);

        couponTypeDAO.updateCouponType(couponType);
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        int ID = Integer.parseInt(request.getParameter("ID"));
        couponTypeDAO.deleteById(ID);
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String couponTypeName = request.getParameter("CouponTypeName");
        String startDateStr = request.getParameter("couponStartDate");
        String endDateStr = request.getParameter("couponEndDate");
        boolean status = false;

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        java.sql.Date startDateSql = null;
        java.sql.Date endDateSql = null;

        try {
            if (startDateStr != null && !startDateStr.isEmpty()) {
                java.util.Date startDateUtil = formatter.parse(startDateStr);
                startDateSql = new java.sql.Date(startDateUtil.getTime());
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                java.util.Date endDateUtil = formatter.parse(endDateStr);
                endDateSql = new java.sql.Date(endDateUtil.getTime());
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        CouponType couponType = CouponType.builder()
                .CouponTypeName(couponTypeName)
                .StartDate(startDateSql)
                .EndDate(endDateSql)
                .Status(status)
                .build();

        couponTypeDAO.insert(couponType);
    }

    private void active(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int couponTypeId = Integer.parseInt(request.getParameter("id"));
        boolean status = Boolean.parseBoolean(request.getParameter("status"));

        // Tạo một đối tượng CouponType để cập nhật trạng thái
        CouponType couponType = new CouponType();
        couponType.setID(couponTypeId);
        couponType.setStatus(status);

        try {
            boolean updateSuccess = couponTypeDAO.updateStatus(couponType);
            if (updateSuccess) {
                response.getWriter().write("Product status updated successfully");
            } else {
                response.getWriter().write("Error updating product status");
            }
        } catch (Exception e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

}
