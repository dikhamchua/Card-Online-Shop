package dal.implement;

import dal.DBContext;
import dal.GenericDAO;
import entity.CardTypes;
import entity.Price;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.sql.*;
import java.util.LinkedHashMap;

public class PriceDAO extends GenericDAO<Price> {

    @Override
    public List<Price> findAll() {
        return queryGenericDAO(Price.class);
    }

    @Override
    public int insert(Price t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public Price findById(int id) {
        String sql = "SELECT * FROM Price WHERE ID = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return Price.builder()
                            .ID(String.valueOf(resultSet.getInt("ID")))
                            .Price(resultSet.getDouble("Price"))
                            .build();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public double findPriceByCardId(int cardID) {
        connection = new DBContext().getConnection();
        try {
            String sql = "select p.*\n"
                    + "FROM\n"
                    + "  Cards as c,\n"
                    + "  Price as p,\n"
                    + "  CardType_Price as cp\n"
                    + "WHERE\n"
                    + "  cp.ID = c.CardType_Price\n"
                    + "  AND cp.PriceID = p.ID\n"
                    + "  AND c.ID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cardID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("Price");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Price findByCardId(int id) {
        String sql = "select p.*\n"
                + "FROM\n"
                + "	cards as c,\n"
                + "	cardtype_price as cp,\n"
                + "    price as p\n"
                + "WHERE\n"
                + "	c.CardType_Price = cp.ID\n"
                + "    AND cp.PriceID = p.ID\n"
                + "    AND c.ID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("1", id);
        List<Price> list = queryGenericDAO(Price.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    public double findPriceByCardTypePrice(int cardTypePrice) {
        connection = new DBContext().getConnection();
        try {
            String sql = "select p.*\n"
                    + "from \n"
                    + "	price as p,\n"
                    + "    cardtype_price as cp\n"
                    + "where \n"
                    + "	p.ID = cp.PriceID\n"
                    + "    AND cp.ID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cardTypePrice);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("Price");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

}
