package controller.user;

import dal.implement.ActivityLogDAO;
import dal.implement.CardDAO;
import dal.implement.CardTypeDAO;
import dal.implement.CardType_PriceDAO;
import dal.implement.CartDAO;
import dal.implement.CouponTypeDAO;
import dal.implement.CouponsDAO;
import dal.implement.HistoryWalletDAO;
import dal.implement.OrderDetailsDAO;
import dal.implement.OrdersDAO;
import dal.implement.PriceDAO;
import dal.implement.UsersDAO;
import dal.implement.WalletDAO;
import entity.ActivityLog;
import entity.CardType_Price;
import entity.CardTypes;
import entity.Cards;
import entity.Cart;
import entity.Cart_Item;
import entity.CouponType;
import entity.Coupons;
import entity.Orders;
import entity.OrderDetails;
import entity.Price;
import entity.Users;
import entity.Wallet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class PaymentController extends HttpServlet {

    CartDAO cartDAO = new CartDAO();
    CardDAO cardDAO = new CardDAO();
    CardTypeDAO cardTypeDAO = new CardTypeDAO();
    PriceDAO priceDAO = new PriceDAO();
    CardType_PriceDAO cardtype_priceDAO = new CardType_PriceDAO();
    UsersDAO usersDAO = new UsersDAO();
    WalletDAO walletDAO = new WalletDAO();
    HistoryWalletDAO historyWalletDAO = new HistoryWalletDAO();
    OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
    CouponsDAO couponsDAO = new CouponsDAO();
    CouponTypeDAO couponTypeDAO = new CouponTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("users");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/authen?action=login");
            return;
        }
        // Lấy giỏ hàng của người dùng
        Cart cart = cartDAO.getCartByUserID(user.getID());
        if (cart == null) {
            // Nếu giỏ hàng chưa tồn tại, tạo giỏ hàng mới
            cart = Cart.builder()
                    .UserID(user.getID())
                    .CreatedBy(user.getID())
                    .IsDelete(false)
                    .DeletedBy(user.getID())
                    .DeletedAt(null)
                    .Status("Active")
                    .build();
            int newCartId = cartDAO.insert(cart);
            cart.setID(newCartId);
            cart.setListCart_Item(new ArrayList<>());
        }
        // Cập nhật lại giỏ hàng
        cart = cartDAO.getCartByUserID(user.getID());
        // Lấy danh sách giá và loại thẻ
        List<CardType_Price> listCardType_Price = new CardType_PriceDAO().findAll();
        request.setAttribute("listCardType_Price", listCardType_Price);

        List<Cards> listProduct = cardDAO.findAll();
        request.setAttribute("listProduct", listProduct);
        List<CardTypes> listCardType = cardTypeDAO.findAll();
        request.setAttribute("listCardType", listCardType);
        List<Price> listPrice = priceDAO.findAll();
        session.setAttribute("listPrice", listPrice);

        Double finalAmount = (Double) session.getAttribute("finalAmount");
        if (finalAmount == null) {
             // Tính toán số tiền cuối cùng nếu chưa có trong session
            finalAmount = calculateAmount(cart);
        }
        request.setAttribute("finalAmount", finalAmount);
        request.setAttribute("cart", cart);

        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }

        String view = request.getParameter("view");
        if ("checkout".equals(view)) {
            request.getRequestDispatcher("view/payment/checkout.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("view/payment/cart.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null
                ? request.getParameter("action")
                : "";
        switch (action) {
            case "add-product":
                addProduct(request, response);
                break;
            case "change-quantity":
                changeQuantity(request, response);
                break;
            case "delete":
                delete(request, response);
                request.getRequestDispatcher("view/payment/cart.jsp").forward(request, response);
                break;
            case "checkout":
                checkOut(request, response);
                break;
            case "apply-coupon":
                applyCoupon(request, response);

                break;
            default:
                throw new AssertionError();
        }

//        request.getRequestDispatcher("view/payment/cart.jsp").forward(request, response);
//        response.sendRedirect("/payment");
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("users");
        int userID;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/authen?action=login");
            return;
        } else {
            userID = user.getID();
        }

        int cardType_Price = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Cart cart = cartDAO.getCartByUserID(userID);
        if (cart == null) {
            cart = Cart.builder()
                    .UserID(userID)
                    .CreatedBy(userID)
                    .IsDelete(false)
                    .DeletedBy(userID)
                    .DeletedAt(null)
                    .Status("Active")
                    .build();
            int newCartId = cartDAO.insert(cart);
            cart.setID(newCartId);
            cart.setListCart_Item(new ArrayList<>()); // Khởi tạo danh sách nếu giỏ hàng mới được tạo
        }

        if (cart.getListCart_Item() == null) {
            cart.setListCart_Item(new ArrayList<>()); // Khởi tạo danh sách nếu danh sách chưa được khởi tạo
        }

        Cart_Item existingItem = null;
        for (Cart_Item item : cart.getListCart_Item()) {
            if (item.getCardType_Price() == cardType_Price) {
                existingItem = item;
                break;
            }
        }

        if (existingItem != null) {
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
            cartDAO.updateCartItem(existingItem);
        } else {
            Cart_Item newItem = Cart_Item.builder()
                    .CartID(cart.getID())
                    .CardType_Price(cardType_Price)
                    .Quantity(quantity)
                    .CreatedBy(userID)
                    .build();
            cartDAO.insertCartItem(newItem);
            cart.getListCart_Item().add(newItem);
        }
        // Xóa thông tin mã giảm giá sau khi thêm sản phẩm vào giỏ hàng
        session.removeAttribute("couponDiscount");
        session.removeAttribute("finalAmount");
        session.removeAttribute("discountPercent");
        session.removeAttribute("couponApplied");
        response.sendRedirect("payment");
    }

    private void addCart_ItemToCart(Cart_Item ci, Cart cart) {
        //TODO: kiem tra con ton tai va du so luong chua

        boolean isAdd = false;
        for (Cart_Item obj : cart.getListCart_Item()) {
            if (obj.getCardType_Price() == ci.getCardType_Price()) {
                obj.setQuantity(obj.getQuantity() + ci.getQuantity());
                isAdd = true;
            }
        }
        if (isAdd == false) {
            cart.getListCart_Item().add(ci);
        }
    }

    private void changeQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            Users user = (Users) session.getAttribute("users");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/authen?action=login");
                // Redirect to login page if the user is not logged in 
                return;
            }
            Cart cart = cartDAO.getCartByUserID(user.getID());
            if (cart == null) {
                cart = Cart.builder().UserID(user.getID()).CreatedBy(user.getID()).IsDelete(false).DeletedBy(user.getID()).DeletedAt(null).Status("Active").build();
                int newCartId = cartDAO.insert(cart);
                cart.setID(newCartId);
                cart.setListCart_Item(new ArrayList<>());
                // Initialize the list if the cart is newly created
            }

            for (Cart_Item obj : cart.getListCart_Item()) {
                if (obj.getCardType_Price() == id) {
                    obj.setQuantity(quantity);
                    cartDAO.updateCartItem(obj);
                }
            }
            double finalAmount = calculateAmount(cart);
            session.setAttribute("finalAmount", finalAmount);
            // Kiểm tra xem có coupon không, nếu có thì cập nhật lại finalAmount 
            Double discountPercent = (double) session.getAttribute("discountPercent");
            if (discountPercent != null) {
                double discountAmount = finalAmount * (discountPercent / 100);
                session.setAttribute("couponDiscount", discountAmount);
            }
//            Double couponDiscount = (Double) session.getAttribute("couponDiscount");
//            if (couponDiscount != null) {
//                finalAmount -= couponDiscount;
//                session.setAttribute("finalAmount", finalAmount);
//            }
            request.setAttribute("cart", cart);

            response.sendRedirect("payment");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("payment");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            Users user = (Users) session.getAttribute("users");
            // Check if user is null
            if (user == null) {
                try {
                    response.sendRedirect(request.getContextPath() + "/authen?action=login"); // Redirect to login page if the user is not logged in
                } catch (IOException e) {
                    e.printStackTrace();
                }
                return;
            }
            Cart cart = cartDAO.getCartByUserID(user.getID());
            // Check if cart is null
            if (cart == null) {
                try {
                    response.sendRedirect(request.getContextPath() + "/view/payment/cart.jsp"); // Redirect to cart page if the cart is null
                } catch (IOException e) {
                    e.printStackTrace();
                }
                return;
            }
            Cart_Item ci = null;
            for (Cart_Item obj : cart.getListCart_Item()) {
                if (obj.getCardType_Price() == id) {
                    ci = obj;
                    break;
                }
            }
            if (ci != null) {
                cart.getListCart_Item().remove(ci);
                cartDAO.deleteCartItem(ci);
                cart = cartDAO.getCartByUserID(user.getID());
                request.setAttribute("cart", cart);
            }
//        try {
            session.removeAttribute("couponDiscount");
            session.removeAttribute("finalAmount");
            session.removeAttribute("discountPercent");
            session.removeAttribute("couponApplied");
//            request.getRequestDispatcher("view/payment/cart.jsp").forward(request, response);
            response.sendRedirect("payment");

//        } catch (ServletException | IOException e) {
//            e.printStackTrace();
//        }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void checkOut(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("users");
        int userID;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/authen?action=login");
            return;
        } else {
            userID = user.getID();
        }
        Cart cart = cartDAO.getCartByUserID(userID);
        if (cart == null || cart.getListCart_Item() == null || cart.getListCart_Item().isEmpty()) {
            // Nếu giỏ hàng trống, hiển thị thông báo lỗi
            session.setAttribute("errorMessage", "Giỏ hàng của bạn đang trống. Vui lòng thêm sản phẩm vào giỏ hàng trước khi thanh toán.");
            response.sendRedirect("payment");
            return;
        }
        // Kiểm tra số lượng thẻ khả dụng cho mỗi sản phẩm
        for (Cart_Item item : cart.getListCart_Item()) {
            List<entity.Cards> availableCards = cardDAO.getAvailableCardsByCardTypeId(item.getCardType_Price());
            if (availableCards.size() < item.getQuantity()) {
                String productName = cardtype_priceDAO.getProductNameById(item.getCardType_Price());
                session.setAttribute("errorMessage", "Không có đủ số lượng thẻ khả dụng cho sản phẩm: " + productName);
                response.sendRedirect("payment?view=checkout");
                return;
            }
        }
        //calculate 
        double amount = calculateAmount(cart);
        Double couponDiscount = (Double) session.getAttribute("couponDiscount");
        if (couponDiscount != null) {
            amount -= couponDiscount;// tru tien neu co ma giam giá
        }
        // Lấy thông tin ví của người dùng
        Wallet wallet = walletDAO.getWalletByUserID(userID);
        if (wallet != null && wallet.getTotal().compareTo(BigDecimal.valueOf(amount)) >= 0) {
            try {
                 // Trừ tiền từ ví của người dùng
                boolean deductSuccess = walletDAO.deductFromWallet(userID, BigDecimal.valueOf(amount));
                if (deductSuccess) {
                    // Tạo đơn hàng mới
                    Orders od = Orders.builder().UserID(userID).TotalMoney(amount).build();
                    OrdersDAO ordersDAO = new OrdersDAO();
                    int orderId = ordersDAO.insert(od);
                    // Xử lý từng mặt hàng trong giỏ hàng
                    for (Cart_Item item : cart.getListCart_Item()) {
                        int quantity = item.getQuantity();
                        List<entity.Cards> availableCards = cardDAO.getAvailableCardsByCardTypeId(item.getCardType_Price());
                        if (availableCards.size() >= quantity) {
                            for (int i = 0; i < quantity; i++) {
                                // update status
                                entity.Cards selectedCard = availableCards.get(i);
                                selectedCard.setStatus("Sold");
                                cardDAO.updateProduct(selectedCard);
                                // Tạo chi tiết đơn hàng mới
                                OrderDetails ods = OrderDetails.builder().OrderID(orderId).CardID(selectedCard.getID()).Quantity(1)
                                        .CreatedBy(userID).DeletedBy(0).build();
                                orderDetailsDAO.insert(ods);
                            }
                        } else {
                            session.setAttribute("errorMessage", "Không có đủ thẻ khả dụng để mua.");
                            response.sendRedirect("payment?view=checkout");
                            return;
                        }
                    }
                      // Ghi lại lịch sử hoạt động và cập nhật ví
                    historyWalletDAO.insertHistoryWalletDAO(userID, "Thanh toán", BigDecimal.valueOf(amount).negate());
                    wallet = walletDAO.getWalletByUserID(userID);
                    session.setAttribute("wallet", wallet);
                    session.removeAttribute("cart");
                    cart.setIsDelete(true);
                    cart.setDeletedAt(new Date(new java.util.Date().getTime()));
                    cart.setDeletedBy(userID);
                    cartDAO.updateCart(cart);
                    session.setAttribute("successMessage", "Mua thẻ thành công, hãy kiểm tra trong 'Đơn Hàng Của Bạn'");

                    // Xóa thông tin mã giảm giá sau khi thanh toán thành công
                    session.removeAttribute("couponDiscount");
                    session.removeAttribute("finalAmount");
                    session.removeAttribute("discountPercent");
                    session.removeAttribute("couponApplied");

                    // Ghi lại lịch sử hoạt động khi thanh toán thành công
                    ActivityLogDAO activityLogDAO = new ActivityLogDAO();
                    ActivityLog activityLog = new ActivityLog();
                    activityLog.setUserId(userID);
                    activityLog.setAction("Checkout");
                    activityLog.setDetails("Thanh toán thành công với tổng số tiền: " + amount);
                    activityLogDAO.insertActivity(activityLog);

                    response.sendRedirect("payment");
                    return;
                } else {
                    session.setAttribute("errorMessage", "Không đủ tiền trong ví.");
                    response.sendRedirect("payment?view=checkout");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình thanh toán.");
                response.sendRedirect("payment?view=checkout");
            }
        } else {
            session.setAttribute("errorMessage", "Không đủ tiền trong ví.");
            response.sendRedirect("payment?view=checkout");
        }
    }
     // Phương thức tính toán số tiền trong giỏ hàng
    private double calculateAmount(Cart cart) {
        double amount = 0;
        for (Cart_Item cart_Item : cart.getListCart_Item()) {
            double price = priceDAO.findPriceByCardTypePrice(cart_Item.getCardType_Price());
            amount += (cart_Item.getQuantity() * price);
        }
        return amount;
    }
    // Phương thức áp dụng mã giảm giá
    private void applyCoupon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("users");
        Cart cart = cartDAO.getCartByUserID(user.getID());
        String couponCode = request.getParameter("gi-coupan");
        Coupons coupon = couponsDAO.getCouponByCode(couponCode);

        if (coupon != null && coupon.getUsageCount() > 0) {
            // Lấy thông tin loại mã giảm giá
            CouponTypeDAO couponTypeDAO = new CouponTypeDAO();
            CouponType couponType = couponTypeDAO.getCouponTypeByID(coupon.getCouponTypeID());

            // Kiểm tra ngày bắt đầu, ngày kết thúc và trạng thái
            if (couponType != null && couponType.isStatus()
                    && couponType.getStartDate().before(new Date(new java.util.Date().getTime()))
                    && couponType.getEndDate().after(new Date(new java.util.Date().getTime()))) {

                double totalAmount = calculateAmount(cart);
                double discountPercent = coupon.getCouponAmount();
                double discountAmount = totalAmount * (discountPercent / 100);
                session.setAttribute("couponDiscount", discountAmount);
                session.setAttribute("finalAmount", totalAmount);
                session.setAttribute("discountPercent", discountPercent);
                session.setAttribute("couponApplied", true);
                session.setAttribute("cart", cart);

                couponsDAO.decrementUsageCount(coupon.getID());
            } else {
                session.setAttribute("couponError", "Mã giảm giá không hợp lệ, xin vui lòng kiểm tra lại.");
            }
        } else {
            session.setAttribute("couponError", "Mã giảm giá không hợp lệ, xin vui lòng kiểm tra lại.");
        }
        response.sendRedirect("payment?view=checkout");
    }

}
