package dal.implement;

import dal.GenericDAO;
import entity.CardTypes;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CardTypeDAO extends GenericDAO<CardTypes> {

    @Override
    public List<CardTypes> findAll() {
        return queryGenericDAO(CardTypes.class);
    }

    public List<CardTypes> findAllDESC() {
        List<CardTypes> cardTypesList = new ArrayList<>();
        String sql = "SELECT * FROM CardTypes ORDER BY ID DESC";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql); ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                CardTypes cardType = CardTypes.builder()
                        .ID(rs.getInt("ID"))
                        .CardTypeName(rs.getString("CardTypeName"))
                        .Image(rs.getString("Image"))
                        .build();
                cardTypesList.add(cardType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cardTypesList;
    }

    @Override
    public int insert(CardTypes t) {
        String sql = "INSERT INTO CardTypes (CardTypeName, Image) VALUES (?, ?)";
        Map<String, Object> parameterMap = new LinkedHashMap<>();
        parameterMap.put("CardTypeName", t.getCardTypeName());
        parameterMap.put("Image", t.getImage());
        return insertGenericDAO(sql, parameterMap);
    }

    public void deleteById(int ID) {
        String sql = "DELETE FROM CardTypes WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, ID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        System.out.println(new CardTypeDAO().findByCardId(30));
    }

    public void updateCardType(CardTypes cardTypes) {
        String sql = "UPDATE CardTypes SET CardTypeName = ?, Image = ? WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, cardTypes.getCardTypeName());
            statement.setString(2, cardTypes.getImage());
            statement.setInt(3, cardTypes.getID());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<CardTypes> findByIdOrName(String keyword) {
        String sql = "SELECT * FROM CardTypes WHERE ID LIKE ? OR CardTypeName LIKE ?";
        Map<String, Object> parameterMap = new LinkedHashMap<>();
        parameterMap.put("1", "%" + keyword + "%");
        parameterMap.put("2", "%" + keyword + "%");
        return queryGenericDAO(CardTypes.class, sql, parameterMap);
    }

    public CardTypes findByCardId(int id) {
        String sql = "select ct.*\n"
                + "FROM\n"
                + "	cards as c,\n"
                + "	cardtype_price as cp,\n"
                + "    cardtypes as ct\n"
                + "WHERE\n"
                + "	c.CardType_Price = cp.ID\n"
                + "    AND cp.CardTypeID = ct.ID\n"
                + "    AND c.ID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("1", id);
        List<CardTypes> list = queryGenericDAO(CardTypes.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    public boolean cardTypeNameExists(String cardTypeName) {
        String sql = "SELECT COUNT(*) FROM CardTypes WHERE CardTypeName = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cardTypeName);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<CardTypes> findAllDesc() {
        List<CardTypes> list = new ArrayList<>();
        String sql = "SELECT * FROM CardTypes ORDER BY ID DESC";
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                CardTypes cardType = new CardTypes();
                cardType.setID(rs.getInt("ID"));
                cardType.setCardTypeName(rs.getString("CardTypeName"));
                list.add(cardType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
