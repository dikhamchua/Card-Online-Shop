package dal.implement;

import dal.DBContext;
import entity.HistoryWallet;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.sql.Timestamp;

public class HistoryWalletDAO {

    private int noOfRecords;

    public List<HistoryWallet> getWalletByUserID(int userID) {
        List<HistoryWallet> list = new ArrayList<>();
        String sql = "SELECT * FROM historywallet WHERE userid = ? ORDER BY createdDate DESC";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                HistoryWallet h = new HistoryWallet();
                h.setId(rs.getInt("id"));
                h.setAmount(rs.getBigDecimal("amount"));
                h.setCreatedAt(rs.getTimestamp("createdDate").toLocalDateTime());
                h.setStatus(rs.getString("status"));
                h.setUserID(userID);
                list.add(h);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<HistoryWallet> getWalletByUserID(int userID, int offset, int noOfRecords) {
        List<HistoryWallet> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS * FROM historywallet WHERE userid = ? ORDER BY createdDate DESC LIMIT ?, ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userID);
            statement.setInt(2, offset);
            statement.setInt(3, noOfRecords);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                HistoryWallet h = new HistoryWallet();
                h.setId(rs.getInt("id"));
                h.setAmount(rs.getBigDecimal("amount"));
                h.setCreatedAt(rs.getTimestamp("createdDate").toLocalDateTime());
                h.setStatus(rs.getString("status"));
                h.setUserID(userID);
                list.add(h);
            }
            rs.close();

            // Truy vấn tổng số bản ghi
            try (PreparedStatement countStatement = connection.prepareStatement("SELECT FOUND_ROWS()"); ResultSet countRs = countStatement.executeQuery()) {
                if (countRs.next()) {
                    this.noOfRecords = countRs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getNoOfRecords() {
        return noOfRecords;
    }

    public void insertHistoryWalletDAO(int userID, String status, BigDecimal amount) {
        String sql = "INSERT INTO historywallet (userid, status, amount) VALUES (?, ?, ?)";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userID);
            statement.setString(2, status);
            statement.setBigDecimal(3, amount);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<HistoryWallet> getTransactionsByUserId(int userId) {
        List<HistoryWallet> transactions = new ArrayList<>();
        String sql = "SELECT * FROM historywallet WHERE userid = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                HistoryWallet transaction = HistoryWallet.builder()
                        .id(rs.getInt("id"))
                        .userID(rs.getInt("userid"))
                        .createdAt(rs.getTimestamp("createdDate").toLocalDateTime())
                        .status(rs.getString("status"))
                        .amount(rs.getBigDecimal("amount"))
                        .build();
                transactions.add(transaction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }

    public List<HistoryWallet> getWalletByUserIDAndDateRange(int userID, int offset, int noOfRecords, Date startDate, Date endDate) {
        List<HistoryWallet> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS * FROM historywallet WHERE userid = ?";

        if (startDate != null) {
            sql += " AND createdDate >= ?";
        }
        if (endDate != null) {
            sql += " AND createdDate <= ?";
        }

        sql += " ORDER BY createdDate DESC LIMIT ?, ?";

        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            statement.setInt(paramIndex++, userID);
            if (startDate != null) {
                statement.setTimestamp(paramIndex++, new Timestamp(startDate.getTime()));
            }
            if (endDate != null) {
                statement.setTimestamp(paramIndex++, new Timestamp(endDate.getTime()));
            }
            statement.setInt(paramIndex++, offset);
            statement.setInt(paramIndex, noOfRecords);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                HistoryWallet h = new HistoryWallet();
                h.setId(rs.getInt("id"));
                h.setAmount(rs.getBigDecimal("amount"));
                h.setCreatedAt(rs.getTimestamp("createdDate").toLocalDateTime());
                h.setStatus(rs.getString("status"));
                h.setUserID(userID);
                list.add(h);
            }
            rs.close();

            // Truy vấn tổng số bản ghi
            try (PreparedStatement countStatement = connection.prepareStatement("SELECT FOUND_ROWS()"); ResultSet countRs = countStatement.executeQuery()) {
                if (countRs.next()) {
                    this.noOfRecords = countRs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<HistoryWallet> searchWalletByUserIDAndKeyword(int userID, int offset, int noOfRecords, String keyword) {
    List<HistoryWallet> list = new ArrayList<>();
    boolean isNumeric = keyword.chars().allMatch(Character::isDigit);
    String sql;
    if (isNumeric) {
        sql = "SELECT SQL_CALC_FOUND_ROWS * FROM historywallet WHERE userid = ? AND CAST(amount AS CHAR) LIKE ? ORDER BY createdDate DESC LIMIT ?, ?";
    } else {
        sql = "SELECT SQL_CALC_FOUND_ROWS * FROM historywallet WHERE userid = ? AND (status LIKE ? OR CAST(amount AS CHAR) LIKE ?) ORDER BY createdDate DESC LIMIT ?, ?";
    }
    
    try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
        statement.setInt(1, userID);
        statement.setString(2, "%" + keyword + "%");
        if (!isNumeric) {
            statement.setString(3, "%" + keyword + "%");
            statement.setInt(4, offset);
            statement.setInt(5, noOfRecords);
        } else {
            statement.setInt(3, offset);
            statement.setInt(4, noOfRecords);
        }
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            HistoryWallet h = new HistoryWallet();
            h.setId(rs.getInt("id"));
            h.setAmount(rs.getBigDecimal("amount"));
            h.setCreatedAt(rs.getTimestamp("createdDate").toLocalDateTime());
            h.setStatus(rs.getString("status"));
            h.setUserID(userID);
            list.add(h);
        }
        rs.close();

        // Truy vấn tổng số bản ghi
        try (PreparedStatement countStatement = connection.prepareStatement("SELECT FOUND_ROWS()"); ResultSet countRs = countStatement.executeQuery()) {
            if (countRs.next()) {
                this.noOfRecords = countRs.getInt(1);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}

    public static void main(String[] args) {
        for (HistoryWallet string : new HistoryWalletDAO().getTransactionsByUserId(29)) {
            System.out.println(string);
        }

    }
}
