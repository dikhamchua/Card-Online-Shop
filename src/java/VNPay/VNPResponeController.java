/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package VNPay;

import dal.implement.HistoryWalletDAO;
import dal.implement.UsersDAO;
import dal.implement.WalletDAO;
import entity.Users;
import entity.Wallet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class VNPResponeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }
        String status = request.getParameter("vnp_TransactionStatus");
        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove("vnp_SecureHashType");
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }
        String amount = request.getParameter("vnp_Amount");
        String username = request.getParameter("vnp_OrderInfo").substring(23).trim();
        UsersDAO usersDAO = new UsersDAO();
        Users user = usersDAO.getUserByUsername(username);
        String statusDB = "Nạp tiền không thành công";
        if (status.equals("00")) {
            statusDB = "Nạp Tiền Thành công";
            WalletDAO walletDAO = new WalletDAO();
            Wallet wallet = walletDAO.getWalletByUserID(user.getID());
            try {
                walletDAO.addMoney(user.getID(), wallet != null && wallet.getWallet() != null ? new BigDecimal(amount).divide(new BigDecimal(100)).add((BigDecimal) wallet.getWallet()) : new BigDecimal(amount).divide(new BigDecimal(100)));
                request.getSession().setAttribute("wallet", walletDAO.getWalletByUserID(user.getID()));
            } catch (SQLException ex) {
                Logger.getLogger(VNPResponeController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        HistoryWalletDAO historyWalletDAO = new HistoryWalletDAO();
        historyWalletDAO.insertHistoryWalletDAO(user.getID(), statusDB, new BigDecimal(amount).divide(new BigDecimal(100)));
        response.sendRedirect("home");
    }

    @Override
public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}