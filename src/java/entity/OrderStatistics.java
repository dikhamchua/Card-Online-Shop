package entity;

import java.math.BigDecimal;
import java.sql.Date;

public class OrderStatistics {

    private Date orderDate;
    private BigDecimal revenue;
    private int ordersCount;

    // Getters and setters
    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public BigDecimal getRevenue() {
        return revenue;
    }

    public void setRevenue(BigDecimal revenue) {
        this.revenue = revenue;
    }

    public int getOrdersCount() {
        return ordersCount;
    }

    public void setOrdersCount(int ordersCount) {
        this.ordersCount = ordersCount;
    }
}
