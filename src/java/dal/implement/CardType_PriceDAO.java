package dal.implement;

import dal.DBContext;
import dal.GenericDAO;
import entity.CardType_Price;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.sql.*;

public class CardType_PriceDAO extends GenericDAO<CardType_Price> {

    @Override
    public List<CardType_Price> findAll() {
        return queryGenericDAO(CardType_Price.class);
    }

    public List<CardType_Price> getAllCardTypePriceDesc() {
        List<CardType_Price> list = new ArrayList<>();
        connection = new DBContext().getConnection();
        String query = "SELECT * FROM cardtype_price ORDER BY ID DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new CardType_Price(rs.getInt("ID"), rs.getInt("CardTypeID"), rs.getInt("PriceID"), rs.getString("ImageDetail")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int insert(CardType_Price t) {
        String sql = "INSERT INTO CardType_Price (CardTypeID, PriceID) VALUES (?, ?)";
        Map<String, Object> parameterMap = new LinkedHashMap<>();
        parameterMap.put("CardTypeID", t.getCardTypeID());
        parameterMap.put("PriceID", t.getPriceID());
        return insertGenericDAO(sql, parameterMap);
    }

    public void deleteById(int ID) {
        String sql = "DELETE FROM CardType_Price WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, ID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCardTypePrice(CardType_Price cardTypePrice) {
        String sql = "UPDATE CardType_Price SET CardTypeID = ?, PriceID = ? WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cardTypePrice.getCardTypeID());
            statement.setInt(2, cardTypePrice.getPriceID());
            statement.setInt(3, cardTypePrice.getID());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<CardType_Price> findByCardTypeId(int cardTypeId) {
        List<CardType_Price> prices = new ArrayList<>();
        String sql = "SELECT * FROM CardType_Price WHERE CardTypeID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cardTypeId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    CardType_Price price = CardType_Price.builder()
                            .ID(resultSet.getInt("ID"))
                            .CardTypeID(resultSet.getInt("CardTypeID"))
                            .PriceID(resultSet.getInt("PriceID"))
                            .ImageDetail(resultSet.getString("ImageDetail"))
                            .build();
                    prices.add(price);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return prices;
    }

    public CardType_Price findByCardTypeIdAndPriceId(int cardTypeId, int priceId) {
        String sql = "SELECT * FROM CardType_Price WHERE CardTypeID = ? AND PriceID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, cardTypeId);
            statement.setInt(2, priceId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return CardType_Price.builder()
                            .ID(resultSet.getInt("ID"))
                            .CardTypeID(resultSet.getInt("CardTypeID"))
                            .PriceID(resultSet.getInt("PriceID"))
                            .build();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<CardType_Price> findByNameOrPrice(String name, Double price) {
        StringBuilder sql = new StringBuilder("SELECT * FROM CardType_Price as cp ");
        sql.append("JOIN CardTypes as c ON cp.CardTypeID = c.ID ");
        sql.append("JOIN Price as p ON cp.PriceID = p.ID ");

        parameterMap = new LinkedHashMap<>();

        if (name != null && !name.isEmpty()) {
            sql.append("AND c.CardTypeName LIKE ? ");
            parameterMap.put("name", "%" + name + "%");
        }

        if (price != null) {
            sql.append("AND p.Price = ? ");
            parameterMap.put("price", price);
        }

        return queryGenericDAO(CardType_Price.class, sql.toString(), parameterMap);
    }

    public List<CardType_Price> findByNameOrIdOrPrice(String keyword) {
        StringBuilder sql = new StringBuilder("SELECT * FROM CardType_Price as cp ");
        sql.append("JOIN CardTypes as c ON cp.CardTypeID = c.ID ");
        sql.append("JOIN Price as p ON cp.PriceID = p.ID WHERE 1=1 ");

        Map<String, Object> parameterMap = new LinkedHashMap<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append("AND (c.CardTypeName LIKE ? ");
            parameterMap.put("name", "%" + keyword + "%");

            try {
                int searchValue = Integer.parseInt(keyword);
                sql.append("OR p.Price LIKE ? ");
                parameterMap.put("price", searchValue + "%");
            } catch (NumberFormatException e) {
                // Nếu không phải số, không thêm điều kiện cho Price
            }

            sql.append(") ");
        }

        return queryGenericDAO(CardType_Price.class, sql.toString(), parameterMap);
    }

    public List<CardType_Price> findAdvancedSearch(String keyword, String searchID, String searchName, String searchValue) {
        StringBuilder sql = new StringBuilder("SELECT * FROM CardType_Price cp ");
        sql.append("JOIN CardTypes c ON cp.CardTypeID = c.ID ");
        sql.append("JOIN Price p ON cp.PriceID = p.ID ");

        parameterMap = new LinkedHashMap<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append("AND (c.CardTypeName LIKE ? OR cp.ID LIKE ? OR p.Price LIKE ?) ");
            String searchKeyword = "%" + keyword + "%";
            parameterMap.put("name", searchKeyword);
            parameterMap.put("id", searchKeyword);
            parameterMap.put("price", searchKeyword);
        }

        if (searchID != null && !searchID.isEmpty() && !searchID.equalsIgnoreCase("Chọn ID...")) {
            sql.append(" AND cp.ID = ? ");
            parameterMap.put("searchID", Integer.parseInt(searchID));
        }

        if (searchName != null && !searchName.isEmpty() && !searchName.equalsIgnoreCase("Chọn tên...")) {
            sql.append(" AND c.CardTypeName LIKE ? ");
            parameterMap.put("searchName", "%" + searchName + "%");
        }

        if (searchValue != null && !searchValue.isEmpty() && !searchValue.equalsIgnoreCase("Chọn mệnh giá...")) {
            sql.append(" AND p.Price = ? ");
            parameterMap.put("searchValue", Double.parseDouble(searchValue));
        }

        return queryGenericDAO(CardType_Price.class, sql.toString(), parameterMap);
    }

    public List<CardType_Price> filterCardTypePrices(Integer searchID, String searchName, Integer searchValue) {
        List<CardType_Price> cardTypePriceList = new ArrayList<>();
        String sql = "SELECT * FROM CardType_Price ctp JOIN CardTypes ct ON ctp.CardTypeID = ct.ID JOIN Price p ON ctp.PriceID = p.ID WHERE 1=1";

        if (searchID != null) {
            sql += " AND ct.ID = ?";
        }
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql += " AND ct.CardTypeName = ?";
        }
        if (searchValue != null) {
            sql += " AND p.Price = ?";
        }

        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {

            int paramIndex = 1;
            if (searchID != null) {
                ps.setInt(paramIndex++, searchID);
            }
            if (searchName != null && !searchName.trim().isEmpty()) {
                ps.setString(paramIndex++, searchName);
            }
            if (searchValue != null) {
                ps.setInt(paramIndex++, searchValue);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("ID");
                    int cardTypeId = rs.getInt("CardTypeID");
                    int priceId = rs.getInt("PriceID");
                    String imageDeTail = null;
                    cardTypePriceList.add(new CardType_Price(id, cardTypeId, priceId, imageDeTail));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cardTypePriceList;
    }

    public BigDecimal getPriceByCardTypeId(int cardTypeId) {
        String sql = "SELECT p.Price FROM CardType_Price cp " + "JOIN Price p ON cp.PriceID = p.ID " + "WHERE cp.CardTypeID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, cardTypeId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getBigDecimal("Price");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    protected CardType_Price mapRow(ResultSet rs) throws SQLException {
        return CardType_Price.builder()
                .ID(rs.getInt("ID"))
                .CardTypeID(rs.getInt("CardTypeID"))
                .PriceID(rs.getInt("PriceID"))
                .build();
    }

    private static List<CardType_Price> cardTypePrices = new ArrayList<>();

    public CardType_Price findById(int id) {
        for (CardType_Price cardTypePrice : cardTypePrices) {
            if (cardTypePrice.getID() == id) {
                return cardTypePrice;
            }
        }
        return null;
    }

    public String getProductNameById(int id) {
        String query = "SELECT c.CardTypeName FROM CardType_Price cp JOIN CardTypes c ON cp.CardTypeID = c.ID WHERE cp.ID = ?";
        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("CardTypeName");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
