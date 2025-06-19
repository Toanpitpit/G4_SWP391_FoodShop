package com.example.servlet.model;

public class Order {
    private int id;
    private String customerName;
    private String address;
    private String phone;
    private String food;
    private String category;
    private int quantity;
    private double price;
    private String status;
    private double totalPrice;
    private String image;
    public Order() {
    }

    public Order(int id, String customerName, String address, String phone, String food,String image, String category,int quantity, double price, String status) {
        this.id = id;
        this.customerName = customerName;
        this.address = address;
        this.phone = phone;
        this.food = food;
        this.category = category;
        this.quantity = quantity;
        this.price = price;
        this.status = status;
        this.image = image;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
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
    public double getTotalPrice() {
    return this.quantity * this.price;
}

}
