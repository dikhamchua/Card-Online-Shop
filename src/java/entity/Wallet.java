/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.math.BigDecimal;

/**
 *
 * @author admin
 */
public class Wallet {

    private int id;
    private BigDecimal total;
    private int userID;

    public Wallet() {
    }

    public Wallet(int id, BigDecimal total, int userID) {
        this.id = id;
        this.total = total;
        this.userID = userID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public BigDecimal getWallet() {
        return total;
    }

    public void setWallet(BigDecimal total) {
        this.total = total;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }
    
}