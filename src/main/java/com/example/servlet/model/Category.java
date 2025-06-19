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
public class Category {
    private int catID ;
    private String caName;
    private String decription;
    private Timestamp create_at;
    private Timestamp update_at;

    public Category(int catID, String caName, String decription, Timestamp create_at, Timestamp update_at) {
        this.catID = catID;
        this.caName = caName;
        this.decription = decription;
        this.create_at = create_at;
        this.update_at = update_at;
    }

    public int getCatID() {
        return catID;
    }

    public void setCatID(int catID) {
        this.catID = catID;
    }

    public String getCaName() {
        return caName;
    }

    public void setCaName(String caName) {
        this.caName = caName;
    }

    public String getDecription() {
        return decription;
    }

    public void setDecription(String decription) {
        this.decription = decription;
    }

    public Category() {
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
        return "Category{" + "catID=" + catID + ", caName=" + caName + ", decription=" + decription + ", create_at=" + create_at + ", update_at=" + update_at + '}';
    }
    
}
