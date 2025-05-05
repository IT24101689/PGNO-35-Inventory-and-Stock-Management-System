package com.inventory;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginSelectionServlet")
public class LoginSelectionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("role");

        if ("admin".equals(role)) {
            response.sendRedirect("adminLogin.jsp");
        } else if ("supplier".equals(role)) {
            response.sendRedirect("supplierLogin.jsp");
        } else if ("user".equals(role)) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("index.jsp"); // Redirect to home if role is not recognized
        }
    }
}
