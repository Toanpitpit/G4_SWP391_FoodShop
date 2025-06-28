/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.model;

/**
 *
 * @author Admin
 */
public class FoodDetail {
    private int fdID;
    private Integer fdrID;
    private Integer fID;
    private boolean isDraft;
    private String description;
    private String ingredients;

    public FoodDetail() {
    }

    public FoodDetail(int fdID, Integer fdrID, Integer fID, boolean isDraft, String description, String ingredients) {
        this.fdID = fdID;
        this.fdrID = fdrID;
        this.fID = fID;
        this.isDraft = isDraft;
        this.description = description;
        this.ingredients = ingredients;
    }

    public int getFdID() {
        return fdID;
    }

    public void setFdID(int fdID) {
        this.fdID = fdID;
    }

    public Integer getFdrID() {
        return fdrID;
    }

    public void setFdrID(Integer fdrID) {
        this.fdrID = fdrID;
    }

    public Integer getfID() {
        return fID;
    }

    public void setfID(Integer fID) {
        this.fID = fID;
    }

    public boolean isIsDraft() {
        return isDraft;
    }

    public void setIsDraft(boolean isDraft) {
        this.isDraft = isDraft;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getIngredients() {
        return ingredients;
    }

    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }
    
    

    @Override
    public String toString() {
        return "FoodDetail{" + "fdID=" + fdID + ", fdrID=" + fdrID + ", fID=" + fID + ", isDraft=" + isDraft + ", description=" + description + ", ingredients=" + ingredients + '}';
    }
    
    
}
