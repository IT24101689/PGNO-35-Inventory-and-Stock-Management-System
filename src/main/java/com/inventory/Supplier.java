package com.inventory;

public class Supplier {
    private String username;
    private String password;
    private String companyName;
    private String category;

    public Supplier(String username, String password, String companyName, String category) {
        this.username = username;
        this.password = password;
        this.companyName = companyName;
        this.category = category;
    }

    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getCompanyName() { return companyName; }
    public String getCategory() { return category; }
}
