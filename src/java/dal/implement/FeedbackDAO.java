package dal.implement;

import dal.GenericDAO;
import entity.Feedback;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO extends GenericDAO<Feedback> {

    @Override
    public int insert(Feedback feedback) {
        // Kiểm tra sự tồn tại của user_id trước khi chèn
        if (!doesUserExist(feedback.getUser_id())) {
            throw new IllegalArgumentException("User ID không tồn tại: " + feedback.getUser_id());
        }

        String sql = "INSERT INTO feedback (name, phone, message, created_at, user_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, feedback.getName());
            statement.setString(2, feedback.getPhone());
            statement.setString(3, feedback.getMessage());
            statement.setTimestamp(4, feedback.getCreated_at());
            statement.setInt(5, feedback.getUser_id());
            return statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<Feedback> findAll() {
        String sql = "SELECT * FROM feedback";
        List<Feedback> feedbacks = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Feedback feedback = Feedback.builder()
                        .id(rs.getInt("id"))
                        .name(rs.getString("name"))
                        .phone(rs.getString("phone"))
                        .message(rs.getString("message"))
                        .created_at(rs.getTimestamp("created_at"))
                        .user_id(rs.getInt("user_id"))
                        .is_resolved(rs.getBoolean("is_resolved"))
                        .build();
                feedbacks.add(feedback);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedbacks;
    }

    public List<Feedback> findAllWithUserDetails() {
        String sql = "SELECT f.id, f.name, f.phone, f.message, f.created_at, f.is_resolved, u.Email as email "
                + "FROM feedback f LEFT JOIN users u ON f.user_id = u.ID";
        List<Feedback> feedbacks = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Feedback feedback = Feedback.builder()
                        .id(rs.getInt("id"))
                        .name(rs.getString("name"))
                        .phone(rs.getString("phone"))
                        .message(rs.getString("message"))
                        .created_at(rs.getTimestamp("created_at"))
//                        .user_id(rs.getInt("user_id")) 
                        .is_resolved(rs.getBoolean("is_resolved"))
                        .email(rs.getString("email"))
                        .build();
                feedbacks.add(feedback);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedbacks;
    }

    public boolean markAsResolved(int feedbackId) {
        String sql = "UPDATE feedback SET is_resolved = TRUE WHERE id = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, feedbackId);
            return statement.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean doesUserExist(int userId) {
        String sql = "SELECT COUNT(*) FROM users WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
