package controller.admin;

import controller.user.Constant;
import dal.implement.CardTypeDAO;
import entity.CardTypes;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.List;

public class DashboardCategoryServlet extends HttpServlet {

    CardTypeDAO cardTypeDAO = new CardTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve search parameters
        String keyword = request.getParameter("keyword");
        List<CardTypes> listCardTypes;
        // Perform search by ID or Name
        if (keyword != null && !keyword.isEmpty()) {
            listCardTypes = cardTypeDAO.findByIdOrName(keyword);
        } else {
            listCardTypes = cardTypeDAO.findAllDesc(); // Use findAllDesc instead of findAll
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
        int totalRecord = listCardTypes.size();
        int totalPage = (totalRecord % Constant.RECORD_PER_PAGE) == 0 ? (totalRecord / Constant.RECORD_PER_PAGE) : (totalRecord / Constant.RECORD_PER_PAGE) + 1;
        int start = (page - 1) * Constant.RECORD_PER_PAGE;
        int end = Math.min(start + Constant.RECORD_PER_PAGE, totalRecord);
        List<CardTypes> paginatedList = listCardTypes.subList(start, end);
        request.setAttribute("listCardTypes", paginatedList);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/view/admin/dashboardCategory.jsp").forward(request, response);
    }

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
                addCategory(request, response);
                return;
            case "delete":
                delete(request, response);
                response.sendRedirect(request.getContextPath() + "/dashboardCategory");
                break;
            case "edit":
                edit(request, response);
                response.sendRedirect(request.getContextPath() + "/dashboardCategory");
                break;
            default:
                throw new AssertionError();
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void edit(HttpServletRequest request, HttpServletResponse response) {
        CardTypes cardTypes = new CardTypes();
        int ID = Integer.parseInt(request.getParameter("ID"));
        String cardTypeName = request.getParameter("CardTypeName");
        cardTypes.setID(ID);
        cardTypes.setCardTypeName(cardTypeName);
        CardTypeDAO dao = new CardTypeDAO();
        dao.updateCardType(cardTypes);
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        int ID = Integer.parseInt(request.getParameter("id"));
        cardTypeDAO.deleteById(ID);
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cardcode = request.getParameter("name");
        boolean exists = cardTypeDAO.cardTypeNameExists(cardcode);

        try (PrintWriter out = response.getWriter()) {
            if (exists) {
                out.print("exists");
                return;
            }
        }

        String cardTypeName = request.getParameter("name");
        String defaultImage = null;

        // Create a new CardTypes object and set its name
        CardTypes newCardType = CardTypes.builder()
                .CardTypeName(cardTypeName)
                .Image(defaultImage)
                .build();

        // Insert the new CardType into the database
        cardTypeDAO.insert(newCardType);
    }
}
