package controller.homepage;

import dal.implement.CardDAO;
import dal.implement.CardTypeDAO;
import dal.implement.CardType_PriceDAO;
import dal.implement.PriceDAO;
import dal.implement.UsersDAO;
import entity.Cards;
import entity.CardTypes;
import entity.CardType_Price;
import entity.Price;
import entity.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class HomeController extends HttpServlet {

    CardDAO cardDAO = new CardDAO();
    CardTypeDAO cardTypeDAO = new CardTypeDAO();
    PriceDAO priceDAO = new PriceDAO();
    CardType_PriceDAO cardtype_priceDAO = new CardType_PriceDAO();
    UsersDAO usersDAO = new UsersDAO();

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
        String searchQuery = request.getParameter("searchQuery");
        String action = request.getParameter("action");
        String categoryIdRaw = request.getParameter("id");

        HttpSession session = request.getSession();

        List<Cards> listProduct = cardDAO.findAll();
        session.setAttribute("listProduct", listProduct);

        List<CardTypes> listCardType = cardTypeDAO.findAll();
        session.setAttribute("listCardType", listCardType);

//        List<CardType_Price> listCardType_Price = cardtype_priceDAO.findListCardType_PriceNotOutOfStock();
//        request.setAttribute("listCardType_Price", listCardType_Price);
        List<CardType_Price> listCardType_Price = cardtype_priceDAO.getAllCardTypePriceDesc();
        session.setAttribute("listCardType_Price", listCardType_Price);

        List<Price> listPrice = priceDAO.findAll();
        session.setAttribute("listPrice", listPrice);

        List<Users> listAccount = usersDAO.findAll();
        session.setAttribute("listAccount", listAccount);

        if ("category".equals(action) && categoryIdRaw != null && !categoryIdRaw.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdRaw);
                listCardType_Price = cardtype_priceDAO.findByCardTypeId(categoryId);
            } catch (NumberFormatException e) {
                listCardType_Price = cardtype_priceDAO.findAll();
            }
        } else if (searchQuery != null && !searchQuery.isEmpty()) {
            listCardType_Price = cardtype_priceDAO.findByNameOrIdOrPrice(searchQuery);
        } else {
            listCardType_Price = cardtype_priceDAO.getAllCardTypePriceDesc();
        }
        // Kiểm tra nếu không có kết quả
        if (listCardType_Price.isEmpty()) {
            request.setAttribute("noResultMessage", "Không tồn tại mặt hàng này");
        }

        Map<Integer, Integer> quantityMap = new LinkedHashMap<>();
        for (CardType_Price ctp : listCardType_Price) {
            int quantity = cardDAO.getQuantityByCardTypeId(ctp.getID());
            quantityMap.put(ctp.getID(), quantity);
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

        int totalRecord = listCardType_Price.size();
        int totalPage = (totalRecord % controller.homepage.Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord / controller.homepage.Constant.RECORD_PER_PAGE)
                : (totalRecord / controller.homepage.Constant.RECORD_PER_PAGE) + 1;
        int start = (page - 1) * controller.homepage.Constant.RECORD_PER_PAGE;
        int end = Math.min(start + controller.homepage.Constant.RECORD_PER_PAGE, totalRecord);
        List<CardType_Price> paginatedList = listCardType_Price.subList(start, end);
        request.setAttribute("listCardType_Price", paginatedList);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("quantityMap", quantityMap);

        if ("category".equals(action) && categoryIdRaw != null && !categoryIdRaw.isEmpty()) {
            request.getRequestDispatcher("view/homepage/buyCard.jsp").forward(request, response);
        } else if (searchQuery != null && !searchQuery.isEmpty()) {
            request.getRequestDispatcher("view/homepage/buyCard.jsp").forward(request, response);
        } else {
            if ("buy-card".equals(action)) {
                request.getRequestDispatcher("view/homepage/buyCard.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("view/homepage/home.jsp").forward(request, response);
            }
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
        List<CardType_Price> listCardTypeByID;
        //get ve action
        String action = request.getParameter("action") != null
                ? request.getParameter("action")
                : "";
        //dua theo action set URL trang can chuyen den
        String url;
        switch (action) {
            case "buy-card":
                url = "view/homepage/buyCard.jsp";
                break;
            case "category":
                try {
                int id = Integer.parseInt(request.getParameter("id"));
                listCardTypeByID = cardtype_priceDAO.findByCardTypeId(id);
                request.setAttribute("listCardType_Price", listCardTypeByID);
                url = "view/homepage/buyCard.jsp";
            } catch (NumberFormatException e) {
                url = "view/homepage/home.jsp";
            }
            break;
            default:
                url = "view/homepage/home.jsp";
        }

        request.getRequestDispatcher(url).forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
