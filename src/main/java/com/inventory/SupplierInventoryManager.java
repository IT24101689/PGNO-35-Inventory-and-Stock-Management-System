package com.inventory;

import utils.CustomStack;
import java.io.*;
import java.util.*;

public class SupplierInventoryManager extends AbstractInventoryManager<StockEntry> {
    private final Map<String, CustomStack<StockEntry>> supplierStacks;

    public SupplierInventoryManager(String supplierFile, String stockFile) throws IOException {
        super(supplierFile, stockFile);
        this.supplierStacks = new HashMap<>();
        loadInventory(); // Initial load
    }

    private void loadInventory() throws IOException {
        supplierStacks.clear(); // Clear old data before reloading
        List<String> lines = readLines();
        String currentSupplier = null;
        CustomStack<StockEntry> currentStack = null;

        for (String line : lines) {
            if (line.trim().isEmpty()) continue;

            if (!line.contains(",")) {
                currentSupplier = line;
                currentStack = new CustomStack<>();
                supplierStacks.put(currentSupplier, currentStack);
            } else if (currentSupplier != null) {
                StockEntry entry = StockEntry.fromString(line);
                currentStack.push(entry);
            }
        }
    }

    /**
     * Call this to force reload inventory from file (e.g. after app restart).
     */
    public void reloadInventory() throws IOException {
        loadInventory();
    }

    @Override
    public void addStock(String supplierUsername, StockEntry entry) throws IOException {
        CustomStack<StockEntry> stack = supplierStacks.computeIfAbsent(
                supplierUsername,
                k -> new CustomStack<>()
        );

        stack.push(entry);
        saveInventoryToFile();
        appendToStockFile(entry.toString());
    }

    void saveInventoryToFile() throws IOException {
        List<String> lines = new ArrayList<>();

        for (Map.Entry<String, CustomStack<StockEntry>> entry : supplierStacks.entrySet()) {
            lines.add(entry.getKey());

            for (StockEntry item : entry.getValue().getRemainingItems()) {
                lines.add(item.toString());
            }

            lines.add("");
        }

        writeLines(lines);
    }

    public CustomStack<StockEntry> getSupplierStack(String supplierUsername) {
        return supplierStacks.get(supplierUsername);
    }
}
