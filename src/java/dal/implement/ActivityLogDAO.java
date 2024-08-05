package dal.implement;

import dal.DBContext;
import entity.ActivityLog;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;

public class ActivityLogDAO {

    public void insertActivity(ActivityLog activityLog) {
        String sql = "INSERT INTO activity_log (userid, action, details) VALUES (?, ?, ?)";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, activityLog.getUserId());
            statement.setString(2, activityLog.getAction());
            statement.setString(3, activityLog.getDetails());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<ActivityLog> getActivityLogsByUserId(int userId) {
        String sql = "SELECT * FROM activity_log WHERE userid = ?";
        List<ActivityLog> activityLogs = new ArrayList<>();
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    ActivityLog activityLog = new ActivityLog();
                    activityLog.setId(resultSet.getInt("id"));
                    activityLog.setUserId(resultSet.getInt("userid"));
                    activityLog.setAction(resultSet.getString("action"));
                    activityLog.setTimestamp(resultSet.getTimestamp("timestamp").toLocalDateTime());
                    activityLog.setDetails(resultSet.getString("details"));
                    activityLogs.add(activityLog);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activityLogs;
    }

    public List<ActivityLog> getAllActivityLogs() {
        String sql = "SELECT a.id, a.userid, a.action, a.details, a.timestamp, u.username "
                + "FROM activity_log a JOIN users u ON a.userid = u.id";
        List<ActivityLog> activityLogs = new ArrayList<>();
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql); ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                ActivityLog activityLog = new ActivityLog();
                activityLog.setId(resultSet.getInt("id"));
                activityLog.setUserId(resultSet.getInt("userid"));
                activityLog.setAction(resultSet.getString("action"));
                activityLog.setTimestamp(resultSet.getTimestamp("timestamp").toLocalDateTime());
                activityLog.setDetails(resultSet.getString("details"));
                activityLog.setUsername(resultSet.getString("username")); // Ensure this method exists in ActivityLog
                activityLogs.add(activityLog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activityLogs;
    }

    public List<ActivityLog> getActivityLogsWithUsernames() {
        String sql = "SELECT a.id, a.userid, a.action, a.details, a.timestamp, u.username FROM activity_log a JOIN users u ON a.userid = u.id";
        List<ActivityLog> activityLogs = new ArrayList<>();
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql); ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                ActivityLog activityLog = new ActivityLog();
                activityLog.setId(resultSet.getInt("id"));
                activityLog.setUserId(resultSet.getInt("userid"));
                activityLog.setAction(resultSet.getString("action"));
                activityLog.setTimestamp(resultSet.getTimestamp("timestamp").toLocalDateTime());
                activityLog.setDetails(resultSet.getString("details"));
                activityLog.setUsername(resultSet.getString("username"));
                activityLogs.add(activityLog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activityLogs;
    }

    // Phương thức để lấy các hoạt động gần đây
    public List<ActivityLog> getRecentActivities(int userId, int minutes) {
        String sql = "SELECT * FROM activity_log WHERE userid = ? AND timestamp >= NOW() - INTERVAL ? MINUTE";
        List<ActivityLog> activityLogs = new ArrayList<>();
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            statement.setInt(2, minutes);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    ActivityLog activityLog = new ActivityLog();
                    activityLog.setId(resultSet.getInt("id"));
                    activityLog.setUserId(resultSet.getInt("userid"));
                    activityLog.setAction(resultSet.getString("action"));
                    activityLog.setTimestamp(resultSet.getTimestamp("timestamp").toLocalDateTime());
                    activityLog.setDetails(resultSet.getString("details"));
                    activityLogs.add(activityLog);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activityLogs;
    }
}
