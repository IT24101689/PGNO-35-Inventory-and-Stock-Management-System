package com.inventory;

import java.io.*;
import java.nio.file.*;
import java.util.*;

public class SupplierInventoryManager {

    private String supplierFile;
    private String stockFile;

    public SupplierInventoryManager(String supplierFile, String stockFile) {
        this.supplierFile = supplierFile;
        this.stockFile = stockFile;
    }

    public void addStock(String supplierUsername, StockEntry entry) throws IOException {
        List<String> fileLines = new ArrayList<>();
        boolean supplierFound = false;

        Path supplierPath = Paths.get(supplierFile);
        if (Files.exists(supplierPath)) {
            fileLines = Files.readAllLines(supplierPath);
            for (int i = 0; i < fileLines.size(); i++) {
                if (fileLines.get(i).trim().equals(supplierUsername)) {
                    supplierFound = true;
                    int insertIndex = i + 1;
                    while (insertIndex < fileLines.size() &&
                            !fileLines.get(insertIndex).trim().isEmpty() &&
                            !isSupplierLine(fileLines.get(insertIndex))) {
                        insertIndex++;
                    }
                    fileLines.add(insertIndex, entry.toString());
                    break;
                }
            }
        }

        if (!supplierFound) {
            if (!fileLines.isEmpty()) fileLines.add(""); // blank line
            fileLines.add(supplierUsername);
            fileLines.add(entry.toString());
        }

        Files.write(supplierPath, fileLines, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);

        // Write to stockInventory.txt
        try (BufferedWriter stockWriter = new BufferedWriter(new FileWriter(stockFile, true))) {
            stockWriter.write(entry.toString());
            stockWriter.newLine();
        }
    }

    private boolean isSupplierLine(String line) {
        return !line.contains(",") && !line.trim().isEmpty();
    }
}
