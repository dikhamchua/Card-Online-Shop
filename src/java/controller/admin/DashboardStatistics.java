package controller.admin;

import dal.implement.OrdersDAO;
import entity.OrderStatistics;
import entity.UserOrderStatistics;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/admin/dashboardStatistics")
public class DashboardStatistics extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DashboardStatistics</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashboardStatistics at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String userStartDate = request.getParameter("userStartDate");
        String userEndDate = request.getParameter("userEndDate");

        int page = 1;
        int userPage = 1;
        int recordsPerPage = 5;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        if (request.getParameter("userPage") != null) {
            userPage = Integer.parseInt(request.getParameter("userPage"));
        }

        OrdersDAO ordersDAO = new OrdersDAO();
        int offset = (page - 1) * recordsPerPage;
        List<OrderStatistics> statistics = ordersDAO.getOrderStatistics(startDate, endDate, offset, recordsPerPage);// Lấy danh sách thống kê đơn hàng

        int noOfRecords = ordersDAO.getNoOfRecords(startDate, endDate);
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

        int userOffset = (userPage - 1) * recordsPerPage;
        List<UserOrderStatistics> userStatistics = ordersDAO.getUserOrderStatistics(userStartDate, userEndDate, userOffset, recordsPerPage);// Lấy danh sách thống kê người dùng

        int userNoOfRecords = ordersDAO.getNoOfRecords(userStartDate, userEndDate);// Lấy tổng số bản ghi cho thống kê người dùng
        int userNoOfPages = (int) Math.ceil(userNoOfRecords * 1.0 / recordsPerPage);// Tính toán số trang cho thống kê người dùng

        BigDecimal totalRevenue = BigDecimal.ZERO;// mac dinh là 0
        if ("calculateTotalRevenue".equals(request.getParameter("action"))) {
            //tính toán 
            totalRevenue = ordersDAO.calculateTotalRevenue(startDate, endDate);
        } else if (request.getParameter("totalRevenue") != null) {
            try {
                totalRevenue = new BigDecimal(request.getParameter("totalRevenue"));// Lấy tổng doanh thu từ tham số yêu cầu nếu có
            } catch (NumberFormatException e) {
                totalRevenue = BigDecimal.ZERO;
            }
        }

        request.setAttribute("statistics", statistics);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);

        request.setAttribute("userStatistics", userStatistics);
        request.setAttribute("userNoOfPages", userNoOfPages);
        request.setAttribute("userCurrentPage", userPage);
        request.setAttribute("userStartDate", userStartDate);
        request.setAttribute("userEndDate", userEndDate);

        request.setAttribute("totalRevenue", totalRevenue);
        request.getRequestDispatcher("/view/admin/dashboardStatistics.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
