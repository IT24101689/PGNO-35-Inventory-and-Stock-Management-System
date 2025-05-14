package com.inventory;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class StockEntry {
    private String companyName;
    private String category;
    private String itemName;
    private int quantity;
    private double price;
    private String purchaseDate;
    private String expiryDate;

    public StockEntry(String companyName, String category, String itemName, int quantity,
                      double price, String purchaseDate, String expiryDate) {
        this.companyName = companyName;
        this.category = category;
        this.itemName = itemName;
        this.quantity = quantity;
        this.price = price;
        this.purchaseDate = purchaseDate;
        this.expiryDate = expiryDate;
    }

    public String getCompanyName() { return companyName; }
    public String getCategory() { return category; }
    public String getItemName() { return itemName; }
    public int getQuantity() { return quantity; }
    public double getPrice() { return price; }
    public String getPurchaseDate() { return purchaseDate; }
    public String getExpiryDate() { return expiryDate; }

    public double getTotalPrice() {
        return quantity * price;
    }

    public String getExpiryStatus(LocalDate today) {
        LocalDate expiry = LocalDate.parse(expiryDate);
        long days = ChronoUnit.DAYS.between(today, expiry);
        if (expiry.isBefore(today)) return "expired";
        else if (days <= 7) return "soon-expire";
        else return "normal";
    }

    @Override
    public String toString() {
        return String.format("%s,%s,%s,%d,%.2f,%s,%s",
                companyName, category, itemName, quantity, price, purchaseDate, expiryDate);
    }
    public static StockEntry fromString(String line) {
        String[] parts = line.split(",");
        if (parts.length != 7) {
            throw new IllegalArgumentException("Invalid stock entry format");
        }
        return new StockEntry(
                parts[0].trim(), // companyName
                parts[1].trim(), // category
                parts[2].trim(), // itemName
                Integer.parseInt(parts[3].trim()), // quantity
                Double.parseDouble(parts[4].trim()), // price
                parts[5].trim(), // purchaseDate
                parts[6].trim()  // expiryDate
        );
    }
}
