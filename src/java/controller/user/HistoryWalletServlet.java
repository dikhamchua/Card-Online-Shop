package controller.user;

import dal.implement.HistoryWalletDAO;
import entity.HistoryWallet;
import entity.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class HistoryWalletServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Users user = (Users) request.getSession().getAttribute("users");
            HistoryWalletDAO historyWalletDAO = new HistoryWalletDAO();

            // Lấy thông tin phân trang từ request
            int page = 1;
            int recordsPerPage = 10;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            // Lấy thông tin bộ lọc từ request
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");

            // Lấy thông tin tìm kiếm từ request
            String searchKeyword = request.getParameter("searchKeyword");

            Date startDate = null;
            Date endDate = null;

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                if (startDateStr != null && !startDateStr.isEmpty()) {
                    startDate = dateFormat.parse(startDateStr);
                }
                if (endDateStr != null && !endDateStr.isEmpty()) {
                    endDate = dateFormat.parse(endDateStr);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            int userId = user.getID();
            List<HistoryWallet> list;
            int noOfRecords;

            // Sử dụng bộ lọc hoặc tìm kiếm tùy theo yêu cầu
            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                list = historyWalletDAO.searchWalletByUserIDAndKeyword(userId, (page - 1) * recordsPerPage, recordsPerPage, searchKeyword);
                noOfRecords = historyWalletDAO.getNoOfRecords();
            } else {
                list = historyWalletDAO.getWalletByUserIDAndDateRange(userId, (page - 1) * recordsPerPage, recordsPerPage, startDate, endDate);
                noOfRecords = historyWalletDAO.getNoOfRecords();
            }

            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

            // Kiểm tra xem danh sách có trống không
            if (list.isEmpty()) {
                request.setAttribute("noResults", true);
            }

            request.setAttribute("list", list);
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("startDate", startDateStr);
            request.setAttribute("endDate", endDateStr);
            request.setAttribute("searchKeyword", searchKeyword);

            request.getRequestDispatcher("view/homepage/historyWallet.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
