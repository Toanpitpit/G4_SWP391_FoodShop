package com.yourpackage.model;

public class Order {
    private int id;
    private String customerName;
    private String address;
    private String phone;
    private String food;
    private int quantity;
    private double price;
    private String status;

    public Order() {
    }

    public Order(int id, String customerName, String address, String phone, String food, int quantity, double price, String status) {
        this.id = id;
        this.customerName = customerName;
        this.address = address;
        this.phone = phone;
        this.food = food;
        this.quantity = quantity;
        this.price = price;
        this.status = status;
    }

    // Getter và Setter

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFood() {
        return food;
    }

    public void setFood(String food) {
        this.food = food;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
  
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
