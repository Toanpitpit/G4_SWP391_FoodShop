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
public class Notifys {
    private int nID;
    private int receiverID;
    private String roleTaget;
    private String message;
    private int senderID;
    private int relatedRequestId;
    private boolean isRead;
    private Timestamp create_at;

    public Notifys(int nID, int receiverID, String roleTaget, String message, int senderID, int relatedRequestId, boolean isRead, Timestamp create_at) {
        this.nID = nID;
        this.receiverID = receiverID;
        this.roleTaget = roleTaget;
        this.message = message;
        this.senderID = senderID;
        this.relatedRequestId = relatedRequestId;
        this.isRead = isRead;
        this.create_at = create_at;
    }

    public int getnID() {
        return nID;
    }

    public void setnID(int nID) {
        this.nID = nID;
    }

    public int getReceiverID() {
        return receiverID;
    }

    public void setReceiverID(int receiverID) {
        this.receiverID = receiverID;
    }

    public String getRoleTaget() {
        return roleTaget;
    }

    public void setRoleTaget(String roleTaget) {
        this.roleTaget = roleTaget;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getSenderID() {
        return senderID;
    }

    public void setSenderID(int senderID) {
        this.senderID = senderID;
    }

    public int getRelatedRequestId() {
        return relatedRequestId;
    }

    public void setRelatedRequestId(int relatedRequestId) {
        this.relatedRequestId = relatedRequestId;
    }

    public boolean isIsRead() {
        return isRead;
    }

    public void setIsRead(boolean isRead) {
        this.isRead = isRead;
    }

    public Timestamp getCreate_at() {
        return create_at;
    }

    public void setCreate_at(Timestamp create_at) {
        this.create_at = create_at;
    }

    public Notifys() {
    }

    @Override
    public String toString() {
        return "Notifys{" + "nID=" + nID + ", receiverID=" + receiverID + ", roleTaget=" + roleTaget + ", message=" + message + ", senderID=" + senderID + ", relatedRequestId=" + relatedRequestId + ", isRead=" + isRead + ", create_at=" + create_at + '}';
    }

   
    
    
    
}
