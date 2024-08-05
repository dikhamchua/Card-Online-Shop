package controller.admin;

import dal.implement.UsersDAO;
import dal.implement.WalletDAO;
import dal.implement.HistoryWalletDAO;
import entity.Users;
import entity.Wallet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

public class AdminAddMoneyServlet extends HttpServlet {

    UsersDAO userDAO = new UsersDAO();
    WalletDAO walletDAO = new WalletDAO();
    HistoryWalletDAO historyWalletDAO = new HistoryWalletDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");
        List<Users> userList;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            userList = userDAO.searchByName(searchQuery);
            if (userList.isEmpty()) {
                request.setAttribute("noUserFound", true);
            }
        } else {
            userList = userDAO.findAll();
        }
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/view/admin/addMoney.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("userId");
        String totalStr = request.getParameter("total");
        String action = request.getParameter("action");

        try {
            int userId = Integer.parseInt(userIdStr);
            BigDecimal total = new BigDecimal(totalStr);

            if (total.compareTo(new BigDecimal("5000")) >= 0 && total.compareTo(new BigDecimal("500000000")) <= 0) {
                Wallet wallet = walletDAO.findByUserId(userId);
                if (wallet != null) {
                    BigDecimal newTotal;
                    String status;
                    boolean isSubtract = false;
                    if ("add".equals(action)) {
                        newTotal = wallet.getTotal().add(total);
                        status = "Cộng tiền bởi admin";
                    } else if ("subtract".equals(action)) {
                        if (wallet.getTotal().compareTo(total) < 0) {
                            response.sendRedirect(request.getContextPath() + "/admin/addMoney?error=Not enough balance");
                            return;
                        }
                        newTotal = wallet.getTotal().subtract(total);
                        status = "Trừ tiền bởi admin";
                        total = total.negate(); // Make the total negative for history
                        isSubtract = true;
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/addMoney?error=Invalid action");
                        return;
                    }

                    wallet.setTotal(newTotal);
                    walletDAO.update(wallet);

                    historyWalletDAO.insertHistoryWalletDAO(userId, status, total);

                    HttpSession session = request.getSession();
                    Users loggedInUser = (Users) session.getAttribute("users");
                    if (loggedInUser != null && loggedInUser.getID() == userId) {
                        session.setAttribute("wallet", wallet);
                    }

                    if (isSubtract) {
                        response.sendRedirect(request.getContextPath() + "/admin/addMoney?success=subtract");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/addMoney?success=add");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/addMoney?error=User wallet not found");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/addMoney?error=Amount must be between 5,000 VND and 500,000,000 VND");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/addMoney?error=Invalid input");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/addMoney?error=An error occurred");
        }
    }
}
