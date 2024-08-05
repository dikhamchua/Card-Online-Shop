/* * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template */package dal.implement;

import dal.DBContext;
import dal.GenericDAO;
import entity.Wallet;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.LinkedHashMap;

/**
 * * * @author admin
 */
public class WalletDAO extends GenericDAO<Wallet> {

    Connection conn = null;
    PreparedStatement ps = null;

    @Override
    public List<Wallet> findAll() {
        return queryGenericDAO(Wallet.class);
    }

    public Wallet getWalletByUserID(int userID) {
        String sql = "SELECT * FROM wallet where UserID = ?";
        try {
            Connection connection = new DBContext().getConnection();
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                return new Wallet(rs.getInt("ID"), rs.getBigDecimal("Total"), rs.getInt("UserID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addMoney(int id, BigDecimal bigDecimal) throws SQLException {
        Connection connection = new DBContext().getConnection();
        if (getWalletByUserID(id) == null) {
            String sql = "INSERT INTO wallet (" + "UserID, " + "Total) " + "VALUES (?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            statement.setBigDecimal(2, bigDecimal);
            statement.executeUpdate();
        } else {
            String sql = "UPDATE wallet SET " + "Total = ? " + "WHERE UserID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setBigDecimal(1, bigDecimal);
            statement.setInt(2, id);
            statement.executeUpdate();
        }
    }

    public void insertWalletForNewUser(int userID) throws SQLException {
        String sql = "INSERT INTO wallet (UserID, Total) VALUES (?, ?)";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userID);
            statement.setBigDecimal(2, BigDecimal.ZERO);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public int insert(Wallet wallet) {
        String sql = "INSERT INTO wallet (UserID, Total) VALUES (?, ?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("UserID", wallet.getUserID());
        parameterMap.put("Total", wallet.getTotal());
        return insertGenericDAO(sql, parameterMap);
    }

    public Wallet findByUserId(int userId) {
        String sql = "SELECT * FROM wallet WHERE UserID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("UserID", userId);
        List<Wallet> walletList = queryGenericDAO(Wallet.class, sql, parameterMap);
        return walletList.isEmpty() ? null : walletList.get(0);
    }

    public boolean update(Wallet wallet) {
        String sql = "UPDATE wallet SET Total = ? WHERE ID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Total", wallet.getTotal());
        parameterMap.put("ID", wallet.getId());
        return updateGenericDAO(sql, parameterMap);
    }

    public void deleteById(int id) {
        String sql = "DELETE FROM wallet WHERE ID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("ID", id);
        deleteGenericDAO(sql, parameterMap);
    }

    public List<Wallet> findByUserIdOrTotal(String keyword) {
        String sql = "SELECT * FROM wallet WHERE UserID LIKE ? OR Total LIKE ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("UserID", "%" + keyword + "%");
        parameterMap.put("Total", "%" + keyword + "%");
        System.out.println("Executing query: " + sql);
        System.out.println("With parameters: " + parameterMap);
        return queryGenericDAO(Wallet.class, sql, parameterMap);
    }

    /**
     * * * Deducts the specified amount from the user's wallet.* * * @param
     * userId The ID of the user whose wallet should be updated.* @param amount
     * The amount to be deducted from the user's wallet.* @return true if the
     * update was successful, false otherwise. * @throws SQLException if there
     * is an error executing the SQL query.
     *
     * @param userId
     * @param amount
     * @return
     */
    public boolean deductFromWallet(int userId, BigDecimal amount) throws SQLException {
        Wallet wallet = getWalletByUserID(userId);
        if (wallet == null) {
            return false; // User's wallet not found       
        }
        BigDecimal newTotal = wallet.getTotal().subtract(amount);
        if (newTotal.compareTo(BigDecimal.ZERO) < 0) {
            return false; // Insufficient funds        
        }

        String sql = "UPDATE wallet SET Total = ? WHERE UserID = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setBigDecimal(1, newTotal);
            statement.setInt(2, userId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

}
