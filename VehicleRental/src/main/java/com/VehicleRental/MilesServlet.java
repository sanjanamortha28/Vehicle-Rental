package com.VehicleRental;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.UpdateResult;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class AddOutletServlet
 */
@WebServlet("/miles")
public class MilesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
		MongoClientURI URI = new MongoClientURI("mongodb+srv://prabhu:123@cluster0.qycnevx.mongodb.net/?retryWrites=true&w=majority");
        MongoClient mongoClient = new MongoClient(URI); 
        MongoDatabase dbv = mongoClient.getDatabase("vehicle");
        MongoCollection<Document> collectionv = dbv.getCollection("booking");
        MongoCursor<Document> cursorv = collectionv.find().iterator();
        int iv = 1;

       

		
		RequestDispatcher dispatcher = null;
		HttpSession session = request.getSession();

		String bookingID = request.getParameter("bookingID");
        String startDateTime = request.getParameter("startDateTime");
        String endDateTime = request.getParameter("endDateTime");
        int v=0;
        int x=0;
        String miles = request.getParameter("miles");
        while (cursorv.hasNext()) {
            Document doc = cursorv.next();
            // Uncomment the following lines if you want to filter by userID
            if(((String)doc.getString("bookingID")).equals(bookingID)){
            	v=Integer.parseInt(doc.getString("VehicleID"));
            	x=Integer.parseInt(doc.getString("insurance"));

            }
             }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

        // Parse the date-time strings
        LocalDateTime dateTimeA = LocalDateTime.parse(startDateTime, formatter);
        LocalDateTime dateTimeB = LocalDateTime.parse(endDateTime, formatter);

        // Calculate the duration between the two date-time values
        Duration duration = Duration.between(dateTimeB, dateTimeA);

        // Get the difference in hours
        long hoursDifference = Math.abs(duration.toHours());
        System.out.print(hoursDifference);
        int[] vehicleRate= {50,65,70,70,55,70,65,60};
        
        double totalCost=0;
        
        if(hoursDifference<=24) {
        	totalCost = vehicleRate[v-1]+x;
        	
        }
        else {
            totalCost=vehicleRate[v-1]+0.15*Integer.parseInt(miles)+x;

        }

        Bson filter = Filters.eq("bookingID", bookingID);

     // Define the update document to set the new values
     Bson update = Updates.combine(
             Updates.set("totalCost",Double.toString(totalCost)),
             Updates.set("BookingStatus", "Completed") // You can set the appropriate status based on your business logic
     );

     // Update the document in the collection
     UpdateResult updateResult = collectionv.updateOne(filter, update);

     // Check the result of the update operation
     if (updateResult.getModifiedCount() > 0) {
         System.out.println("Booking updated successfully");
     } else {
         System.out.println("Booking not found or not updated");
     }
        
        
        
        
     dispatcher = request.getRequestDispatcher("admin.jsp");
		request.setAttribute("status", "successmiles");
		dispatcher.forward(request, response);

		
	}

}
