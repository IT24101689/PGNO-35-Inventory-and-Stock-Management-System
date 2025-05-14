package com.inventory;

import java.io.*;
import java.nio.file.*;
import java.util.*;

public abstract class AbstractInventoryManager<T> {
    protected final String inventoryFile;
    protected final String stockFile;

    public AbstractInventoryManager(String inventoryFile, String stockFile) {
        this.inventoryFile = inventoryFile;
        this.stockFile = stockFile;
    }

    protected List<String> readLines() throws IOException {
        Path path = Paths.get(inventoryFile);
        if (!Files.exists(path)) return new ArrayList<>();
        return Files.readAllLines(path);
    }

    protected void writeLines(List<String> lines) throws IOException {
        Files.write(Paths.get(inventoryFile), lines);
    }

    protected void appendToStockFile(String line) throws IOException {
        try (BufferedWriter writer = Files.newBufferedWriter(
                Paths.get(stockFile),
                StandardOpenOption.CREATE,
                StandardOpenOption.APPEND)) {
            writer.write(line);
            writer.newLine();
        }
    }

    // Abstract methods for specific implementations
    public abstract void addStock(String key, T entry) throws IOException;
}
