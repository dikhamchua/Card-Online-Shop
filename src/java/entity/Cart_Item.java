/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.time.LocalDateTime;
import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter

public class Cart_Item {

    private int ID;
    private int CartID;
    private int CardType_Price;
    private int Quantity;
    private Date CreatedAt;
    private Date UpdatedAt;
    private int CreatedBy;
    private boolean IsDelete;
    private int DeletedBy;
    private Date DeletedAt;
    private String Status;

}
