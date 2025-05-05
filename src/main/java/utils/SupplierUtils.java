package utils;

import java.io.*;
import java.nio.file.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class SupplierUtils {
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    // Main merge sort method
    public static void mergeSort(List<String[]> items, int left, int right) {
        if (left < right) {
            int mid = (left + right) / 2;
            mergeSort(items, left, mid);
            mergeSort(items, mid + 1, right);
            merge(items, left, mid, right);
        }
    }

    // Merge logic (using expiry date at index 6)
    private static void merge(List<String[]> items, int left, int mid, int right) {
        List<String[]> leftList = new ArrayList<>(items.subList(left, mid + 1));
        List<String[]> rightList = new ArrayList<>(items.subList(mid + 1, right + 1));

        int i = 0, j = 0, k = left;

        while (i < leftList.size() && j < rightList.size()) {
            try {
                Date leftDate = dateFormat.parse(leftList.get(i)[6]);
                Date rightDate = dateFormat.parse(rightList.get(j)[6]);

                if (leftDate.compareTo(rightDate) <= 0) {
                    items.set(k++, leftList.get(i++));
                } else {
                    items.set(k++, rightList.get(j++));
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        while (i < leftList.size()) {
            items.set(k++, leftList.get(i++));
        }

        while (j < rightList.size()) {
            items.set(k++, rightList.get(j++));
        }
    }

    // Read supplier stock entries from file
    public static List<String[]> getSupplierStockLines(String supplierUsername, String filePath) throws IOException {
        List<String[]> stockLines = new ArrayList<>();
        List<String> allLines = Files.readAllLines(Paths.get(filePath));
        boolean found = false;

        for (String line : allLines) {
            if (line.equals(supplierUsername)) {
                found = true;
                continue;
            }
            if (found) {
                if (line.trim().isEmpty()) break;
                String[] parts = line.split(",");
                if (parts.length >= 7) {
                    stockLines.add(parts);
                }
            }
        }

        return stockLines;
    }

    // Get expiry status for a stock item (used in JSP)
    public static String getExpiryStatus(String expiryDateStr) {
        try {
            Date today = new Date();
            Date expiryDate = dateFormat.parse(expiryDateStr);
            long diff = expiryDate.getTime() - today.getTime();
            long days = diff / (1000 * 60 * 60 * 24);

            if (expiryDate.before(today)) return "expired";
            else if (days <= 7) return "soon-expire";
            else return "normal";

        } catch (ParseException e) {
            return "unknown";
        }
    }
}
