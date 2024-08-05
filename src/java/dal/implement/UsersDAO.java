package dal.implement;

import dal.GenericDAO;
import java.util.List;
import entity.Users;
import java.util.LinkedHashMap;
import java.sql.*;
import dal.DBContext;
import java.time.LocalDateTime;
import java.util.ArrayList;

/**
 *
 * @author Tom
 */
public class UsersDAO extends GenericDAO<Users> {

    Connection conn = null;
    PreparedStatement ps = null;

    @Override
    public List<Users> findAll() {
        return queryGenericDAO(Users.class);
    }

    public static void main(String[] args) {
        UsersDAO usersDAO = new UsersDAO();
        List<Users> usersList = usersDAO.findByNameOrEmail("user13@example.com");
        for (Users user : usersList) {
            System.out.println(user);
        }
    }

    @Override
    public int insert(Users t) {
        String sql = "INSERT INTO sold_card_system3.users ("
                + "UserName, "
                + "Email, "
                + "RoleID, "
                + "PasswordHash, "
                + "CreatedAt, "
                + "UpdatedAt, "
                + "IsDelete, "
                + "DeletedAt, "
                + "Status, "
                + "Gender, "
                + "DateOfBirth, "
                + "profilePicture) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", t.getUserName());
        parameterMap.put("email", t.getEmail());
        parameterMap.put("roleid", 2);
        parameterMap.put("password", t.getPasswordHash());
        parameterMap.put("createat", Timestamp.valueOf(LocalDateTime.now()));
        parameterMap.put("updateat", t.getUpdatedAt());
        parameterMap.put("isdelete", t.isIsDelete());
        parameterMap.put("deleteat", t.getDeletedAt());
        parameterMap.put("status", t.isStatus());
        parameterMap.put("gender", t.getGender());
        parameterMap.put("dateofbirth", t.getDateOfBirth());
        parameterMap.put("profilePicture", t.getProfilePicture());
        return insertGenericDAO(sql, parameterMap);
    }

    public boolean checkUsernameExist(Users users) {
        String sql = "SELECT * FROM Users WHERE UserName = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", users.getUserName());
        return !queryGenericDAO(Users.class, sql, parameterMap).isEmpty();
    }

    public Users findByUsernameAndPass(Users users) {
        String sql = "SELECT * FROM Users WHERE UserName = ? AND PasswordHash = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", users.getUserName());
        parameterMap.put("password", users.getPasswordHash());
        List<Users> list = queryGenericDAO(Users.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    public boolean checkEmailExist(Users users) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("email", users.getEmail());
        return !queryGenericDAO(Users.class, sql, parameterMap).isEmpty();
    }

    public boolean updateUserProfile(String currentUsername, String gender, Date dateOfBirth) throws SQLException {
        String query = "UPDATE Users SET ";
        List<Object> parameters = new ArrayList<>();

        if (gender != null) {
            query += "Gender = ?, ";
            parameters.add(gender);
        }

        if (dateOfBirth != null) {
            query += "DateOfBirth = ?, ";
            parameters.add(new java.sql.Date(dateOfBirth.getTime()));
        }

        // Remove the last comma and space
        query = query.substring(0, query.length() - 2);

        query += " WHERE UserName = ?";
        parameters.add(currentUsername);

        conn = new DBContext().getConnection();
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            // Set parameters dynamically based on the constructed query
            for (int i = 0; i < parameters.size(); i++) {
                Object param = parameters.get(i);
                if (param instanceof String) {
                    ps.setString(i + 1, (String) param);
                } else if (param instanceof java.sql.Date) {
                    ps.setDate(i + 1, (java.sql.Date) param);
                }
            }

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } finally {
            // Close resources in finally block
            if (conn != null) {
                conn.close();
            }
        }
    }

    public boolean updateStatus(Users user) {
        String sql = "UPDATE Users SET Status = ? WHERE ID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("status", user.isStatus());
        parameterMap.put("ID", user.getID());
        return updateGenericDAO(sql, parameterMap);
    }

    public boolean updatePassword(String email, String newpassword) {
        String sql = "UPDATE Users SET PasswordHash = ?, UpdatedAt = ? WHERE Email = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("passwordhash", newpassword);
        parameterMap.put("UpdatedAt", Timestamp.valueOf(LocalDateTime.now()));
        parameterMap.put("Email", email);
        return updateGenericDAO(sql, parameterMap);
    }

    public Users getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("email", email);
        List<Users> list = queryGenericDAO(Users.class, sql, parameterMap);

        return list.isEmpty()
                ? null
                : list.get(0);
    }

    public boolean updateProfilePicture(String email, String profilePicturePath) {
        String sql = "UPDATE Users SET profilePicture = ? WHERE Email = ?";

        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, profilePicturePath);
            statement.setString(2, email);

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void deleteById(int id) {
        String sql = "DELETE FROM Users WHERE id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("id", id);
        deleteGenericDAO(sql, parameterMap);
    }

    public boolean checkOldPasswordExist(String oldPassword) {
        String sql = "SELECT * FROM Users WHERE PasswordHash = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("passwordhash ", oldPassword);
        return !queryGenericDAO(Users.class, sql, parameterMap).isEmpty();
    }

    public void updateProfile(Users users) {
        String sql = "UPDATE Users SET email = ? WHERE username = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, users.getEmail());
            statement.setString(4, users.getUserName());
            statement.executeUpdate();
        } catch (Exception e) {
            System.err.println("Error " + e.getMessage() + " at updateProfile");
        } finally {
            try {
                connection.close();
                statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public List<Users> findByNameOrEmail(String keyword) {
        String sql = "SELECT * FROM Users WHERE UserName LIKE ? OR Email LIKE ?";
        parameterMap = new LinkedHashMap<>();
        String searchPattern = "%" + keyword + "%";
        parameterMap.put("UserName", searchPattern);
        parameterMap.put("Email", searchPattern);
        return queryGenericDAO(Users.class, sql, parameterMap);
    }

    public Users getUserByUsername(String username) {
        String sql = "SELECT * FROM users where UserName = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", username);
        List<Users> list = queryGenericDAO(Users.class, sql, parameterMap);

        return list.isEmpty() ? null : list.get(0);
    }

    public Users findById(int userId) {
        String sql = "SELECT * FROM Users WHERE ID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("ID", userId);
        List<Users> list = queryGenericDAO(Users.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    public List<Users> searchByName(String name) {
        String sql = "SELECT * FROM Users WHERE UserName LIKE ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("UserName", "%" + name + "%");
        return queryGenericDAO(Users.class, sql, parameterMap);
    }

    public Integer findUserIdByUsername(String username) {
        String sql = "SELECT ID FROM Users WHERE UserName = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("ID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String findEmailByUserId(int userId) {
        String sql = "SELECT Email FROM Users WHERE ID = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("Email");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
