/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
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

public class Cart {

    private int ID;
    private int UserID;
    private Date CreatedAt;
    private Date UpdatedAt;
    private int CreatedBy;
    private boolean IsDelete;
    private int DeletedBy;
    private Date DeletedAt;
    private String Status;
    List<Cart_Item> listCart_Item = new ArrayList<>();
}
