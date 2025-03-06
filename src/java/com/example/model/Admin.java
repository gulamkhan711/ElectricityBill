package com.example.model;

public class Admin {
    private int id;
    private String name;
    // Add other fields as needed

    // Constructor
    public Admin(int id, String name) {
        this.id = id;
        this.name = name;
        // Initialize other fields
    }

    // Getters and Setters
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

    // Add other getters and setters
}
