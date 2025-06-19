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
public class Food_Draft {
    private int fdrID;
    private int originID;
    private int authorID;
    private String foodName;
    private String catName;
    private String imageUlr;
    private double price;
    private String status;
    private Timestamp create_at;
    private Timestamp update_at;

    public Food_Draft() {
    }

    public Food_Draft(int fdrID, int originID, int authorID, String foodName, String catName, String imageUlr, double price, String status, Timestamp create_at, Timestamp update_at) {
        this.fdrID = fdrID;
        this.originID = originID;
        this.authorID = authorID;
        this.foodName = foodName;
        this.catName = catName;
        this.imageUlr = imageUlr;
        this.price = price;
        this.status = status;
        this.create_at = create_at;
        this.update_at = update_at;
    }

    public int getFdrID() {
        return fdrID;
    }

    public void setFdrID(int fdrID) {
        this.fdrID = fdrID;
    }

    public int getOriginID() {
        return originID;
    }

    public void setOriginID(int originID) {
        this.originID = originID;
    }

    public int getAuthorID() {
        return authorID;
    }

    public void setAuthorID(int authorID) {
        this.authorID = authorID;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
    }

    public String getImageUlr() {
        return imageUlr;
    }

    public void setImageUlr(String imageUlr) {
        this.imageUlr = imageUlr;
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
        return "Food_Draft{" + "fdrID=" + fdrID + ", originID=" + originID + ", authorID=" + authorID + ", foodName=" + foodName + ", catName=" + catName + ", imageUlr=" + imageUlr + ", price=" + price + ", status=" + status + ", create_at=" + create_at + ", update_at=" + update_at + '}';
    }  
    
}
