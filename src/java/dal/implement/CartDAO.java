package dal.implement;

import dal.GenericDAO;
import entity.Cart;
import entity.Cart_Item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.LinkedHashMap;

public class CartDAO extends GenericDAO<Cart> {

    @Override
    public List<Cart> findAll() {
        return queryGenericDAO(Cart.class);
    }

    @Override
    public int insert(Cart t) {
        String sql = "INSERT INTO `cart`\n"
                + "(\n"
                + "`UserID`,\n"
                + "`CreatedBy`,\n"
                + "`IsDelete`,\n"
                + "`DeletedBy`,\n"
                + "`DeletedAt`,\n"
                + "`Status`)\n"
                + "VALUES\n"
                + "(?, ?, ?, ?, ?, ?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("UserID", t.getUserID());
        parameterMap.put("CreatedBy", t.getCreatedBy());
        parameterMap.put("IsDelete", t.isIsDelete());
        parameterMap.put("DeletedBy", t.getDeletedBy());
        parameterMap.put("DeletedAt", t.getDeletedAt());
        parameterMap.put("Status", t.getStatus());
        return insertGenericDAO(sql, parameterMap);
    }

    public Cart findCartFoundByUserId(int userId) {
        Cart cart = null;
        String sql = "SELECT * FROM cart WHERE UserID = ?";
        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cart = new Cart();
                    cart.setID(rs.getInt("ID"));
                    cart.setUserID(rs.getInt("UserID"));
                    cart.setCreatedAt(rs.getDate("CreatedAt"));
                    cart.setUpdatedAt(rs.getDate("UpdatedAt"));
                    cart.setCreatedBy(rs.getInt("CreatedBy"));
                    cart.setIsDelete(rs.getBoolean("IsDelete"));
                    cart.setDeletedBy(rs.getInt("DeletedBy"));
                    cart.setDeletedAt(rs.getDate("DeletedAt"));
                    cart.setStatus(rs.getString("Status"));

                    List<Cart_Item> cartItems = getCartItemsByCartId(cart.getID());
                    cart.setListCart_Item(cartItems);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cart;
    }

    private List<Cart_Item> getCartItemsByCartId(int cartId) {
        List<Cart_Item> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM cart_item WHERE CartID = ?";

        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cart_Item item = new Cart_Item();
                    item.setID(rs.getInt("ID"));
                    item.setCartID(rs.getInt("CartID"));
                    item.setCardType_Price(rs.getInt("CardType_Price"));
                    item.setQuantity(rs.getInt("Quantity"));
                    item.setCreatedAt(rs.getDate("CreatedAt"));
                    item.setUpdatedAt(rs.getDate("UpdatedAt"));
                    item.setCreatedBy(rs.getInt("CreatedBy"));
                    item.setDeletedBy(rs.getInt("DeletedBy"));
                    item.setDeletedAt(rs.getDate("DeletedAt"));
                    cartItems.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public void updateCart(Cart cart) {
        String updateCartQuery = "UPDATE cart SET UpdatedAt = NOW(), Status = ?, IsDelete = ? WHERE ID = ?";
        String deleteCartItemsQuery = "DELETE FROM cart_item WHERE CartID = ?";
        String insertCartItemQuery = "INSERT INTO cart_item (CartID, CardType_Price, Quantity, CreatedAt, UpdatedAt, CreatedBy, DeletedBy, DeletedAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = getConnection()) {
            try (PreparedStatement psCart = con.prepareStatement(updateCartQuery)) {
                psCart.setString(1, cart.getStatus());
                psCart.setBoolean(2, cart.isIsDelete());
                psCart.setInt(3, cart.getID());
                psCart.executeUpdate();
            }

            try (PreparedStatement psDeleteItems = con.prepareStatement(deleteCartItemsQuery)) {
                psDeleteItems.setInt(1, cart.getID());
                psDeleteItems.executeUpdate();
            }

            try (PreparedStatement psInsertItem = con.prepareStatement(insertCartItemQuery)) {
                for (Cart_Item item : cart.getListCart_Item()) {
                    psInsertItem.setObject(1, item.getCartID());
                    psInsertItem.setObject(2, item.getCardType_Price());
                    psInsertItem.setObject(3, item.getQuantity());
                    psInsertItem.setObject(4, item.getCreatedAt());
                    psInsertItem.setObject(5, item.getUpdatedAt());
                    psInsertItem.setObject(6, item.getCreatedBy());
                    psInsertItem.setObject(7, item.getDeletedBy());
                    psInsertItem.setObject(8, item.getDeletedAt() != null ? item.getDeletedAt() : null);
                    psInsertItem.executeUpdate();
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        System.out.println(new CartDAO().getCartByUserID(18));
    }

    public Cart getCartByUserID(int userID) {
        String sql = "SELECT * FROM cart WHERE UserID = ? AND IsDelete = false";
        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Cart cart = Cart.builder()
                            .ID(rs.getInt("ID"))
                            .UserID(rs.getInt("UserID"))
                            .CreatedAt(rs.getDate("CreatedAt"))
                            .UpdatedAt(rs.getDate("UpdatedAt"))
                            .CreatedBy(rs.getInt("CreatedBy"))
                            .IsDelete(rs.getBoolean("IsDelete"))
                            .DeletedBy(rs.getInt("DeletedBy"))
                            .DeletedAt(rs.getDate("DeletedAt"))
                            .Status(rs.getString("Status"))
                            .build();

                    List<Cart_Item> cartItems = getCartItemsByCartId(cart.getID());
                    cart.setListCart_Item(cartItems);

                    return cart;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void createCart(Cart cart) {
        String sql = "INSERT INTO cart (UserID, CreatedAt, CreatedBy, IsDelete, Status) VALUES (?, NOW(), ?, false, ?)";
        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, cart.getUserID());
            ps.setInt(2, cart.getUserID());
            ps.setString(3, "Active");
            ps.executeUpdate();

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    cart.setID(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCartItem(Cart_Item item) {
        String sql = "UPDATE cart_item SET Quantity = ?, UpdatedAt = NOW() WHERE CartID = ? AND CardType_Price = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, item.getQuantity());
            ps.setInt(2, item.getCartID());
            ps.setInt(3, item.getCardType_Price());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertCartItem(Cart_Item item) {
        String sql = "INSERT INTO cart_item (CartID, CardType_Price, Quantity, CreatedAt, CreatedBy) VALUES (?, ?, ?, NOW(), ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, item.getCartID());
            ps.setInt(2, item.getCardType_Price());
            ps.setInt(3, item.getQuantity());
            ps.setInt(4, item.getCreatedBy());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCartItem(Cart_Item item) {
        String sql = "DELETE FROM cart_item WHERE CartID = ? AND CardType_Price = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, item.getCartID());
            ps.setInt(2, item.getCardType_Price());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
