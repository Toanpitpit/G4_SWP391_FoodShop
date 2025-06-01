/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.model;

/**
 *
 * @author Admin
 */
public class BMIClassification {
    private int bmiID;
    private String classification;
    private String bmiRange;
    private String decription;
    private String tagetAudience;

    public BMIClassification(int bmiID, String classification, String bmiRange, String decription, String tagetAudience) {
        this.bmiID = bmiID;
        this.classification = classification;
        this.bmiRange = bmiRange;
        this.decription = decription;
        this.tagetAudience = tagetAudience;
    }

    public BMIClassification() {
    }

    public int getBmiID() {
        return bmiID;
    }

    public void setBmiID(int bmiID) {
        this.bmiID = bmiID;
    }

    public String getClassification() {
        return classification;
    }

    public void setClassification(String classification) {
        this.classification = classification;
    }

    public String getBmiRange() {
        return bmiRange;
    }

    public void setBmiRange(String bmiRange) {
        this.bmiRange = bmiRange;
    }

    public String getDecription() {
        return decription;
    }

    public void setDecription(String decription) {
        this.decription = decription;
    }

    public String getTagetAudience() {
        return tagetAudience;
    }

    public void setTagetAudience(String tagetAudience) {
        this.tagetAudience = tagetAudience;
    }
    
    @Override
    public String toString() {
        return "BMIClassificattion{" + "bmiID=" + bmiID + ", classification=" + classification + ", bmiRange=" + bmiRange + ", decription=" + decription + ", tagetAudience=" + tagetAudience + '}';
    }
    
}
