package dal.implement;

import dal.DBContext;
import dal.GenericDAO;
import entity.Notification;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class NotificationDAO extends GenericDAO<Notification> {

    @Override
    public List<Notification> findAll() {
        return queryGenericDAO(Notification.class);
    }

    @Override
    public int insert(Notification notification) {
        String sql = "INSERT INTO notifications (UserID, message, created_at, forAllUsers) VALUES (?, ?, ?, ?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("UserID", notification.getUserID());
        parameterMap.put("message", notification.getMessage());
        parameterMap.put("created_at", notification.getCreatedAt());
        parameterMap.put("forAllUsers", notification.isForAllUsers());
        return insertGenericDAO(sql, parameterMap);
    }

    public List<Notification> findByUserId(int userId) {
        String sql = "SELECT * FROM notifications WHERE UserID = ? ORDER BY created_at DESC";
        List<Notification> list = new ArrayList<>();
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Notification notification = new Notification();
                    notification.setNotificationId(resultSet.getInt("notification_id"));
                    notification.setUserID(resultSet.getInt("UserID"));
                    notification.setMessage(resultSet.getString("message"));
                    notification.setRead(resultSet.getBoolean("read"));

                    Timestamp createdAt = resultSet.getTimestamp("created_at");
                    if (createdAt != null) {
                        notification.setCreatedAt(createdAt);
                    }

                    list.add(notification);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int updateNotificationStatus(int notificationId, boolean isRead) {

        String sql = String.format("UPDATE notifications SET `read` = %s WHERE notification_id = ?",
                isRead ? "1" : "0");
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, notificationId);
            return statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public static void main(String[] args) {
        System.out.println(new NotificationDAO().updateNotificationStatus(5, false));
    }

    public int markAllAsRead(int userId) {
        String sql = "UPDATE notifications SET `read` = 1 WHERE UserID = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            return statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public List<Notification> findAllGlobalNotifications(int page, int pageSize) {
        String sql = "SELECT * FROM notifications WHERE forAllUsers = TRUE ORDER BY created_at DESC LIMIT ?, ?";
        List<Notification> list = new ArrayList<>();
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, (page - 1) * pageSize);
            statement.setInt(2, pageSize);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Notification notification = new Notification();
                    notification.setNotificationId(resultSet.getInt("notification_id"));
                    notification.setUserID(resultSet.getInt("UserID"));
                    notification.setMessage(resultSet.getString("message"));
                    notification.setRead(resultSet.getBoolean("read"));
                    notification.setForAllUsers(resultSet.getBoolean("forAllUsers"));

                    Timestamp createdAt = resultSet.getTimestamp("created_at");
                    if (createdAt != null) {
                        notification.setCreatedAt(createdAt);
                    }

                    list.add(notification);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countGlobalNotifications() {
        String sql = "SELECT COUNT(*) AS total FROM notifications WHERE forAllUsers = TRUE";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean deleteNotification(int notificationId) {
        String sql = "DELETE FROM notifications WHERE notification_id = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, notificationId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int countUnreadNotifications(int userID) {
        String sql = "SELECT COUNT(*) AS unreadCount FROM notifications WHERE UserID = ? AND `read` = FALSE";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("unreadCount");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Notification> findByUserIdWithPagination(int userId, int offset, int limit) {
        String sql = "SELECT * FROM notifications WHERE UserID = ? OR forAllUsers = TRUE ORDER BY created_at DESC LIMIT ? OFFSET ?";
        List<Notification> list = new ArrayList<>();
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            statement.setInt(2, limit);
            statement.setInt(3, offset);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Notification notification = new Notification();
                    notification.setNotificationId(resultSet.getInt("notification_id"));
                    notification.setUserID(resultSet.getInt("UserID"));
                    notification.setMessage(resultSet.getString("message"));
                    notification.setRead(resultSet.getBoolean("read"));
                    notification.setForAllUsers(resultSet.getBoolean("forAllUsers"));
                    Timestamp createdAt = resultSet.getTimestamp("created_at");
                    if (createdAt != null) {
                        notification.setCreatedAt(createdAt);
                    }
                    list.add(notification);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countNotificationsByUserId(int userId) {
        String sql = "SELECT COUNT(*) AS totalCount FROM notifications WHERE UserID = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("totalCount");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean addNotification(Notification notification) {
        return insert(notification) > 0;
    }
}
