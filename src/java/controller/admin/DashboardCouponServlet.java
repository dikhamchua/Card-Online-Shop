/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import controller.user.Constant;
import dal.implement.CouponsDAO;
import dal.implement.CouponTypeDAO;
import entity.CouponType;
import entity.Coupons;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DashboardCouponServlet extends HttpServlet {

    private CouponsDAO couponDAO = new CouponsDAO();
    private CouponTypeDAO couponTypeDAO = new CouponTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String keyword = request.getParameter("keyword");
        String action = request.getParameter("action");
        List<Coupons> listCoupon;
        List<CouponType> listCouponType;

        if (keyword != null && !keyword.isEmpty()) {
            listCoupon = couponDAO.searchCouponsByKeyword(keyword);
        } else {
            listCoupon = couponDAO.findAll();
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

        int totalRecord = listCoupon.size();
        int totalPage = (totalRecord % Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord / Constant.RECORD_PER_PAGE)
                : (totalRecord / Constant.RECORD_PER_PAGE) + 1;

        int start = (page - 1) * Constant.RECORD_PER_PAGE;
        int end = Math.min(start + Constant.RECORD_PER_PAGE, totalRecord);

        listCouponType = couponTypeDAO.findAll();
        List<Coupons> paginatedList = listCoupon.subList(start, end);
        request.setAttribute("listCoupon", paginatedList);
        request.setAttribute("listCouponType", listCouponType);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("action", action);
        request.getRequestDispatcher("view/admin/dashboardCoupon.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        List<CouponType> listCouponType;

        String action = request.getParameter("action") == null ? "" : request.getParameter("action");

        switch (action) {
            case "add":
                addCoupon(request, response);
                response.sendRedirect("dashboardCoupon");
                break;
            case "edit":
                editCoupon(request, response);
                response.sendRedirect("dashboardCoupon");
                break;
            case "delete":
                deleteCoupon(request, response);
                response.sendRedirect("dashboardCoupon");
                break;
            case "checkCouponCode":
                checkCouponCode(request, response);
                return;
            default:
                response.sendRedirect("dashboardCoupon");
        }
    }

    private void addCoupon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String couponCode = request.getParameter("couponcode");
        int couponTypeId = Integer.parseInt(request.getParameter("coupontypeid"));
        int couponAmount = Integer.parseInt(request.getParameter("couponamount"));
        int usageCount = Integer.parseInt(request.getParameter("usageCount"));

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        Coupons coupon = Coupons.builder()
                .CouponCode(couponCode)
                .CouponAmount(couponAmount)
                .CouponTypeID(couponTypeId)
                .usageCount(usageCount)
                .build();

        couponDAO.insert(coupon);
    }

    private void deleteCoupon(HttpServletRequest request, HttpServletResponse response) {
        int ID = Integer.parseInt(request.getParameter("ID"));
        couponDAO.deleteById(ID);
    }

    private void checkCouponCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String couponCode = request.getParameter("couponcode");
        boolean exists = couponDAO.couponCodeExists(couponCode);
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        if (exists) {
            response.getWriter().write("exists");
        } else {
            response.getWriter().write("not exists");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    private void editCoupon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("ID"));
        String couponCode = request.getParameter("CouponCode");
        int couponTypeId = Integer.parseInt(request.getParameter("CouponTypeName"));
        int couponAmount = Integer.parseInt(request.getParameter("CouponAmount"));
        int usageCount = Integer.parseInt(request.getParameter("UsageCount"));

        Coupons coupon = Coupons.builder()
                .ID(id)
                .CouponCode(couponCode)
                .CouponAmount(couponAmount)
                .CouponTypeID(couponTypeId)
                .usageCount(usageCount)
                .build();

        couponDAO.update(coupon);
    }

}
