package dal.implement;

import dal.GenericDAO;
import dal.DBContext;
import entity.OrderStatistics;
import entity.Orders;
import entity.ProductStatistics;
import entity.UserOrderStatistics;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

public class OrdersDAO extends GenericDAO<Orders> {

    Connection conn = null;
    PreparedStatement ps = null;

    @Override
    public List<Orders> findAll() {
        return queryGenericDAO(Orders.class);
    }

    @Override
    public int insert(Orders order) {
        String sql = "INSERT INTO sold_card_system3.orders ("
                + "UserID, "
                + "TotalMoney, "
                + "CreatedAt, "
                + "UpdatedAt, "
                + "CreatedBy, "
                + "IsDelete, "
                + "DeletedBy, "
                + "DeletedAt) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        LinkedHashMap<String, Object> parameterMap = new LinkedHashMap<>();
        parameterMap.put("UserID", order.getUserID());
        parameterMap.put("TotalMoney", order.getTotalMoney());
        parameterMap.put("CreatedAt", order.getCreatedAt() != null ? Timestamp.valueOf(order.getCreatedAt()) : Timestamp.valueOf(LocalDateTime.now()));
        parameterMap.put("UpdatedAt", order.getUpdatedAt() != null ? Timestamp.valueOf(order.getUpdatedAt()) : Timestamp.valueOf(LocalDateTime.now()));
        parameterMap.put("CreatedBy", order.getCreatedBy());
        parameterMap.put("IsDelete", order.isIsDelete());
        parameterMap.put("DeletedBy", order.getDeletedBy());
        parameterMap.put("DeletedAt", order.getDeletedAt() != null ? Timestamp.valueOf(order.getDeletedAt()) : null);
        return insertGenericDAO(sql, parameterMap);
    }

    public int insertOrder(Orders order) {
        String sql = "INSERT INTO sold_card_system3.orders ("
                + "CardID, "
                + "UserID, "
                + "TotalMoney, "
                + "CreatedAt, "
                + "UpdatedAt, "
                + "CreatedBy, "
                + "IsDelete, "
                + "DeletedBy, "
                + "DeletedAt) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        LinkedHashMap<String, Object> parameterMap = new LinkedHashMap<>();
        parameterMap.put("UserID", order.getUserID());
        parameterMap.put("TotalMoney", order.getTotalMoney());
        parameterMap.put("CreatedAt", order.getCreatedAt() != null ? Timestamp.valueOf(order.getCreatedAt()) : Timestamp.valueOf(LocalDateTime.now()));
        parameterMap.put("UpdatedAt", order.getUpdatedAt() != null ? Timestamp.valueOf(order.getUpdatedAt()) : Timestamp.valueOf(LocalDateTime.now()));
        parameterMap.put("CreatedBy", order.getCreatedBy());
        parameterMap.put("IsDelete", order.isIsDelete());
        parameterMap.put("DeletedBy", order.getDeletedBy());
        parameterMap.put("DeletedAt", order.getDeletedAt() != null ? Timestamp.valueOf(order.getDeletedAt()) : null);
        return insertGenericDAO(sql, parameterMap);
    }

    public List<Orders> findOrderByUserID(int userID) {
        List<Orders> orders = new ArrayList<>();
        String sql = "SELECT * FROM sold_card_system3.orders WHERE UserID = ? ORDER BY CreatedAt DESC";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Orders order = Orders.builder()
                        .ID(rs.getInt("ID"))
                        .UserID(rs.getInt("UserID"))
                        .TotalMoney(rs.getFloat("TotalMoney"))
                        .CreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime())
                        .UpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime())
                        .CreatedBy(rs.getInt("CreatedBy"))
                        .IsDelete(rs.getBoolean("IsDelete"))
                        .DeletedBy(rs.getInt("DeletedBy"))
                        .DeletedAt(rs.getTimestamp("DeletedAt") != null ? rs.getTimestamp("DeletedAt").toLocalDateTime() : null)
                        .build();
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }

        return orders;
    }

    public List<Orders> findOrdersByUserIDWithPagination(int userID, int pageNumber, int pageSize) {
        List<Orders> orders = new ArrayList<>();
        String sql = "SELECT * FROM sold_card_system3.orders WHERE UserID = ? ORDER BY CreatedAt DESC LIMIT ? OFFSET ?";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, pageSize);
            ps.setInt(3, (pageNumber - 1) * pageSize);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Orders order = Orders.builder()
                        .ID(rs.getInt("ID"))
                        .UserID(rs.getInt("UserID"))
                        .TotalMoney(rs.getFloat("TotalMoney"))
                        .CreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime())
                        .UpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime())
                        .CreatedBy(rs.getInt("CreatedBy"))
                        .IsDelete(rs.getBoolean("IsDelete"))
                        .DeletedBy(rs.getInt("DeletedBy"))
                        .DeletedAt(rs.getTimestamp("DeletedAt") != null ? rs.getTimestamp("DeletedAt").toLocalDateTime() : null)
                        .build();
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }

        return orders;
    }

    public int countOrdersByUserID(int userID) {
        String sql = "SELECT COUNT(*) FROM sold_card_system3.orders WHERE UserID = ?";
        int count = 0;

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }

        return count;
    }

    public List<Orders> findOrderByID(int orderID) {
        List<Orders> orders = new ArrayList<>();
        String sql = "SELECT * FROM sold_card_system3.orders WHERE ID = ? ORDER BY CreatedAt DESC";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Orders order = Orders.builder()
                        .ID(rs.getInt("ID"))
                        .UserID(rs.getInt("UserID"))
                        .TotalMoney(rs.getFloat("TotalMoney"))
                        .CreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime())
                        .UpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime())
                        .CreatedBy(rs.getInt("CreatedBy"))
                        .IsDelete(rs.getBoolean("IsDelete"))
                        .DeletedBy(rs.getInt("DeletedBy"))
                        .DeletedAt(rs.getTimestamp("DeletedAt") != null ? rs.getTimestamp("DeletedAt").toLocalDateTime() : null)
                        .build();
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }

        return orders;
    }

    public Orders findById(int id) {
        String sql = "SELECT * FROM sold_card_system3.orders WHERE ID = ?";
        Orders order = null;
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = Orders.builder()
                        .ID(rs.getInt("ID"))
                        .UserID(rs.getInt("UserID"))
                        .TotalMoney(rs.getFloat("TotalMoney"))
                        .CreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime())
                        .UpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime())
                        .CreatedBy(rs.getInt("CreatedBy"))
                        .IsDelete(rs.getBoolean("IsDelete"))
                        .DeletedBy(rs.getInt("DeletedBy"))
                        .DeletedAt(rs.getTimestamp("DeletedAt") != null ? rs.getTimestamp("DeletedAt").toLocalDateTime() : null)
                        .build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return order;
    }

    public List<OrderStatistics> getOrderStatistics(String startDate, String endDate, int offset, int limit) {
        List<OrderStatistics> statisticsList = new ArrayList<>();
        String sql = "SELECT DATE(CreatedAt) as order_date, SUM(TotalMoney) as revenue, COUNT(*) as orders_count FROM orders WHERE CreatedAt BETWEEN ? AND ? GROUP BY DATE(CreatedAt) ORDER BY DATE(CreatedAt) DESC LIMIT ? OFFSET ?";

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ps.setInt(3, limit);
            ps.setInt(4, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderStatistics stats = new OrderStatistics();
                    stats.setOrderDate(rs.getDate("order_date"));
                    stats.setRevenue(rs.getBigDecimal("revenue"));
                    stats.setOrdersCount(rs.getInt("orders_count"));
                    statisticsList.add(stats);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return statisticsList;
    }

    public int getNoOfRecords(String startDate, String endDate) {
        int noOfRecords = 0;
        String sql = "SELECT COUNT(DISTINCT DATE(CreatedAt)) as total FROM orders WHERE CreatedAt BETWEEN ? AND ?";

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    noOfRecords = rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return noOfRecords;
    }
    // Thêm phương thức getTopSellingProducts

    public List<Orders> findAllDesc() {
        List<Orders> orders = new ArrayList<>();
        String sql = "SELECT * FROM sold_card_system3.orders ORDER BY CreatedAt DESC";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Orders order = new Orders();
                order.setID(rs.getInt("ID"));
                order.setUserID(rs.getInt("UserID"));
                order.setTotalMoney(rs.getFloat("TotalMoney"));
                order.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                order.setUpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime());
                order.setCreatedBy(rs.getInt("CreatedBy"));
                order.setIsDelete(rs.getBoolean("IsDelete"));
                order.setDeletedBy(rs.getInt("DeletedBy"));
                order.setDeletedAt(rs.getTimestamp("DeletedAt") != null ? rs.getTimestamp("DeletedAt").toLocalDateTime() : null);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<UserOrderStatistics> getUserOrderStatistics(String startDate, String endDate, int offset, int limit) {
        List<UserOrderStatistics> userStatisticsList = new ArrayList<>();
        String sql = "SELECT u.username as user_name, COUNT(o.ID) as order_count, SUM(o.TotalMoney) as total_revenue "
                + "FROM orders o "
                + "JOIN users u ON o.UserID = u.ID "
                + "WHERE o.CreatedAt BETWEEN ? AND ? "
                + "GROUP BY u.username "
                + "ORDER BY order_count DESC "
                + "LIMIT ? OFFSET ?";

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ps.setInt(3, limit);
            ps.setInt(4, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserOrderStatistics stats = new UserOrderStatistics();
                    stats.setUserName(rs.getString("user_name"));
                    stats.setOrderCount(rs.getInt("order_count"));
                    stats.setTotalRevenue(rs.getBigDecimal("total_revenue"));
                    userStatisticsList.add(stats);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userStatisticsList;
    }

    public BigDecimal calculateTotalRevenue(String startDate, String endDate) {
        BigDecimal totalRevenue = BigDecimal.ZERO;
        String sql = "SELECT SUM(TotalMoney) AS total_revenue FROM orders WHERE CreatedAt BETWEEN ? AND ?";

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalRevenue = rs.getBigDecimal("total_revenue");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalRevenue;
    }

    public List<Orders> findOrdersByUserIDAndDateRange(int userID, LocalDate startDate, LocalDate endDate, int pageNumber, int pageSize) {
        List<Orders> orders = new ArrayList<>();
        String sql = "SELECT * FROM sold_card_system3.orders WHERE UserID = ? AND CreatedAt BETWEEN ? AND ? ORDER BY CreatedAt DESC LIMIT ? OFFSET ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setTimestamp(2, Timestamp.valueOf(startDate.atStartOfDay()));
            ps.setTimestamp(3, Timestamp.valueOf(endDate.atTime(23, 59, 59)));
            ps.setInt(4, pageSize);
            ps.setInt(5, (pageNumber - 1) * pageSize);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Orders order = Orders.builder()
                        .ID(rs.getInt("ID"))
                        .UserID(rs.getInt("UserID"))
                        .TotalMoney(rs.getFloat("TotalMoney"))
                        .CreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime())
                        .UpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime())
                        .CreatedBy(rs.getInt("CreatedBy"))
                        .IsDelete(rs.getBoolean("IsDelete"))
                        .DeletedBy(rs.getInt("DeletedBy"))
                        .DeletedAt(rs.getTimestamp("DeletedAt") != null ? rs.getTimestamp("DeletedAt").toLocalDateTime() : null)
                        .build();
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int countOrdersByUserIDAndDateRange(int userID, String startDate, String endDate) {
        String sql = "SELECT COUNT(*) FROM sold_card_system3.orders WHERE UserID = ? AND CreatedAt BETWEEN ? AND ?";
        int count = 0;

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setString(2, startDate + " 00:00:00");
            ps.setString(3, endDate + " 23:59:59");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }

        return count;
    }

    public List<Orders> getOrdersByUserID(int userID) {
        List<Orders> orders = new ArrayList<>();
        String sql = "SELECT * FROM sold_card_system3.orders WHERE UserID = ? ORDER BY CreatedAt DESC";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Orders order = Orders.builder()
                            .ID(rs.getInt("ID"))
                            .UserID(rs.getInt("UserID"))
                            .TotalMoney(rs.getFloat("TotalMoney"))
                            .CreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime())
                            .UpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime())
                            .CreatedBy(rs.getInt("CreatedBy"))
                            .IsDelete(rs.getBoolean("IsDelete"))
                            .DeletedBy(rs.getInt("DeletedBy"))
                            .DeletedAt(rs.getTimestamp("DeletedAt") != null ? rs.getTimestamp("DeletedAt").toLocalDateTime() : null)
                            .build();
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<String> getProductNamesByOrderID(int orderID) {
        List<String> productNames = new ArrayList<>();
        String sql = "SELECT ct.CardTypeName FROM cardtypes ct INNER JOIN orderdetails od ON ct.ID = od.cardID WHERE od.orderID = ?";

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    productNames.add(rs.getString("CardTypeName"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productNames;
    }
}
