/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.model;

/**
 *
 * @author Admin
 */
public class BMI_Recomentdation {
    private int birID;
    private boolean isDraft;
    private Integer fID;
    private Integer fdrID;
    private int bmiID;

    public BMI_Recomentdation() {
    }

    public BMI_Recomentdation(int birID, boolean isDraft, Integer fID, Integer fdrID, int bmiID) {
        this.birID = birID;
        this.isDraft = isDraft;
        this.fID = fID;
        this.fdrID = fdrID;
        this.bmiID = bmiID;
    }
    
    public int getBirID() {
        return birID;
    }

    public void setBirID(int birID) {
        this.birID = birID;
    }

    public boolean isIsDraft() {
        return isDraft;
    }

    public void setIsDraft(boolean isDraft) {
        this.isDraft = isDraft;
    }

    public Integer getfID() {
        return fID;
    }

    public void setfID(Integer fID) {
        this.fID = fID;
    }

    public Integer getFdrID() {
        return fdrID;
    }

    public void setFdrID(Integer fdrID) {
        this.fdrID = fdrID;
    }

    public int getBmiID() {
        return bmiID;
    }

    public void setBmiID(int bmiID) {
        this.bmiID = bmiID;
    }

    
    
            
}
