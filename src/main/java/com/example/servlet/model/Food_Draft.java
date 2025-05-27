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
    private int catID;
    private String catName;
    private String imageUlr;
    private String detail;
    private String ingredients;
    private int typeBMI; 
    private double price;
    private String status;
    private Timestamp create_at;
    private Timestamp update_at;

    public Food_Draft(int fdrID, int originID, int authorID, String foodName, int catID, String catName, String imageUlr, String detail, String ingredients, int typeBMI, double price, String status, Timestamp create_at, Timestamp update_at) {
        this.fdrID = fdrID;
        this.originID = originID;
        this.authorID = authorID;
        this.foodName = foodName;
        this.catID = catID;
        this.catName = catName;
        this.imageUlr = imageUlr;
        this.detail = detail;
        this.ingredients = ingredients;
        this.typeBMI = typeBMI;
        this.price = price;
        this.status = status;
        this.create_at = create_at;
        this.update_at = update_at;
    }

    public Food_Draft() {
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

    public int getCatID() {
        return catID;
    }

    public void setCatID(int catID) {
        this.catID = catID;
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

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getIngredients() {
        return ingredients;
    }

    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }

    public int getTypeBMI() {
        return typeBMI;
    }

    public void setTypeBMI(int typeBMI) {
        this.typeBMI = typeBMI;
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
        return "Food_Draft{" + "fdrID=" + fdrID + ", originID=" + originID + ", authorID=" + authorID + ", foodName=" + foodName + ", catID=" + catID + ", catName=" + catName + ", imageUlr=" + imageUlr + ", detail=" + detail + ", ingredients=" + ingredients + ", typeBMI=" + typeBMI + ", price=" + price + ", status=" + status + ", create_at=" + create_at + ", update_at=" + update_at + '}';
    }
    
    
    
    
}
