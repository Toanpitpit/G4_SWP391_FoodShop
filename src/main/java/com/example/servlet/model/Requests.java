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
public class Requests {
  private int rID;
  private String title;
  private int authorID;
  private String authorName;
  private String type;
  private int draftID;
  private String foodName;
  private String status;
  private String note;
  private String handleBY;
  private Timestamp create_at;
  private Timestamp update_at;

    public Requests(int rID, String title, int authorID, String authorName, String type, int draftID, String foodName, String status, String note, String handleBY, Timestamp create_at, Timestamp update_at) {
        this.rID = rID;
        this.title = title;
        this.authorID = authorID;
        this.authorName = authorName;
        this.type = type;
        this.draftID = draftID;
        this.foodName = foodName;
        this.status = status;
        this.note = note;
        this.handleBY = handleBY;
        this.create_at = create_at;
        this.update_at = update_at;
    }

    public int getrID() {
        return rID;
    }

    public void setrID(int rID) {
        this.rID = rID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getAuthorID() {
        return authorID;
    }

    public void setAuthorID(int authorID) {
        this.authorID = authorID;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getDraftID() {
        return draftID;
    }

    public void setDraftID(int draftID) {
        this.draftID = draftID;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getHandleBY() {
        return handleBY;
    }

    public void setHandleBY(String handleBY) {
        this.handleBY = handleBY;
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
        return "Requests{" + "rID=" + rID + ", title=" + title + ", authorID=" + authorID + ", authorName=" + authorName + ", type=" + type + ", draftID=" + draftID + ", foodName=" + foodName + ", status=" + status + ", note=" + note + ", handleBY=" + handleBY + ", create_at=" + create_at + ", update_at=" + update_at + '}';
    }

    
  
}
