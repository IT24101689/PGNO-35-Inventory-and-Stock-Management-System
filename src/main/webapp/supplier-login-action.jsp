<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>

<%
    // Get login details from form
    String username = request.getParameter("supplier-username");
    String password = request.getParameter("supplier-password");

    // File containing supplier credentials (username:password:companyName format)
    File file = new File("C:\\Users\\paves\\OneDrive\\Pictures\\Inventory-Stock-Management-System-main\\src\\main\\webapp\\SupplierLoginCredentials.txt");
    boolean isAuthenticated = false;
    String companyName = "";

    try {
        if (file.exists()) {
            // Use try-with-resources for automatic closing
            try (BufferedReader br = new BufferedReader(new FileReader(file))) {
                String line;

                // Read each line from the file
                while ((line = br.readLine()) != null) {
                    String[] parts = line.split(":");
                    if (parts.length == 3) {
                        String storedUsername = parts[0];
                        String storedPassword = parts[1];
                        companyName = parts[2];

                        // Check if credentials match
                        if (storedUsername.equals(username) && storedPassword.equals(password)) {
                            isAuthenticated = true;
                            break;
                        }
                    }
                }
            }
        }
    } catch (IOException e) {
        response.getWriter().println("Error reading supplier details.");
    }

    // Handle authentication
    if (isAuthenticated) {
        // Store session attributes for the supplier
        session.setAttribute("supplierUsername", username);
        session.setAttribute("companyName", companyName);

        // Redirect to supplier dashboard
        response.sendRedirect("supplierDashboard.jsp");
    } else {
        // Redirect back to login with error message
        response.sendRedirect("supplierLogin.jsp?error=Invalid username or password.");
    }
%>
