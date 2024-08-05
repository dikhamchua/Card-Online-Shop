package controller.admin;

import controller.user.Constant;
import dal.implement.HistoryWalletDAO;
import dal.implement.UsersDAO;
import dal.implement.WalletDAO;
import entity.HistoryWallet;
import entity.PageControl;
import entity.Users;
import entity.Wallet;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

public class TransactionHistory extends HttpServlet {

    private final WalletDAO walletDAO = new WalletDAO();
    private final UsersDAO userDAO = new UsersDAO();
    private final HistoryWalletDAO historyWalletDAO = new HistoryWalletDAO();
//    private static final Logger LOGGER = Logger.getLogger(TransactionHistory.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        String url = null;
        switch (action) {
            case "detailTransaction":
                url = viewTransactionDetail(request, response);
                break;
            default:
                url = viewTransaction(request, response);
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

        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        String url = null;
        switch (action) {
            case "detailTransaction":
                url = viewTransactionDetail(request, response);
                break;
            default:
                url = viewTransaction(request, response);
                break;
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String viewTransactionDetail(HttpServletRequest request, HttpServletResponse response) {
//        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            List<HistoryWallet> transactions = historyWalletDAO.getTransactionsByUserId(userId);
          //  LOGGER.info("Transactions: " + transactions);
            request.setAttribute("list", transactions);
            request.setAttribute("userId", userId);
            return "/view/admin/transactionDetail.jsp";
//        } catch (NumberFormatException e) {
//            // Xử lý lỗi nếu userId không hợp lệ   
//            request.setAttribute("error", "ID người dùng không hợp lệ.");
//            return "/view/admin/transactionHistory.jsp";
//        }
    }

    private String viewTransaction(HttpServletRequest request, HttpServletResponse response) {
        List<Wallet> listTransactions = walletDAO.findAll();
        List<Users> listAccount = userDAO.findAll();

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

        int totalRecord = listTransactions.size();
        int totalPage = (totalRecord % Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord / Constant.RECORD_PER_PAGE)
                : (totalRecord / Constant.RECORD_PER_PAGE) + 1;

        int start = (page - 1) * Constant.RECORD_PER_PAGE;
        int end = Math.min(start + Constant.RECORD_PER_PAGE, totalRecord);
        String requestURL = request.getRequestURL().toString();
        PageControl pageControl = new PageControl();
        pageControl.setUrlPattern(requestURL + "?action=viewTransaction");
        pageControl.setPage(page);
        List<Wallet> paginatedList = listTransactions.subList(start, end);

        request.setAttribute("listTransactions", paginatedList);
        request.setAttribute("listAccount", listAccount);
        request.setAttribute("pageControl", pageControl);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);
        HttpSession session = request.getSession();
        session.setAttribute("listTransactions", listTransactions);
        return "/view/admin/transactionHistory.jsp";
    }
}
