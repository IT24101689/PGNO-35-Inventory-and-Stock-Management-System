<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>

<%
    // Get registration details from form
    String companyName = request.getParameter("company-name");
    String username = request.getParameter("supplier-username");
    String password = request.getParameter("supplier-password");
    String confirmPassword = request.getParameter("confirm-supplier-password");
    String itemCategory = request.getParameter("item-category");

    // Validate password match
    if (!password.equals(confirmPassword)) {
        // Redirect back with error message if passwords don't match
        response.sendRedirect("supplierRegister.jsp?error=Passwords do not match!");
        return;
    }

    // File to store supplier details
    File file = new File("C:\\Users\\paves\\OneDrive\\Pictures\\Inventory-Stock-Management-System-main\\src\\main\\webapp\\SupplierLoginCredentials.txt");
    BufferedWriter bw = null;

    try {
        if (!file.exists()) {
            file.createNewFile();
        }

        bw = new BufferedWriter(new FileWriter(file, true)); // Append mode

        // Write new supplier details to the file
        bw.write("name:" + username + "\n");
        bw.write("password:" + password + "\n");
        bw.write("companyName:" + companyName + "\n");
        bw.write("category:" + itemCategory + "\n");
        bw.write("------------------------------------------------------\n");
        bw.newLine();

        // Redirect to supplier login page
        response.sendRedirect("supplierLogin.jsp?message=Registration successful. Please log in.");
    } catch (IOException e) {
        response.getWriter().println("Error saving supplier registration details: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (bw != null) {
            try {
                bw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
%>
