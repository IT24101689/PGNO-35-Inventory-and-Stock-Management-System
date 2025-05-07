package com.inventory;

import utils.CustomStack;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RemoveSupplierItemServlet")
public class RemoveSupplierItemServlet extends HttpServlet {
    private static final String INVENTORY_FILE = "C:\\Users\\USER\\Desktop\\inventory\\Supplier_Management\\src\\main\\webapp\\suppliersInventory.txt";
    private static final String REMOVED_ITEM_FILE = "C:\\Users\\USER\\Desktop\\inventory\\Supplier_Management\\src\\main\\webapp\\supplierRemovedItem.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("supplierUsername");

        if (username == null) {
            response.sendRedirect("supplierLogin.jsp");
            return;
        }

        List<String> lines = Files.readAllLines(Paths.get(INVENTORY_FILE));
        List<String> updatedLines = new ArrayList<>();
        Map<String, List<String>> userItems = new LinkedHashMap<>();
        String currentUser = null;

        // Read inventory and categorize users
        for (String line : lines) {
            if (line.trim().isEmpty()) continue;

            if (!line.contains(",")) {
                currentUser = line;
                userItems.put(currentUser, new ArrayList<>());
            } else if (currentUser != null) {
                userItems.get(currentUser).add(line);
            }
        }

        if (!userItems.containsKey(username)) {
            response.sendRedirect("supplierDashboard.jsp");
            return;
        }

        List<String> items = userItems.get(username);

        // If the user has items, remove the last one
        if (!items.isEmpty()) {
            String lastItem = items.get(items.size() - 1);
            appendToRemovedFile(username, lastItem);

            // Remove the last item
            items.remove(items.size() - 1);
            userItems.put(username, items);

            // Update the inventory file
            for (Map.Entry<String, List<String>> entry : userItems.entrySet()) {
                if (!entry.getKey().equals(username)) {
                    updatedLines.add(entry.getKey());
                    updatedLines.addAll(entry.getValue());
                    updatedLines.add("");
                }
            }

            updatedLines.add(username);
            updatedLines.addAll(userItems.get(username));
            Files.write(Paths.get(INVENTORY_FILE), updatedLines, StandardOpenOption.WRITE, StandardOpenOption.TRUNCATE_EXISTING);
        }

        response.sendRedirect("supplierDashboard.jsp");
    }

    private void appendToRemovedFile(String username, String removedItem) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(REMOVED_ITEM_FILE, true))) {
            writer.write(username);
            writer.newLine();
            writer.write(removedItem);
            writer.newLine();
            writer.newLine();
        }
    }
}
