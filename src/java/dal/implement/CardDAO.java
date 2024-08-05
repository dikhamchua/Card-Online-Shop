package dal.implement;

import dal.GenericDAO;
import entity.Cards;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

public class CardDAO extends GenericDAO<Cards> {

    public int getQuantity;

    @Override
    public List<Cards> findAll() {
        return queryGenericDAO(Cards.class);
    }

    @Override
    public int insert(Cards t) {
        String sql = "INSERT INTO Cards (CardCode, SerialNumber, CardType_Price, Status, ExpirationDate) VALUES (?, ?, ?, ?,?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("CardCode", t.getCardCode());
        parameterMap.put("SerialNumber", t.getSerialNumber());
        parameterMap.put("CardType_Price", t.getCardType_Price());
        parameterMap.put("Status", "Available");
        parameterMap.put("ExpirationDate", t.getExpirationDate());

        return insertGenericDAO(sql, parameterMap);
    }

    public void deleteById(int ID) {
        String sql = "DELETE FROM Cards WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, ID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Cards cards) {
        String sql = "UPDATE Cards SET CardCode = ?, SerialNumber = ?, CardType_Price = ?, Status = ? WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, cards.getCardCode());
            statement.setString(2, cards.getSerialNumber());
            statement.setInt(3, cards.getCardType_Price());
            statement.setString(4, cards.getStatus());
            statement.setInt(5, cards.getID());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean serialNumberExists(String serialNumber) {
        String sql = "SELECT COUNT(*) FROM Cards WHERE SerialNumber = ?";
        boolean exists = false;

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, serialNumber);
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

//    public List<CardDisplayDTO> getCardsByType(String cardTypeName) {
//        List<CardDisplayDTO> cards = new ArrayList<>();
//        String sql = "SELECT c.ID, c.CardCode, ct.CardTypeName, p.Price, ctp.ImageDetail " +
//                     "FROM Cards c " +
//                     "JOIN CardType_Price ctp ON c.CardType_Price = ctp.ID " +
//                     "JOIN CardTypes ct ON ctp.CardTypeID = ct.ID " +
//                     "JOIN Price p ON ctp.PriceID = p.ID " +
//                     "WHERE ct.CardTypeName = ? AND c.IsDelete = 0 AND c.Status = 'available'";
//        
//        try (Connection conn = getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            
//            stmt.setString(1, cardTypeName);
//            ResultSet rs = stmt.executeQuery();
//            
//            while (rs.next()) {
//                CardDisplayDTO card = new CardDisplayDTO();
//                card.setId(rs.getInt("ID"));
//                card.setCardCode(rs.getString("CardCode"));
//                card.setCardTypeName(rs.getString("CardTypeName"));
//                card.setPrice(rs.getDouble("Price"));
//                card.setImage(rs.getString("ImageDetail"));
//                
//                cards.add(card);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        
//        return cards;
//        return null;
//        List<CardDisplayDTO> cards = new ArrayList<>();
//        String sql = "SELECT c.ID, c.CardCode, ct.CardTypeName, p.Price, ctp.ImageDetail " +
//                     "FROM Cards c " +
//                     "JOIN CardType_Price ctp ON c.CardType_Price = ctp.ID " +
//                     "JOIN CardTypes ct ON ctp.CardTypeID = ct.ID " +
//                     "JOIN Price p ON ctp.PriceID = p.ID " +
//                     "WHERE ct.CardTypeName = ? AND c.IsDelete = 0 AND c.Status = 'available'";
//        
//        try (Connection conn = getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            
//            stmt.setString(1, cardTypeName);
//            ResultSet rs = stmt.executeQuery();
//            
//            while (rs.next()) {
//                CardDisplayDTO card = new CardDisplayDTO();
//                card.setId(rs.getInt("ID"));
//                card.setCardCode(rs.getString("CardCode"));
//                card.setCardTypeName(rs.getString("CardTypeName"));
//                card.setPrice(rs.getDouble("Price"));
//                card.setImage(rs.getString("ImageDetail"));
//                
//                cards.add(card);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        
//        return cards;
//    }
    public static void main(String[] args) {
        System.out.println(new CardDAO().findAllDesc());
    }

    public int getQuantityByCardTypeId(int cardTypeId) {
        int quantity = 0; // Khởi tạo biến đếm
        String sql = "SELECT COUNT(*) AS Quantity FROM Cards WHERE CardType_Price = ? and status = 'available'";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection(); // Gọi phương thức getConnection() để lấy kết nối đến DB
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cardTypeId); // Thiết lập giá trị cho tham số truy vấn
            rs = ps.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("Quantity"); // Đọc và gán giá trị số lượng từ kết quả truy vấn
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return quantity; // Trả về số lượng
    }

    public List<Cards> findByKeyword(String keyword) {
        List<Cards> cardsList = new ArrayList<>();
        String sql = "SELECT c.*, ct.CardTypeName, p.Price "
                + "FROM Cards c "
                + "JOIN CardType_Price ctp ON c.CardType_Price = ctp.ID "
                + "JOIN CardTypes ct ON ctp.CardTypeID = ct.ID "
                + "JOIN Price p ON ctp.PriceID = p.ID "
                + "WHERE c.CardCode LIKE ? OR c.SerialNumber LIKE ? OR ct.CardTypeName LIKE ? OR p.Price LIKE ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + keyword + "%");
            statement.setString(2, "%" + keyword + "%");
            statement.setString(3, "%" + keyword + "%");
            statement.setString(4, "%" + keyword + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Cards card = new Cards();
                    card.setID(resultSet.getInt("ID"));
                    card.setCardCode(resultSet.getString("CardCode"));
                    card.setSerialNumber(resultSet.getString("SerialNumber"));
                    card.setCardType_Price(resultSet.getInt("CardType_Price"));
                    card.setStatus(resultSet.getString("Status"));
                    cardsList.add(card);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cardsList;
    }

    public List<Cards> getAvailableCardsByCardTypeId(int cardTypeId) {
        String sql = "SELECT * FROM Cards WHERE CardType_Price = ? AND Status = 'Available'";
        List<Cards> cardsList = new ArrayList<>();

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cardTypeId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Cards card = new Cards();
                    card.setID(resultSet.getInt("ID"));
                    card.setCardCode(resultSet.getString("CardCode"));
                    card.setSerialNumber(resultSet.getString("SerialNumber"));
                    card.setCardType_Price(resultSet.getInt("CardType_Price"));
                    card.setStatus(resultSet.getString("Status"));
                    cardsList.add(card);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cardsList;
    }

    public Cards findById(int id) {
        String sql = "SELECT * FROM Cards WHERE ID = ?";
        Cards card = null;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    card = new Cards();
                    card.setID(resultSet.getInt("ID"));
                    card.setCardCode(resultSet.getString("CardCode"));
                    card.setSerialNumber(resultSet.getString("SerialNumber"));
                    card.setCardType_Price(resultSet.getInt("CardType_Price"));
                    card.setExpirationDate(resultSet.getDate("ExpirationDate"));
                    card.setCreatedAt(resultSet.getTimestamp("CreatedAt").toLocalDateTime());
                    card.setUpdatedAt(resultSet.getTimestamp("UpdatedAt").toLocalDateTime());
                    card.setCreatedBy(resultSet.getInt("CreatedBy"));
                    card.setIsDelete(resultSet.getBoolean("IsDelete"));
                    card.setDeletedBy(resultSet.getInt("DeletedBy"));
                    card.setDeletedAt(resultSet.getTimestamp("DeletedAt") != null ? resultSet.getTimestamp("DeletedAt").toLocalDateTime() : null);
                    card.setStatus(resultSet.getString("Status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return card;
    }

    public List<Cards> findByCardType_Price(int cardType_Price, int quantity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean cardCodeExists(String cardcode) {
        String query = "SELECT COUNT(*) FROM Cards WHERE CardCode = ?";
        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, cardcode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Cards> findAllDesc() {
        List<Cards> list = new ArrayList<>();
        String sql = "SELECT * FROM Cards WHERE Status = 'Available' ORDER BY CreatedAt DESC";
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Cards card = new Cards();
                card.setID(rs.getInt("ID"));
                card.setCardCode(rs.getString("CardCode"));
                card.setSerialNumber(rs.getString("SerialNumber"));
                card.setCardType_Price(rs.getInt("CardType_Price"));
                card.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                card.setExpirationDate(rs.getDate("expirationDate"));
                list.add(card);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
