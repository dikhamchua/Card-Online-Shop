package dal.implement;

import dal.DBContext;
import dal.GenericDAO;
import entity.Cards;
import entity.OrderDetails;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

public class OrderDetailsDAO extends GenericDAO<OrderDetails> {

    @Override
    public List<OrderDetails> findAll() {
        return queryGenericDAO(OrderDetails.class);
    }

    @Override
    public int insert(OrderDetails t) {
        String sql = "INSERT INTO orderdetails\n"
                + "                           (\n"
                + "                           OrderID\n"
                + "                           ,CardID\n"
                + "                           ,Quantity\n"
                + "                           ,TransactionDate\n"
                + "                           ,CreatedAt\n"
                + "                           ,UpdatedAt\n"
                + "                           ,IsDelete\n"
                + "                           ,DeletedAt\n"
                + "                           ,Status)\n"
                + "                     VALUES\n"
                + "                           (?\n"
                + "                           ,?\n"
                + "                           ,?\n"
                + "                           ,?\n"
                + "                           ,?\n"
                + "                           ,?\n"
                + "                           ,?\n"
                + "                           ,?\n"
                + "                           ,?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("orderid", t.getOrderID());
        parameterMap.put("cardid", t.getCardID());
        parameterMap.put("quantity", t.getQuantity());
        parameterMap.put("transactiondate", t.getTransactionDate());
        parameterMap.put("createdat", t.getCreatedAt());
        parameterMap.put("updatedat", t.getUpdatedAt());
        parameterMap.put("isdelete", t.isIsDelete());
        parameterMap.put("deletedat", t.getDeletedAt());
        parameterMap.put("status", t.isStatus());
        return insertGenericDAO(sql, parameterMap);
    }

    // Method to find OrderDetails by orderId
    public List<OrderDetails> findByOrderId(int orderId) {
        String sql = "SELECT * FROM orderdetails WHERE orderId = ?";
        List<OrderDetails> list = new ArrayList<>();
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, orderId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    OrderDetails orderDetails = new OrderDetails();
                    orderDetails.setID(resultSet.getInt("ID"));
                    orderDetails.setOrderID(resultSet.getInt("OrderID"));
                    orderDetails.setCardID(resultSet.getInt("CardID"));
                    orderDetails.setQuantity(resultSet.getInt("Quantity"));

                    Timestamp transactionDate = resultSet.getTimestamp("TransactionDate");
                    if (transactionDate != null) {
                        orderDetails.setTransactionDate(transactionDate.toLocalDateTime());
                    }

                    Timestamp createdAt = resultSet.getTimestamp("CreatedAt");
                    if (createdAt != null) {
                        orderDetails.setCreatedAt(createdAt.toLocalDateTime());
                    }

                    Timestamp updatedAt = resultSet.getTimestamp("UpdatedAt");
                    if (updatedAt != null) {
                        orderDetails.setUpdatedAt(updatedAt.toLocalDateTime());
                    }

                    orderDetails.setCreatedBy(resultSet.getInt("CreatedBy"));
                    orderDetails.setIsDelete(resultSet.getBoolean("IsDelete"));

                    Timestamp deletedAt = resultSet.getTimestamp("DeletedAt");
                    if (deletedAt != null) {
                        orderDetails.setDeletedAt(deletedAt.toLocalDateTime());
                    }

                    orderDetails.setDeletedBy(resultSet.getInt("DeletedBy"));
                    orderDetails.setStatus(resultSet.getBoolean("Status"));
                    list.add(orderDetails);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        System.out.println(new OrderDetailsDAO().findByOrderId(1));
    }

    public int insertOrderDetail(int orderId, int cardId, int quantity, int createdBy) {
        String sql = "INSERT INTO orderdetails (OrderID, CardID, Quantity, TransactionDate, CreatedAt, UpdatedAt, CreatedBy, Status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, orderId);
            statement.setInt(2, cardId);
            statement.setInt(3, quantity);
            statement.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
            statement.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            statement.setTimestamp(6, Timestamp.valueOf(LocalDateTime.now()));
            statement.setInt(7, createdBy);
            statement.setBoolean(8, true); // Set status to true (available)
            return statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public Cards getAvailableCard(int cardTypeId) {
        String sql = "SELECT * FROM cards WHERE CardType_Price = ? AND Status = 'Available' LIMIT 1";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, cardTypeId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Cards card = new Cards();
                    card.setID(resultSet.getInt("ID"));
                    card.setCardCode(resultSet.getString("CardCode"));
                    card.setSerialNumber(resultSet.getString("SerialNumber"));
                    card.setCreatedAt(resultSet.getTimestamp("CreatedAt").toLocalDateTime());
                    card.setUpdatedAt(resultSet.getTimestamp("UpdatedAt").toLocalDateTime());
                    card.setCreatedBy(resultSet.getInt("CreatedBy"));
                    card.setIsDelete(resultSet.getBoolean("IsDelete"));
                    card.setDeletedBy(resultSet.getInt("DeletedBy"));
                    card.setDeletedAt(resultSet.getTimestamp("DeletedAt") != null ? resultSet.getTimestamp("DeletedAt").toLocalDateTime() : null);
                    card.setStatus(resultSet.getString("Status"));
                    card.setCardType_Price(resultSet.getInt("CardType_Price"));
                    return card;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateCardStatus(int cardId, String newStatus) {
        String sql = "UPDATE cards SET Status = ? WHERE ID = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, newStatus);
            statement.setInt(2, cardId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<String> getCardNamesByOrderID(int orderId) {
        List<String> cardNames = new ArrayList<>();
        String sql = "SELECT ct.CardTypeName "
                + "FROM orderdetails od "
                + "JOIN cards c ON od.CardID = c.ID "
                + "JOIN cardtype_price cp ON c.CardType_Price = cp.ID "
                + "JOIN cardtypes ct ON cp.CardTypeID = ct.ID "
                + "WHERE od.OrderID = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, orderId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    cardNames.add(rs.getString("CardTypeName"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cardNames;
    }

}
