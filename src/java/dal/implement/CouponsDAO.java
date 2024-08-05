package dal.implement;

import dal.GenericDAO;
import entity.Coupons;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CouponsDAO extends GenericDAO<Coupons> {

    @Override
    public List<Coupons> findAll() {
        return queryGenericDAO(Coupons.class);
    }

    @Override
    public int insert(Coupons coupon) {
        String sql = "INSERT INTO coupons (CouponCode, CouponAmount, CouponTypeID, usageCount) VALUES (?, ?, ?, ?)";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, coupon.getCouponCode());
            statement.setInt(2, coupon.getCouponAmount());
            statement.setInt(3, coupon.getCouponTypeID());
            statement.setInt(4, coupon.getUsageCount());
            return statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public void deleteById(int ID) {
        String sql = "DELETE FROM coupons WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, ID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        CouponsDAO couponsDAO = new CouponsDAO();
        couponsDAO.findAll();
        System.out.println(couponsDAO);
    }

    public boolean couponCodeExists(String couponCode) {
        String sql = "SELECT COUNT(*) FROM coupons WHERE CouponCode = ?";
        boolean exists = false;

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, couponCode);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    exists = resultSet.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }

    public List<Coupons> searchCouponsByKeyword(String keyword) {
        List<Coupons> coupons = new ArrayList<>();
        String sql = "SELECT c.*\n"
                + "FROM \n"
                + "	coupons as c,\n"
                + "    coupontype as ct\n"
                + "where\n"
                + "	c.CouponTypeID = ct.ID\n"
                + "    AND (c.ID LIKE ? \n"
                + "    OR ct.CouponTypeName LIKE ?\n"
                + "    OR c.CouponCode LIKE ?\n"
                + "    or c.CouponAmount LIKE ?)";

        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {
            String queryKeyword = "%" + keyword + "%";
            ps.setString(1, queryKeyword);
            ps.setString(2, queryKeyword);
            ps.setString(3, queryKeyword);
            ps.setString(4, queryKeyword);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Coupons coupon = new Coupons();
                    coupon.setID(rs.getInt("ID"));
                    coupon.setCouponTypeID(rs.getInt("CouponTypeID"));
                    coupon.setCouponCode(rs.getString("CouponCode"));
                    coupon.setCouponAmount(rs.getInt("CouponAmount"));
                    coupon.setUsageCount(rs.getInt("usageCount"));
                    coupons.add(coupon);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return coupons;
    }

    public int update(Coupons coupon) {
        String sql = "UPDATE coupons SET CouponCode = ?, CouponAmount = ?, CouponTypeID = ?, usageCount = ? WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, coupon.getCouponCode());
            statement.setInt(2, coupon.getCouponAmount());
            statement.setInt(3, coupon.getCouponTypeID());
            statement.setInt(4, coupon.getUsageCount());
            statement.setInt(5, coupon.getID());
            return statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public Coupons getCouponByCode(String couponCode) {
        String sql = "SELECT * FROM coupons WHERE CouponCode = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, couponCode);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Coupons coupon = new Coupons();
                    coupon.setID(resultSet.getInt("ID"));
                    coupon.setCouponCode(resultSet.getString("CouponCode"));
                    coupon.setCouponAmount(resultSet.getInt("CouponAmount"));
                    coupon.setCouponTypeID(resultSet.getInt("CouponTypeID"));
                    coupon.setUsageCount(resultSet.getInt("usageCount"));
                    return coupon;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void decrementUsageCount(int couponId) {
        String sql = "UPDATE coupons SET usageCount = usageCount - 1 WHERE ID = ? AND usageCount > 0";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, couponId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Coupons> findAllDesc() {
        List<Coupons> list = new ArrayList<>();
        String sql = "SELECT * FROM coupons ORDER BY ID DESC";
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Coupons coupon = new Coupons();
                coupon.setID(rs.getInt("ID"));
                coupon.setCouponCode(rs.getString("CouponCode"));
                coupon.setCouponAmount(rs.getInt("CouponAmount"));
                coupon.setCouponTypeID(rs.getInt("CouponTypeID"));
                list.add(coupon);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
