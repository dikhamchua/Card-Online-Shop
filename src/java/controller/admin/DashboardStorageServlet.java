package controller.admin;

import controller.user.Constant;
import dal.implement.CardDAO;
import dal.implement.CardTypeDAO;
import dal.implement.CardType_PriceDAO;
import dal.implement.PriceDAO;
import entity.CardType_Price;
import entity.CardTypes;
import entity.Price;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig
public class DashboardStorageServlet extends HttpServlet {

    CardDAO cardDAO = new CardDAO();
    CardTypeDAO cardTypeDAO = new CardTypeDAO();
    CardType_PriceDAO ctpdao = new CardType_PriceDAO();
    PriceDAO pdao = new PriceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword");
        String searchID = request.getParameter("searchID");
        String searchName = request.getParameter("searchName");
        String searchValue = request.getParameter("searchValue");

        List<CardTypes> listCardTypes = cardTypeDAO.findAll();
        List<Price> listPrice = pdao.findAll();
        List<CardType_Price> listCardTypesPrice;

        // filter
        if ("filter".equals(action)) {
            listCardTypesPrice = ctpdao.filterCardTypePrices(
                    searchID != null && !searchID.trim().isEmpty() ? Integer.parseInt(searchID) : null,
                    searchName != null && !searchName.trim().isEmpty() ? searchName : null,
                    searchValue != null && !searchValue.trim().isEmpty() ? Integer.parseInt(searchValue) : null);
        } // search
        else if ("search".equals(action)) {
            listCardTypesPrice = ctpdao.findByNameOrIdOrPrice(keyword);
        } else {
            listCardTypesPrice = ctpdao.findAll();
        }

        Map<Integer, Integer> quantityMap = new LinkedHashMap<>();
        for (CardType_Price ctp : listCardTypesPrice) {
            int quantity = cardDAO.getQuantityByCardTypeId(ctp.getID());
            quantityMap.put(ctp.getID(), quantity);
        }

        // Pagination
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

        int totalRecord = listCardTypesPrice.size();
        int totalPage = (totalRecord % Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord / Constant.RECORD_PER_PAGE)
                : (totalRecord / Constant.RECORD_PER_PAGE) + 1;

        int start = (page - 1) * Constant.RECORD_PER_PAGE;
        int end = Math.min(start + Constant.RECORD_PER_PAGE, totalRecord);

        List<CardType_Price> paginatedList = listCardTypesPrice.subList(start, end);

        // Tính toán các trang để hiển thị
        int beginPage = Math.max(1, page - 2);
        int endPage = Math.min(totalPage, page + 2);

        if (page > 3) {
            beginPage = Math.max(1, beginPage); // Always show at least the first page
        }

        if (endPage < totalPage - 1) {
            endPage = Math.min(totalPage, endPage); // Always show at least the last page
        }

        request.setAttribute("listCardTypes", listCardTypes);
        request.setAttribute("listCardTypesPrice", paginatedList);
        request.setAttribute("listPrice", listPrice);
        request.setAttribute("quantityMap", quantityMap);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("beginPage", beginPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("searchID", searchID);
        request.setAttribute("searchName", searchName);
        request.setAttribute("searchValue", searchValue);
        request.setAttribute("keyword", keyword);
        request.setAttribute("action", action);

        request.getRequestDispatcher("/view/admin/dashboardStorage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        response.sendRedirect("dashboardStorage");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
