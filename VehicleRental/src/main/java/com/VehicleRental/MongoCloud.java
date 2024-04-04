package com.VehicleRental;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.bson.Document;

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
import jakarta.servlet.http.HttpSession;

public class MongoCloud {

	MongoClient mongoClient;
	DB database;
	DBCollection   collection;
	MongoDatabase mongoDatabase;
	MongoCollection<Document>  mongoCollection;

	MongoCloud(String databaseName,String collectionName){
		MongoClientURI URI=new MongoClientURI("mongodb+srv://prabhu:123@cluster0.qycnevx.mongodb.net/?retryWrites=true&w=majority");
		mongoClient = new MongoClient(URI);
		
		database = mongoClient.getDB(databaseName);
		collection = database.getCollection(collectionName);
		mongoDatabase = mongoClient.getDatabase(databaseName);
		mongoCollection= mongoDatabase.getCollection(collectionName);
		
	}
	
	boolean insert1( String cname,String number,String email,String password) {
		
		BasicDBObject whereQuery = new BasicDBObject();
	    whereQuery.put("email", email);
	   
	  
	    DBCursor cursor = collection.find(whereQuery);
	    while (cursor.hasNext()) {
	        return false;
	    }
	   
		
		
	    
		 Document document =new Document("email",email); 
		 document.append("password",password);
		 document.append("cname",cname); 
		 document.append("number",number);
		       mongoCollection.insertOne(document);
		
		 
		return true;
		
	}
	
	
boolean insert( String uname,String password,String email,String phone,String flatno,String lease) {
		
		BasicDBObject whereQuery = new BasicDBObject();
	    whereQuery.put("customerid", uname);
	   
	  
	    DBCursor cursor = collection.find(whereQuery);
	    while (cursor.hasNext()) {
	        return false;
	    }
	    System.out.println(uname);
	 
		
		
	    
		 Document document =new Document("Customerid",uname); 
		 document.append("Password",password);
		 document.append("Email",email); 
		 document.append("PhoneNumber",phone);
		 document.append("FlatNumber", flatno);
		 document.append("reset", 0);
	
			

	       mongoCollection.insertOne(document);
		
		 
		return true;
		
	}
	
	


	

	
	
	
	
	
	
	
	
	
	
	
	void insertIntoPaymentsData(String userName,String bill,String ename,String paymenttype,String cnumber,String
			rcnumber,String edate,String CVV) {
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");  
		   LocalDateTime now = LocalDateTime.now();
		   DateTimeFormatter dtf1 = DateTimeFormatter.ofPattern("HH:mm:ss");  
		   LocalDateTime now1 = LocalDateTime.now(); 
		   Document document =new Document("Customerid",userName);
		 document.append("PaymentId","Payment-"+dtf.format(now)+dtf1.format(now1));
		 document.append("PaymentType", paymenttype);
		 document.append("bill",bill);
		 document.append("cnumber",cnumber);
		 document.append("rcnumber",rcnumber);
		 document.append("ename",ename);
		 document.append("edate",edate);
		 document.append("CVV",CVV);		 document.append("PaymentStatus","0");

		 document.append("Date", dtf.format(now));
		 document.append("Time", dtf1.format(now1));
		 
		


		 mongoCollection.insertOne(document);
		
		
	}
	
	
	Boolean booking(String bookingID,String userID, String vehicleID,String pickupLocation, 
			String dropoffLocation,String startDateTime, String endDateTime, String totalCost,String bookingStatus,String insurance) {
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");  
		   LocalDateTime now = LocalDateTime.now();
		   DateTimeFormatter dtf1 = DateTimeFormatter.ofPattern("HH:mm:ss");  
		   LocalDateTime now1 = LocalDateTime.now(); 
		 Document document=new Document().append("bookingID","Booking-"+dtf.format(now)+dtf1.format(now1))
	                .append("UserID", userID)
	                .append("VehicleID", vehicleID)
	                .append("PickupLocation", pickupLocation)
	                .append("DropoffLocation", dropoffLocation)
	                .append("StartDateTime", startDateTime)
	                .append("EndDateTime", endDateTime)
	                .append("totalCost", totalCost)
	                .append("insurance", insurance)
	                .append("BookingStatus", bookingStatus);

	        // Insert the document into the collection
	        mongoCollection.insertOne(document);
		return true;
		
	}
	
	
	
	
	
	
	
	
	
	void insertIntoHelper(String pname, String quantity,String datetime) {
		
		
		 Document document =new Document("pname",pname);
		 document.append("quantity", quantity);
		 document.append("datetime", datetime);
		 mongoCollection.insertOne(document);
		
		
	}
	
	
	void insertIntoRequests(String reqid,String name,String location,String date,String etype,String kspeaker,String topic,String members,String comment,String time1) {

		
		 Document document =new Document("EventId",reqid);
		 document.append("name",name);
		 document.append("location",location);

		 document.append("date", date);
		 document.append("etype", etype);
		 document.append("kspeaker", kspeaker);

		 document.append("topic", topic);
		 document.append("members", members);
		 document.append("comment",comment);
		 document.append("time",time1);

		 mongoCollection.insertOne(document);
		
		
	}
	void insertIntoComplaints(String email, String feedback,String cevent,String desc) {
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");  
		   LocalDateTime now = LocalDateTime.now();
		   DateTimeFormatter dtf1 = DateTimeFormatter.ofPattern("HH:mm:ss");  
		   LocalDateTime now1 = LocalDateTime.now(); 
		
		 Document document =new Document("Customerid",email);
		 document.append("cevent",cevent);
		 document.append("feedback", feedback);
		 document.append("Description",desc);
		 document.append("Complaintid","Complaint-"+dtf.format(now)+dtf1.format(now1));
		 document.append("ComplaintStatus","0");
		 mongoCollection.insertOne(document);
		
		
	}
	
	String validateUser(String email,String password) {
		{
		BasicDBObject query = new BasicDBObject();
		query.put("OutletID", email);
		query.put("Password", password);
		query.put("role", "admin");
		
		DBObject result = collection.findOne(query);
		if(result!=null)
			return "admin";
		}
		{
			BasicDBObject query = new BasicDBObject();
			query.put("OutletID", email);
			query.put("Password", password);
			query.put("role", "user");
			
			DBObject result = collection.findOne(query);
			if(result!=null) {
				System.out.println(result);
				return "user";
			}
			}
		
		return "null";
	}
	
	
	
	String validateCustomer(String email,String password,HttpSession session) {
		{
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");  
			   LocalDateTime now = LocalDateTime.now();
		BasicDBObject query = new BasicDBObject();
		if(email.equals("admin@gmail.com") && password.equals("1234"))
		{
			return "admin";
		}
		query.put("email", email);
		query.put("password", password);
		DBObject result = collection.findOne(query);
		
		if(result==null)
		{
			return "null";
		}
		else {
			return "customer";
		}}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	String validateAdmin(String email,String password) {
		{System.out.print("admin");
		BasicDBObject query = new BasicDBObject();
		query.put("HeadQuatersID", email);
		query.put("Password", password);
		
		DBObject result = collection.findOne(query);
		if(result!=null)
			return "admin";
		}
		
		return "null";
	}

	public boolean addPayment(String userIDPayment, String bookingID, String paymentAmount,
			String cardNumber, String cvv,String paymentMode, String paymentDateTime, String paymentMethod) {
	    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	    LocalDateTime now = LocalDateTime.now();
	    DateTimeFormatter dtf1 = DateTimeFormatter.ofPattern("HH:mm:ss");
	    LocalDateTime now1 = LocalDateTime.now();

	    Document document = new Document().append("paymentID", "Payment-" + dtf.format(now) + dtf1.format(now1))
	            .append("userID", userIDPayment)
	            .append("bookingID", bookingID)
	            .append("paymentAmount", paymentAmount)
	            .append("paymentMode", paymentMode)
	            .append("paymentDateTime", dtf.format(now) +" "+ dtf1.format(now1))
	            .append("paymentMethod", paymentMethod);

	    // Insert the document into the collection
	    mongoCollection.insertOne(document);
	    return true;
	}

	public boolean addFeedback(String feedbackID, String userIDFeedback, String vehicleIDFeedback, String feedbackDesc,
	        String rating) {
	    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	    LocalDateTime now = LocalDateTime.now();
	    DateTimeFormatter dtf1 = DateTimeFormatter.ofPattern("HH:mm:ss");
	    LocalDateTime now1 = LocalDateTime.now();

	    Document document = new Document().append("feedbackID", "Feedback-" + dtf.format(now) + dtf1.format(now1))
	            .append("userIDFeedback", userIDFeedback)
	            .append("vehicleIDFeedback", vehicleIDFeedback)
	            .append("feedbackDesc", feedbackDesc)
	            .append("rating", rating);

	    // Insert the document into the collection
	    mongoCollection.insertOne(document);
	    return true;
	}


	
	
	
}
