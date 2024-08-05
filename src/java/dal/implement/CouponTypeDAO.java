/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.implement;

import dal.GenericDAO;
import entity.CouponType;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 *
 * @author FPTSHOP
 */
public class CouponTypeDAO extends GenericDAO<CouponType> {

    @Override
    public List<CouponType> findAll() {
        return queryGenericDAO(CouponType.class);
    }

    @Override
    public int insert(CouponType couponType) {
        String sql = "INSERT INTO CouponType (CouponTypeName, StartDate, EndDate, Status) VALUES (?, ?, ?, ?)";
        Map<String, Object> parameterMap = new LinkedHashMap<>();
        parameterMap.put("CouponTypeName", couponType.getCouponTypeName());
        parameterMap.put("StartDate", couponType.getStartDate());
        parameterMap.put("EndDate", couponType.getEndDate());
        parameterMap.put("Status", couponType.isStatus());

        return insertGenericDAO(sql, parameterMap);
    }

    public void updateCouponType(CouponType couponType) {
        String sql = "UPDATE CouponType SET CouponTypeName = ?, StartDate = ?, EndDate = ? WHERE ID = ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, couponType.getCouponTypeName());
            statement.setDate(2, couponType.getStartDate());
            statement.setDate(3, couponType.getEndDate());
            statement.setInt(4, couponType.getID());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteById(int ID) {
        String sql = "DELETE FROM coupontype WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, ID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateStatus(CouponType couponType) {
        String sql = "UPDATE CouponType SET Status = ? WHERE ID = ?";
        Map<String, Object> parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", couponType.isStatus());
        parameterMap.put("ID", couponType.getID());
        return updateGenericDAO(sql, parameterMap);
    }

    public static void main(String[] args) {
        CouponTypeDAO couponTypeDAO = new CouponTypeDAO();

        // Tạo một đối tượng CouponType để cập nhật
        CouponType couponType = new CouponType();
        couponType.setID(3);  // ID của CouponType cần cập nhật
        couponType.setStatus(false);  // Trạng thái mới cần cập nhật

        // Gọi hàm updateStatus để cập nhật trạng thái
        boolean result = couponTypeDAO.updateStatus(couponType);

        // Kiểm tra kết quả và in ra thông báo
        if (result) {
            System.out.println("Cập nhật trạng thái thành công.");
        } else {
            System.out.println("Cập nhật trạng thái thất bại.");
        }
    }

    public List<CouponType> findByIdOrName(String keyword) {
        List<CouponType> list = new ArrayList<>();
        String sql = "SELECT * FROM CouponType WHERE ID = ? OR CouponTypeName LIKE ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            try {
                int id = Integer.parseInt(keyword);
                statement.setInt(1, id);
            } catch (NumberFormatException e) {
                statement.setNull(1, java.sql.Types.INTEGER);
            }

            statement.setString(2, "%" + keyword + "%");

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    CouponType couponType = new CouponType();
                    couponType.setID(rs.getInt("ID"));
                    couponType.setCouponTypeName(rs.getString("CouponTypeName"));
                    list.add(couponType);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<CouponType> findAllDesc() {
        List<CouponType> list = new ArrayList<>();
        String sql = "SELECT * FROM CouponType ORDER BY ID DESC";
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                CouponType couponType = new CouponType();
                couponType.setID(rs.getInt("ID"));
                couponType.setCouponTypeName(rs.getString("CouponTypeName"));
                list.add(couponType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public CouponType getCouponTypeByID(int couponTypeID) {
        CouponType couponType = null;
        String sql = "SELECT * FROM CouponType WHERE ID = ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, couponTypeID);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    couponType = new CouponType();
                    couponType.setID(rs.getInt("ID"));
                    couponType.setCouponTypeName(rs.getString("CouponTypeName"));
                    couponType.setStartDate(rs.getDate("StartDate"));
                    couponType.setEndDate(rs.getDate("EndDate"));
                    couponType.setStatus(rs.getBoolean("Status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return couponType;
    }

}
