/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.implement;

import dal.DBContext;
import dal.GenericDAO;
import entity.Slider;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Tom
 */
public class SliderDAO extends GenericDAO<Slider> {

    @Override
    public List<Slider> findAll() {
        return queryGenericDAO(Slider.class);
    }

    @Override
    public int insert(Slider t) {
        String sql = "INSERT INTO `slider`\n"
                + "(`Image`,\n"
                + "`CreatedAt`,\n"
                + "`UpdatedAt`,\n"
                + "`Status`)\n"
                + "VALUES\n"
                + "(?,?,?,?);";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("1", t.getImage());
        parameterMap.put("2", t.getCreatedAt());
        parameterMap.put("3", t.getUpdatedAt());
        parameterMap.put("4", t.isStatus());
        return insertGenericDAO(sql, parameterMap);
    }

    public List<Slider> findAllDesc() {
        List<Slider> list = new ArrayList<>();
        connection = new DBContext().getConnection();
        String query = "SELECT * \n"
                + "FROM slider\n"
                + "ORDER BY ID DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Slider(rs.getInt("ID"),
                        rs.getString("Image"),
                        rs.getDate("CreatedAt"),
                        rs.getDate("UpdatedAt"),
                        rs.getBoolean("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Slider> findAllDescButHide() {
        List<Slider> list = new ArrayList<>();
        connection = new DBContext().getConnection();
        String query = "SELECT * \n"
                + "FROM slider\n"
                + "Where Status = 1\n"
                + "ORDER BY ID DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Slider(rs.getInt("ID"),
                        rs.getString("Image"),
                        rs.getDate("CreatedAt"),
                        rs.getDate("UpdatedAt"),
                        rs.getBoolean("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void update(Slider slider) {
        String sql = "UPDATE `slider`\n"
                + "SET\n"
                + "`Image` = ?,\n"
                + "`UpdatedAt` = ?\n"
                + "WHERE `ID` = ? ;";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("image", slider.getImage());
        parameterMap.put("updateAt", slider.getUpdatedAt());
        parameterMap.put("ID", slider.getID());
        updateGenericDAO(sql, parameterMap);
    }

    public boolean updateContent(Slider t) {
        String sql = "UPDATE `slider`\n"
                + "`Image` = ?\n"
                + "WHERE `ID` = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("3", t.getImage());
        parameterMap.put("4", t.getID());
        return updateGenericDAO(sql, parameterMap);
    }

    public boolean updateStatus(Slider t) {
        String sql = "UPDATE `slider`\n"
                + "SET `Status` = ?\n"
                + "WHERE `ID` = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("status", t.isStatus());
        parameterMap.put("ID", t.getID());
        return updateGenericDAO(sql, parameterMap);
    }

    public int countByStatus(boolean status) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM slider WHERE Status = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBoolean(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Slider> findByStatus(boolean status) {
        List<Slider> list = new ArrayList<>();
        String query = "SELECT * FROM slider WHERE Status = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setBoolean(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Slider(rs.getInt("ID"),
                        rs.getString("Image"),
                        rs.getDate("CreatedAt"),
                        rs.getDate("UpdatedAt"),
                        rs.getBoolean("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Slider findById(String id) {
        String sql = "SELECT `ID`,\n"
                + "    `Image`,\n"
                + "    `CreatedAt`,\n"
                + "    `UpdatedAt`,\n"
                + "    `Status`\n"
                + "FROM `slider`\n"
                + "WHERE ID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("ID", id);
        List<Slider> list = queryGenericDAO(Slider.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    public void deleteById(int id) {
        String sql = "DELETE FROM slider WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
