package com.VehicleRental;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = null;
        HttpSession session = request.getSession();
        String[] ratings = {
                "worst",
                "bad",
                "satisfied",
                "good",
                "excellent"
            };
        // Retrieve form parameters
        String feedbackID = request.getParameter("feedbackID");
        String userIDFeedback = request.getParameter("userIDFeedback");
        String vehicleIDFeedback = request.getParameter("vehicleID");
        String feedbackDesc = request.getParameter("feedbackDesc");
        String rating = request.getParameter("rating");

        // Assuming you have appropriate methods in your MongoCloud class
        MongoCloud mongoInstance = new MongoCloud("vehicle", "feedback");

        // Handle your MongoDB operations here
        if (mongoInstance.addFeedback(feedbackID, userIDFeedback, vehicleIDFeedback, feedbackDesc, ratings[Integer.parseInt(rating)-1])) {
            dispatcher = request.getRequestDispatcher("home.jsp");
            request.setAttribute("status", "feedbacksuccess");
        } else {
            dispatcher = request.getRequestDispatcher("home.jsp");
            request.setAttribute("status", "feedbackfailed");
        }

        dispatcher.forward(request, response);
    }
}
