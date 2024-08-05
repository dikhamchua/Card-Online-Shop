package dal.implement;

import dal.GenericDAO;
import entity.TransactionHistory;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import dal.DBContext;

public class TransactionHistoryDAO extends GenericDAO<TransactionHistory> {

    Connection conn = null;
    PreparedStatement ps = null;

    @Override
    public List<TransactionHistory> findAll() {
        return queryGenericDAO(TransactionHistory.class);
    }

    @Override
    public int insert(TransactionHistory t) {
        String sql = "INSERT INTO transaction_history (UserID, Amount, TransactionDate, AdminID) VALUES (?, ?, ?, ?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("UserID", t.getUserID());
        parameterMap.put("Amount", t.getAmount());
        parameterMap.put("TransactionDate", Timestamp.valueOf(LocalDateTime.now()));
        parameterMap.put("AdminID", t.getAdminID());
        return insertGenericDAO(sql, parameterMap);
    }

    public void deleteById(int id) {
        String sql = "DELETE FROM transaction_history WHERE ID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("ID", id);
        deleteGenericDAO(sql, parameterMap);
    }

    public TransactionHistory findById(int id) {
        String sql = "SELECT * FROM transaction_history WHERE ID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("ID", id);
        List<TransactionHistory> list = queryGenericDAO(TransactionHistory.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    public boolean update(TransactionHistory t) {
        String sql = "UPDATE transaction_history SET UserID = ?, Amount = ?, TransactionDate = ?, AdminID = ? WHERE ID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("UserID", t.getUserID());
        parameterMap.put("Amount", t.getAmount());
        parameterMap.put("TransactionDate", t.getTransactionDate());
        parameterMap.put("AdminID", t.getAdminID());
        parameterMap.put("ID", t.getID());
        return updateGenericDAO(sql, parameterMap);
    }
}
