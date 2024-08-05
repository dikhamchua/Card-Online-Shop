
import dal.implement.OrderDetailsDAO;
import dal.implement.ReviewDAO;
import entity.OrderDetails;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/CardListServlet")
public class CardListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
        ReviewDAO reviewDAO = new ReviewDAO();

        // Lấy tất cả các orderDetails
        List<OrderDetails> orderDetailsList = orderDetailsDAO.findAll();

        // Tạo một bản đồ để lưu thông tin tên thẻ, số sao trung bình, tổng số đánh giá và chi tiết đánh giá
        Map<String, Map<String, Object>> cardInfoMap = new HashMap<>();

        for (OrderDetails orderDetails : orderDetailsList) {
            int orderId = orderDetails.getOrderID();

            // Lấy danh sách tên thẻ từ OrderDetails
            List<String> cardTypeNames = orderDetailsDAO.getCardNamesByOrderID(orderId);

            // Lấy số sao trung bình và tổng số đánh giá từ reviews
            double averageRating = reviewDAO.getAverageRatingByOrderID(orderId);
            int totalReviews = reviewDAO.getTotalReviewsByOrderID(orderId);
            Map<Integer, Integer> ratingCount = reviewDAO.getRatingCountByOrderID(orderId);

            for (String cardTypeName : cardTypeNames) {
                if (cardTypeName != null) {
                    // Nếu cardInfoMap đã có thông tin cho cardTypeName, chúng ta sẽ cập nhật số liệu thay vì thay thế
                    Map<String, Object> cardInfo = cardInfoMap.getOrDefault(cardTypeName, new HashMap<>());

                    int existingTotalReviews = cardInfo.containsKey("totalReviews") ? (int) cardInfo.get("totalReviews") : 0;
                    double existingAverageRating = cardInfo.containsKey("averageRating") ? (double) cardInfo.get("averageRating") : 0.0;
                    Map<Integer, Integer> existingRatingCount = cardInfo.containsKey("ratingCount") ? (Map<Integer, Integer>) cardInfo.get("ratingCount") : new HashMap<>();

                    // Cập nhật chi tiết số sao
                    for (Map.Entry<Integer, Integer> entry : ratingCount.entrySet()) {
                        existingRatingCount.merge(entry.getKey(), entry.getValue(), Integer::sum);
                    }

                    // Cập nhật số lượng đánh giá và đánh giá trung bình
                    if (existingTotalReviews + totalReviews > 0) {
                        averageRating = (existingAverageRating * existingTotalReviews + averageRating * totalReviews) / (existingTotalReviews + totalReviews);
                    }
                    totalReviews += existingTotalReviews;

                    cardInfo.put("averageRating", averageRating);
                    cardInfo.put("totalReviews", totalReviews);
                    cardInfo.put("ratingCount", existingRatingCount);
                    cardInfoMap.put(cardTypeName, cardInfo);
                }
            }
        }

        // Đặt thuộc tính cho request
        request.setAttribute("cardInfoMap", cardInfoMap);

        // Chuyển tiếp đến trang JSP
        request.getRequestDispatcher("view/admin/cardList.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Card List Servlet";
    }
}
