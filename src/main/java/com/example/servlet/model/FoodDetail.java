package com.example.servlet.model;

public class FoodDetail {
    private int id;
    private String name;
    private String image;
    private String category;
    private double price;
    private String status;

    // Dữ liệu mở rộng từ bảng FoodDetail
    private String bmiClass;     // classification từ bảng bmi_classification
    private String description;  // Pdetail
    private String ingredients;  // thanh_phan

    public FoodDetail() {}

    public FoodDetail(int id, String name, String image, String category, double price, String status,
                      String bmiClass, String description, String ingredients) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.category = category;
        this.price = price;
        this.status = status;
        this.bmiClass = bmiClass;
        this.description = description;
        this.ingredients = ingredients;
    }

    // Getter & Setter

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
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

    public String getBmiClass() {
        return bmiClass;
    }

    public void setBmiClass(String bmiClass) {
        this.bmiClass = bmiClass;
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
}
