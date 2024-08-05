package dal.implement;

import dal.DBContext;
import dal.GenericDAO;
import entity.Review;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReviewDAO extends GenericDAO<Review> {

    @Override
    public List<Review> findAll() {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT * FROM reviews ORDER BY CreatedAt DESC";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql); ResultSet rs = statement.executeQuery()) {
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

    public double getAverageRatingByOrderID(int orderId) {
        String sql = "SELECT AVG(Rating) AS AvgRating FROM reviews WHERE OrderID IN (SELECT OrderID FROM orderdetails WHERE CardID IN (SELECT CardID FROM orderdetails WHERE OrderID = ?))";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, orderId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("AvgRating");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalReviewsByOrderID(int orderId) {
        String sql = "SELECT COUNT(*) AS TotalReviews FROM reviews WHERE OrderID IN (SELECT OrderID FROM orderdetails WHERE CardID IN (SELECT CardID FROM orderdetails WHERE OrderID = ?))";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, orderId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("TotalReviews");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

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

    public void addReview(Review review) {
        String sql = "INSERT INTO reviews (UserID, OrderID, Rating, Title, CreatedAt, UpdatedAt) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, review.getUserID());
            statement.setInt(2, review.getOrderID());
            statement.setInt(3, review.getRating());
            statement.setString(4, review.getTitle());
            statement.setTimestamp(5, java.sql.Timestamp.valueOf(review.getCreatedAt()));
            statement.setTimestamp(6, java.sql.Timestamp.valueOf(review.getUpdatedAt()));
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Map<Integer, Integer> getRatingCountByOrderID(int orderId) {
        String sql = "SELECT Rating, COUNT(*) AS Count FROM reviews WHERE OrderID = ? GROUP BY Rating";
        Map<Integer, Integer> ratingCountMap = new HashMap<>();
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, orderId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    ratingCountMap.put(rs.getInt("Rating"), rs.getInt("Count"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ratingCountMap;
    }

    @Override
    public int insert(Review t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
