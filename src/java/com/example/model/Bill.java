package com.example.model;

import java.sql.Date;

public class Bill {
    private int billId;
    private int customerId;
    private double amount;
    private Date billDate;

    // Constructor for creating new bills
    public Bill(int customerId, double amount) {
        this.customerId = customerId;
        this.amount = amount;
    }

    // Constructor for retrieving bills from the database
    public Bill(int billId, int customerId, double amount, Date billDate) {
        this.billId = billId;
        this.customerId = customerId;
        this.amount = amount;
        this.billDate = billDate;
    }

    // Getters and Setters
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getBillDate() {
        return billDate;
    }

    public void setBillDate(Date billDate) {
        this.billDate = billDate;
    }
}
