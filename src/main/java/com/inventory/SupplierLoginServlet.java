package com.inventory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/SupplierLoginServlet")
public class SupplierLoginServlet extends HttpServlet {
    private static final String SUPPLIER_CREDENTIALS_FILE =
            "C:\\Users\\USER\\Desktop\\inventory\\Supplier_Management\\src\\main\\webapp\\SupplierLoginCredentials.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputUsername = request.getParameter("username").trim();
        String inputPassword = request.getParameter("password").trim();

        HttpSession session = request.getSession();

        SupplierLoginManager manager = new SupplierLoginManager(SUPPLIER_CREDENTIALS_FILE);

        try {
            Supplier supplier = manager.validateLogin(inputUsername, inputPassword);


            if (supplier != null) {
                session.setAttribute("supplierUsername", supplier.getUsername());
                session.setAttribute("companyName", supplier.getCompanyName());
                session.setAttribute("category", supplier.getCategory());
                session.removeAttribute("error");
                response.sendRedirect("supplierDashboard.jsp");
            } else {
                session.setAttribute("error", "Invalid credentials. Please try again.");
                response.sendRedirect("supplierLogin.jsp");
            }

        } catch (IOException e) {
            session.setAttribute("error", "Error reading supplier database.");
            response.sendRedirect("supplierLogin.jsp");
            e.printStackTrace();
        }
    }
}
