package com.inventory;

import java.io.*;
import java.util.*;

public class SupplierLoginManager {
    private String credentialsFile;

    public SupplierLoginManager(String credentialsFile) {
        this.credentialsFile = credentialsFile;
    }

    public Supplier validateLogin(String inputUsername, String inputPassword) throws IOException {
        File file = new File(credentialsFile);
        if (!file.exists()) return null;

        BufferedReader br = new BufferedReader(new FileReader(file));
        String line;
        String username = null, password = null, companyName = null, category = null;

        while ((line = br.readLine()) != null) {
            if (line.startsWith("name:")) {
                username = line.split(":", 2)[1].trim();
            } else if (line.startsWith("password:")) {
                password = line.split(":", 2)[1].trim();
            } else if (line.startsWith("companyName:")) {
                companyName = line.split(":", 2)[1].trim();
            } else if (line.startsWith("category:")) {
                category = line.split(":", 2)[1].trim();
            } else if (line.startsWith("-")) {
                // End of one block — validate
                if (username != null && password != null &&
                        username.equals(inputUsername) && password.equals(inputPassword)) {
                    br.close();
                    return new Supplier(username, password, companyName, category);
                }
                // Reset
                username = password = companyName = category = null;
            }
        }
        br.close();
        return null;
    }
}
