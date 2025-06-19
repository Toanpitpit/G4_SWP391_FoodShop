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
    private float min_bmi;
    private float max_bmi;
    private String decription;
    private String tagetAudience;
    
    public BMIClassification() {
    }
    

    public BMIClassification(int bmiID, String classification, float min_bmi, float max_bmi, String decription, String tagetAudience) {
        this.bmiID = bmiID;
        this.classification = classification;
        this.min_bmi = min_bmi;
        this.max_bmi = max_bmi;
        this.decription = decription;
        this.tagetAudience = tagetAudience;
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

    public float getMin_bmi() {
        return min_bmi;
    }

    public void setMin_bmi(float min_bmi) {
        this.min_bmi = min_bmi;
    }

    public double getMax_bmi() {
        return max_bmi;
    }

    public void setMax_bmi(float max_bmi) {
        this.max_bmi = max_bmi;
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
        return "BMIClassification{" + "bmiID=" + bmiID + ", classification=" + classification + ", min_bmi=" + min_bmi + ", max_bmi=" + max_bmi + ", decription=" + decription + ", tagetAudience=" + tagetAudience + '}';
    }

    
    
}
