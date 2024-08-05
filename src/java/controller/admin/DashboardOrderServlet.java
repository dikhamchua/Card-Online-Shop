package controller.admin;

import controller.user.Constant;
import dal.implement.CardDAO;
import dal.implement.CardTypeDAO;
import dal.implement.CardType_PriceDAO;
import dal.implement.OrderDetailsDAO;
import dal.implement.OrdersDAO;
import dal.implement.PriceDAO;
import dal.implement.UsersDAO;
import entity.CardType_Price;
import entity.CardTypes;
import entity.Cards;
import entity.OrderDetails;
import entity.Orders;
import entity.PageControl;
import entity.Price;
import entity.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@MultipartConfig
public class DashboardOrderServlet extends HttpServlet {

    CardDAO cardDAO = new CardDAO();
    PriceDAO pdao = new PriceDAO();
    UsersDAO usersDAO = new UsersDAO();
    OrdersDAO ordersDAO = new OrdersDAO();
    OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
    CardTypeDAO cardTypeDAO = new CardTypeDAO();
    CardType_PriceDAO cardType_PriceDAO = new CardType_PriceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        String url = null;
        switch (action) {
            case "detailsOrder":
                url = viewOrderDetails(request, response);
                break;
            default:
                url = viewOrder(request, response);
                break;
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();

        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        String requestURL = request.getRequestURL().toString();
        String url = null;
        switch (action) {
            case "detailsOrder":
                url = viewOrderDetails(request, response);
                break;
            default:
                break;
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    private String viewOrderDetails(HttpServletRequest request, HttpServletResponse response) {
        int ID = Integer.parseInt(request.getParameter("OrderID"));
        List<OrderDetails> listOrderDetails = orderDetailsDAO.findByOrderId(ID);
        List<Cards> listCards = cardDAO.findAll();

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

        int totalRecord = listOrderDetails.size();
        int totalPage = (totalRecord % Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord / Constant.RECORD_PER_PAGE)
                : (totalRecord / Constant.RECORD_PER_PAGE) + 1;

        int start = (page - 1) * Constant.RECORD_PER_PAGE;
        int end = Math.min(start + Constant.RECORD_PER_PAGE, totalRecord);
        String requestURL = request.getRequestURL().toString();
        PageControl pageControl = new PageControl();
        pageControl.setUrlPattern(requestURL + "?action=detailsOrder&OrderID=" + ID);
        pageControl.setPage(page);

        // Tính toán các trang để hiển thị
        int beginPage = Math.max(1, page - 2);
        int endPage = Math.min(totalPage, page + 2);

        if (page > 3) {
            beginPage = Math.max(1, beginPage); // Always show at least the first page
        }

        if (endPage < totalPage - 1) {
            endPage = Math.min(totalPage, endPage); // Always show at least the last page
        }

        List<OrderDetails> paginatedList = listOrderDetails.subList(start, end);
        request.setAttribute("ListOrders", paginatedList);
        request.setAttribute("pageControl", pageControl);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("beginPage", beginPage);
        request.setAttribute("endPage", endPage);
        HttpSession session = request.getSession();
        session.setAttribute("listOrderDetails", listOrderDetails);
        session.setAttribute("listCards", listCards);
        return "view/admin/editOrderDetails.jsp";
    }

    private String viewOrder(HttpServletRequest request, HttpServletResponse response) {
        List<Cards> ListCards = cardDAO.findAll();
        List<Orders> ListOrders = ordersDAO.findAllDesc();
        List<Users> ListUsers = usersDAO.findAll();
        List<OrderDetails> ListOrderDetails = orderDetailsDAO.findAll();
        List<Price> listPrice = pdao.findAll();
        List<CardTypes> listCardTypes = cardTypeDAO.findAll();
        List<CardType_Price> listCardType_Prices = cardType_PriceDAO.findAll();

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

        int totalRecord = ListOrders.size();
        int totalPage = (totalRecord % Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord / Constant.RECORD_PER_PAGE)
                : (totalRecord / Constant.RECORD_PER_PAGE) + 1;

        int start = (page - 1) * Constant.RECORD_PER_PAGE;
        int end = Math.min(start + Constant.RECORD_PER_PAGE, totalRecord);

        List<Orders> paginatedList = ListOrders.subList(start, end);

        // Tính toán các trang để hiển thị
        int beginPage = Math.max(1, page - 2);
        int endPage = Math.min(totalPage, page + 2);

        if (page > 3) {
            beginPage = Math.max(1, beginPage); // Always show at least the first page
        }

        if (endPage < totalPage - 1) {
            endPage = Math.min(totalPage, endPage); // Always show at least the last page
        }

        request.setAttribute("ListOrders", paginatedList);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("beginPage", beginPage);
        request.setAttribute("endPage", endPage);

        HttpSession session = request.getSession();

        session.setAttribute("listCardType_Prices", listCardType_Prices);
        session.setAttribute("listCardTypes", listCardTypes);
        session.setAttribute("ListCards", ListCards);
        session.setAttribute("ListUsers", ListUsers);
        session.setAttribute("ListOrderDetails", ListOrderDetails);
        session.setAttribute("listPrice", listPrice);
        return "view/admin/dashboardOrder.jsp";
    }
}
