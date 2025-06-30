/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.model;


import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class Food {
    private int foodId;
    private String foodname;
    private String category;
    private String bmi_type;
    private String image;
    private double price;
    private String status;
    private Timestamp create_at;
    private Timestamp update_at;

    public Food() {
    }

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public String getFoodname() {
        return foodname;
    }

    public void setFoodname(String foodname) {
        this.foodname = foodname;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getBmi_type() {
        return bmi_type;
    }

    public void setBmi_type(String bmi_type) {
        this.bmi_type = bmi_type;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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

    public Timestamp getCreate_at() {
        return create_at;
    }

    public void setCreate_at(Timestamp create_at) {
        this.create_at = create_at;
    }

    public Timestamp getUpdate_at() {
        return update_at;
    }

    public void setUpdate_at(Timestamp update_at) {
        this.update_at = update_at;
    }

    @Override
    public String toString() {
        return "Food{" + "foodId=" + foodId + ", foodname=" + foodname + ", category=" + category + ", bmi_type=" + bmi_type + ", image=" + image + ", price=" + price + ", status=" + status + ", create_at=" + create_at + ", update_at=" + update_at + '}';
    }

    
   
}
