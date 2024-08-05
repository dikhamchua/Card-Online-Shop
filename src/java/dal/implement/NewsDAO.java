/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.implement;

import dal.DBContext;
import dal.GenericDAO;
import entity.News;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;

/**
 *
 * @author Tom
 */
public class NewsDAO extends GenericDAO<News> {

    @Override
    public List<News> findAll() {
        return queryGenericDAO(News.class);
    }

    public List<News> searchByTitle(String keyword) {
        String sql = "SELECT * FROM News WHERE Title LIKE ? ";
        parameterMap = new LinkedHashMap<>();
        String searchPattern = "%" + keyword + "%";
        parameterMap.put("Title", searchPattern);
        return queryGenericDAO(News.class, sql, parameterMap);
    }

    @Override
    public int insert(News t) {
        String sql = "INSERT INTO `news`\n"
                + "(`UserID`,\n"
                + "`Title`,\n"
                + "`Content`,\n"
                + "`Image`,\n"
                + "`CreatedAt`,\n"
                + "`UpdatedAt`,\n"
                + "`Status`)\n"
                + "VALUES\n"
                + "(?,?,?,?,?,?,?);\n"
                + "";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("1", t.getUserID());
        parameterMap.put("2", t.getTitle());
        parameterMap.put("3", t.getContent());
        parameterMap.put("4", t.getImage());
        parameterMap.put("5", t.getCreatedAt());
        parameterMap.put("6", t.getUpdatedAt());
        parameterMap.put("7", t.isStatus());
        return insertGenericDAO(sql, parameterMap);
    }

    public List<News> findAllDescButHide() {
        List<News> list = new ArrayList<>();
        connection = new DBContext().getConnection();
        String query = "SELECT * \n"
                + "FROM news\n"
                + "Where Status = 1\n"
                + "ORDER BY ID DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new News(rs.getInt("ID"),
                        rs.getInt("UserID"),
                        rs.getString("Title"),
                        rs.getString("Content"),
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

    public List<News> findAllDesc() {
        List<News> list = new ArrayList<>();
        connection = new DBContext().getConnection();
        String query = "SELECT * \n"
                + "FROM news\n"
                + "ORDER BY ID DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new News(rs.getInt("ID"),
                        rs.getInt("UserID"),
                        rs.getString("Title"),
                        rs.getString("Content"),
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

    public boolean updateContent(News t) {
        String sql = "UPDATE `news`\n"
                + "SET `Title` = ?,\n"
                + "`Content` = ?,\n"
                + "`Image` = ?\n"
                + "WHERE `ID` = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("1", t.getTitle());
        parameterMap.put("2", t.getContent());
        parameterMap.put("3", t.getImage());
        parameterMap.put("4", t.getID());
        return updateGenericDAO(sql, parameterMap);
    }

    public boolean updateStatus(News t) {
        String sql = "UPDATE `news`\n"
                + "SET `Status` = ?\n"
                + "WHERE `ID` = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("status", t.isStatus());
        parameterMap.put("ID", t.getID());
        return updateGenericDAO(sql, parameterMap);
    }

    public List<News> searchByName(String name) {
        String sql = "SELECT * FROM News WHERE Title LIKE ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Content", "%" + name + "%");
        return queryGenericDAO(News.class, sql, parameterMap);
    }

    public News findById(String id) {
        String sql = "SELECT `ID`,\n"
                + "    `UserID`,\n"
                + "    `Title`,\n"
                + "    `Content`,\n"
                + "    `Image`,\n"
                + "    `CreatedAt`,\n"
                + "    `UpdatedAt`,\n"
                + "    `Status`\n"
                + "FROM `news`\n"
                + "WHERE ID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("ID", id);
        List<News> list = queryGenericDAO(News.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    public static void main(String[] args) {
        System.out.println(new NewsDAO().findById("1"));
    }

    public void update(News news) {
        String sql = "UPDATE `news`\n"
                + "SET\n"
                + "`Title` = ?,\n"
                + "`Content` = ?,\n"
                + "`Image` = ?,\n"
                + "`UpdatedAt` = ?\n"
                + "WHERE `ID` = ? ;";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("title", news.getTitle());
        parameterMap.put("content", news.getContent());
        parameterMap.put("image", news.getImage());
        parameterMap.put("updateAt", news.getUpdatedAt());
        parameterMap.put("ID", news.getID());
        updateGenericDAO(sql, parameterMap);
    }

    public int countByStatus(boolean status) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM news WHERE Status = ?";
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

    public List<News> findByStatus(boolean status) {
        List<News> list = new ArrayList<>();
        String query = "SELECT * FROM news WHERE Status = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setBoolean(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new News(rs.getInt("ID"),
                        rs.getInt("UserID"),
                        rs.getString("Title"),
                        rs.getString("Content"),
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

    public void deleteById(int id) {
        String sql = "DELETE FROM news WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
