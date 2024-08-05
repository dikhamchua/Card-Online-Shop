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

public class Cards {

    private int ID;
    private String CardCode;
    private String SerialNumber;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;
    private int CreatedBy;
    private boolean IsDelete;
    private int DeletedBy;
    private LocalDateTime DeletedAt;
    private String Status;
    private int CardType_Price;
    private Date ExpirationDate;

}
