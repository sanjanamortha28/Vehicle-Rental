package com.VehicleRental;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Servlet implementation class AddOutletServlet
 */
@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
		RequestDispatcher dispatcher = null;
		HttpSession session = request.getSession();

		String bookingID = request.getParameter("bookingID");
        String userID = request.getParameter("userID");
        String vehicleID = request.getParameter("vehicleID");
        String pickupLocation = request.getParameter("pickupLocation");
        String dropoffLocation = request.getParameter("dropoffLocation");
        String startDateTime = request.getParameter("startDateTime");
        String endDateTime = request.getParameter("endDateTime");
        String bookingStatus = "In Pocession";
        String x = request.getParameter("insurance");
        String insurance="";
        if(x.equals("0")) {
        	insurance="0";
        }
        else if(x.equals("1")) {
        	insurance="35";
        }
        else {
        	insurance="55";
        }
        
     
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

        // Parse the date-time strings
        LocalDateTime dateTimeA = LocalDateTime.parse(startDateTime, formatter);
        LocalDateTime dateTimeB = LocalDateTime.parse(endDateTime, formatter);

        // Calculate the duration between the two date-time values
        Duration duration = Duration.between(dateTimeB, dateTimeA);

        // Get the difference in hours
        long hoursDifference = Math.abs(duration.toHours());
        int[] vehicleRate= {50,65,70,70,55,70,65,60};
        int totalCost=0;
        if(hoursDifference<=24) {
        	totalCost = vehicleRate[Integer.parseInt(vehicleID)-1];
        }
        
        MongoCloud mongoInstance = new MongoCloud("vehicle", "booking");

    	MongoClientURI URI = new MongoClientURI("mongodb+srv://prabhu:123@cluster0.qycnevx.mongodb.net/?retryWrites=true&w=majority");
        MongoClient mongoClient = new MongoClient(URI); 
        MongoDatabase dbv = mongoClient.getDatabase("vehicle");
        MongoCollection<Document> collectionv = dbv.getCollection("vehicles");

        MongoCollection<Document> collection = dbv.getCollection("booking");
        MongoCursor<Document> cursorv = collectionv.find().iterator();

        MongoCursor<Document> cursor = collection.find().iterator();

        boolean isOverlap = false;

        LocalDateTime s = LocalDateTime.parse(startDateTime, formatter);
        LocalDateTime e = LocalDateTime.parse(endDateTime, formatter);
        int iv = 1;
        while (cursor.hasNext()) {
            Document doc = cursor.next();
            if (doc.getString("VehicleID").equals(vehicleID)) {
            	System.out.println(vehicleID);
                System.out.print(doc.getString("VehicleID"));

            // Uncomment the following lines if you want to filter by userID
            if ((dateTimeA.isAfter(s) && dateTimeA.isBefore(e)) ||
                    (dateTimeB.isAfter(s) && dateTimeB.isBefore(e)) ||
                    (dateTimeA.isEqual(s) || dateTimeB.isEqual(e))) {
            	System.out.println("defeteced");
                    isOverlap = true;
                    break; 
            }
             }
        }

        // Compare the two LocalDateTime objects
        if (e.isBefore(s)) {
        	
            System.out.println("Start date is before end date.");
            dispatcher = request.getRequestDispatcher("home.jsp");
   		request.setAttribute("status", "failed");
        }
        else if(isOverlap) {
            System.out.println("Overlap detected. Cannot create a new booking.");
            dispatcher = request.getRequestDispatcher("home.jsp");
       		request.setAttribute("status", "overlap");
        }
        else if (mongoInstance.booking(bookingID, userID, vehicleID,pickupLocation, 
        		dropoffLocation,startDateTime, endDateTime, "0",bookingStatus,insurance)) {
        	dispatcher = request.getRequestDispatcher("home.jsp");
        	 System.out.print("+++++++++++++");
    		request.setAttribute("status", "success");
        }
        else {
        	dispatcher = request.getRequestDispatcher("signin.jsp");
    		request.setAttribute("status", "failed");
        }
		
        
        
        //System.out.println("test");
		
		dispatcher.forward(request, response);

		
	}

}
