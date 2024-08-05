package dal.implement;

import dal.DBContext;
import entity.Review;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class HistoryReviewDAO {

    private int noOfRecords;

    public List<Review> getReviewsByUserID(int userID) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE UserID = ? ORDER BY CreatedAt DESC";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Review review = Review.builder()
                        .id(rs.getInt("ID"))
                        .userID(rs.getInt("UserID"))
                        .orderID(rs.getInt("OrderID"))
                        .rating(rs.getInt("Rating"))
                        .title(rs.getString("Title"))
                        .createdAt(rs.getTimestamp("CreatedAt").toLocalDateTime())
                        .updatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime())
                        .build();
                list.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Review> getReviewsByUserID(int userID, int offset, int noOfRecords) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS * FROM reviews WHERE UserID = ? ORDER BY CreatedAt DESC LIMIT ?, ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userID);
            statement.setInt(2, offset);
            statement.setInt(3, noOfRecords);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Review review = Review.builder()
                        .id(rs.getInt("ID"))
                        .userID(rs.getInt("UserID"))
                        .orderID(rs.getInt("OrderID"))
                        .rating(rs.getInt("Rating"))
                        .title(rs.getString("Title"))
                        .createdAt(rs.getTimestamp("CreatedAt").toLocalDateTime())
                        .updatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime())
                        .build();
                list.add(review);
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

    public List<Review> getReviewsByUserIDAndDateRange(int userID, int offset, int noOfRecords, LocalDateTime startDate, LocalDateTime endDate) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS * FROM reviews WHERE UserID = ?";

        if (startDate != null) {
            sql += " AND CreatedAt >= ?";
        }
        if (endDate != null) {
            sql += " AND CreatedAt <= ?";
        }

        sql += " ORDER BY CreatedAt DESC LIMIT ?, ?";

        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            statement.setInt(paramIndex++, userID);
            if (startDate != null) {
                statement.setTimestamp(paramIndex++, Timestamp.valueOf(startDate));
            }
            if (endDate != null) {
                statement.setTimestamp(paramIndex++, Timestamp.valueOf(endDate));
            }
            statement.setInt(paramIndex++, offset);
            statement.setInt(paramIndex, noOfRecords);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Review review = Review.builder()
                        .id(rs.getInt("ID"))
                        .userID(rs.getInt("UserID"))
                        .orderID(rs.getInt("OrderID"))
                        .rating(rs.getInt("Rating"))
                        .title(rs.getString("Title"))
                        .createdAt(rs.getTimestamp("CreatedAt").toLocalDateTime())
                        .updatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime())
                        .build();
                list.add(review);
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

    public Review getReviewById(int reviewId) {
        String sql = "SELECT * FROM reviews WHERE ID = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, reviewId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return Review.builder()
                        .id(rs.getInt("ID"))
                        .userID(rs.getInt("UserID"))
                        .orderID(rs.getInt("OrderID"))
                        .rating(rs.getInt("Rating"))
                        .title(rs.getString("Title"))
                        .createdAt(rs.getTimestamp("CreatedAt").toLocalDateTime())
                        .updatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime())
                        .build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateReview(Review review) {
        String sql = "UPDATE reviews SET Rating = ?, Title = ?, UpdatedAt = ? WHERE ID = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, review.getRating());
            statement.setString(2, review.getTitle());
            statement.setTimestamp(3, Timestamp.valueOf(review.getUpdatedAt()));
            statement.setInt(4, review.getId());
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteReview(int reviewId) {
        String sql = "DELETE FROM reviews WHERE ID = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, reviewId);
            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
