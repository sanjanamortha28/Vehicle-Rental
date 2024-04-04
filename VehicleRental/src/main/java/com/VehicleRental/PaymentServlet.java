package com.VehicleRental;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/payments")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = null;
        HttpSession session = request.getSession();

        // Retrieve form parameters
        String paymentID = request.getParameter("paymentID");
        String userIDPayment = request.getParameter("userIDPayment");
        String bookingID = request.getParameter("bookingID");
        String paymentAmount = request.getParameter("paymentAmount");
        String cardNumber = request.getParameter("cardNumber");
        String cvv = request.getParameter("cvv");
        String paymentMode = request.getParameter("paymentMode");
        String paymentDateTime = request.getParameter("paymentDateTime");
        String paymentMethod = request.getParameter("paymentMethod");
        //String paymentStatus = request.getParameter("paymentStatus");

        // Assuming you have appropriate methods in your MongoCloud class
        MongoCloud mongoInstance = new MongoCloud("vehicle", "payment");
        if(paymentMode.equals("Initial Payment")) {
        	paymentAmount="200$";
        }
        
        // Handle your MongoDB operations here
        if (mongoInstance.addPayment(userIDPayment, bookingID, paymentAmount,cardNumber,cvv, paymentMode, paymentDateTime,
                paymentMethod)) {
            dispatcher = request.getRequestDispatcher("home.jsp");
            request.setAttribute("status", "paymentsuccess");
        } else {
            dispatcher = request.getRequestDispatcher("home.jsp");
            request.setAttribute("status", "paymentfailed");
        }

        dispatcher.forward(request, response);
    }
}
