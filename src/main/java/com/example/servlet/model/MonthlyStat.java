/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.model;

/**
 *
 * @author Admin
 */
public class MonthlyStat {
   private String monthlName;
   private int count ;

    public String getMonthlName() {
        return monthlName;
    }

    public void setMonthlName(String monthlName) {
        this.monthlName = monthlName;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public MonthlyStat(String monthlName, int count) {
        this.monthlName = monthlName;
        this.count = count;
    }

    public MonthlyStat() {
    }

    @Override
    public String toString() {
        return "MonthlyStat{" + "monthlName=" + monthlName + ", count=" + count + '}';
    }
   
}
