package com.example.servlet.model;

public class Food {
    private String id;
    private String name;
    private String image;
    private String category;
    private double price;
    private String status;

    // Constructors
    public Food() {}
    
    public Food(String id, String name, String image, String category, double price, String status) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.category = category;
        this.price = price;
        this.status = status;
    }

    // Getters & Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
