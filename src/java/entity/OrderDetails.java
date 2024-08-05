/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.security.Timestamp;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 *
 * @author FPTSHOP
 */
@ToString
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class OrderDetails {

    private int ID;
    private int OrderID;
    private int CardID;
    private int Quantity;
    private LocalDateTime TransactionDate;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;
    private int CreatedBy;
    private boolean IsDelete;
    private int DeletedBy;
    private LocalDateTime DeletedAt;
    private boolean Status;
    List<OrderDetails> listOrderDetails = new ArrayList<>();

}
