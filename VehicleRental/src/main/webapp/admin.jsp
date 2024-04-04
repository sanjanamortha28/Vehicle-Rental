<%@page import="com.mongodb.MongoClientURI" %>
<%@page import="com.mongodb.client.FindIterable" %>
<%@page import="com.mongodb.client.MongoCollection" %>
<%@page import="com.mongodb.client.MongoDatabase" %>
<%@page import="com.mongodb.MongoClient" %>
<%@page import="com.mongodb.client.MongoCursor" %>
<%@page import="org.bson.Document" %>
<%@page import="com.VehicleRental.MongoCloud" %>
<%@page import="java.util.*" %>

<%@page import="com.mongodb.MongoClientURI" %>
    
<%
   response.setHeader("Cache-control","no-cache");
   response.setHeader("Cache-control","no-store");
   response.setHeader("Pragma","no-cache");
   response.setDateHeader("Expire",0);
 
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Rental Application</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            padding: 20px;
            background-color: #1a1a1a;
            color: #ffffff;
        }

        .container {
            width: 80%;
            height: 80%;
            margin-top: 2px;
            background-color: #2c2c2c;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }

        h1 {
            color: red;
        }

        .nav-tabs .nav-link {
            color: #ffffff;
        }

        .nav-tabs .nav-link.active {
            background-color: #343a40;
            color: #ffffff;
        }

        .tab-content {
            background-color: #2c2c2c;
            padding: 20px;
            border: 1px solid #1a1a1a;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }

        /* Optional: Adjust the table style as needed */
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            color: #ffffff;
        }

        th,
        td {
            border: 1px solid #1a1a1a;
            padding: 8px;
            text-align: left;
        }

        /* Arrange form and table side by side */
        #vehicles-form-container,
        #vehicles-table-container,
        #bookings-form-container,
        #bookings-table-container,
        #payments-form-container,
        #payments-table-container,
        #feedback-form-container,
        #feedback-table-container {
            vertical-align: top;
            width: 98%;
            margin-right: 2%;
        }

        /* Dark mode for modals */
        .modal-content {
            background-color: #2c2c2c;
            color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }

        .modal-header {
            background-color: #343a40;
            color: #ffffff;
            border-bottom: 1px solid #1a1a1a;
        }

        /* Dark mode for the close button in modals */
        .modal-header button.close {
            color: #ffffff;
        }

        /* Dark mode for the close button in modals when hovering */
        .modal-header button.close:hover {
            color: #ffffff;
            opacity: 0.8;
        }

        /* Dark mode for modal body */
        .modal-body {
            background-color: #2c2c2c;
        }

        /* Dark mode for form inputs */
        .form-control {
            background-color: #343a40;
            color: #ffffff;
            border: 1px solid #1a1a1a;
        }

        /* Dark mode for form buttons */
        .btn-primary {
            background-color: #343a40;
            border-color: #343a40;
        }

        /* Dark mode for the logout button */
        #logout-btn {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
        }
    </style>
</head>

<body>

    <div class="container">
        <h1>ADMIN PANEL<a href="signoutservlet" class="btn btn-danger" style="float: right;" id="logout-btn">Logout</a></h1>

        <!-- Nav tabs -->
        <ul class="nav nav-tabs" id="myTabs">

            <li class="nav-item">
                <a class="nav-link active" id="bookings-tab" data-toggle="tab" href="#bookings">Bookings Collection</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="payments-tab" data-toggle="tab" href="#payments">Payments Collection</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="feedback-tab" data-toggle="tab" href="#feedback">Feedback Collection</a>
            </li>
        </ul>
        <div class="tab-content">
            <!-- Vehicles Collection Tab -->


            <!-- Bookings Collection Tab -->
            <div class="tab-pane fade show active" id="bookings">

                <div id="bookings-table-container" class="table-responsive">
                    <table id="bookings-table" class="table">
                        <!-- Booking table content here -->
                         <thead>
          <tr>
            <th>BookingID</th>
            <th>UserID</th>
            <th>VehicleID</th>
            <th>PickupLocation</th>
            <th>Drop-offLocation</th>
            <th>Total Cost</th>
            <th>Status</th>
            <th>Payments</th>
          </tr>
        </thead>
        <tbody>
          <!-- Placeholder data, replace with actual data -->
      <%                
      MongoClientURI URI = new MongoClientURI("mongodb+srv://prabhu:123@cluster0.qycnevx.mongodb.net/?retryWrites=true&w=majority");
      MongoClient mongoClient = new MongoClient(URI); 
    MongoDatabase db = mongoClient.getDatabase("vehicle");
    MongoCollection<Document> collection = db.getCollection("booking");
    MongoCursor<Document> cursor = collection.find().iterator();
    int i = 1;

    while (cursor.hasNext()) {
        Document doc = cursor.next();
        // Uncomment the following lines if you want to filter by userID
  

%>
<tr>
    <td><%=doc.getString("bookingID") %></td>
    <td><%=doc.getString("UserID") %></td>   
    <td><%=doc.getString("VehicleID") %></td> 
    <td><%=doc.getString("PickupLocation") %></td>
    <td><%=doc.getString("DropoffLocation") %></td>
    
    <td><%=doc.getString("totalCost") %></td>
    
    <td><%=doc.getString("BookingStatus") %></td>
 <td>
        <button class="btn btn-primary" data-toggle="modal" data-target="#popupFormModal<%= i %>">
            Billing
        </button>
    </td>
</tr>

                            <!-- Add a modal popup form for each row -->
                            <div class="modal" id="popupFormModal<%= i %>">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <!-- Modal Header -->
                                        <div class="modal-header">
                                            <h4 class="modal-title">Billing <%= doc.getString("bookingID") %></h4>
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        </div>
                                        <!-- Modal Body -->
                                        <div class="modal-body">
                                            <!-- Your form content goes here -->
                                            <!-- Example: -->
                                            <form  method="POST" class="form login" action="miles">
                                                
											 <input type="hidden" id="bookingID" name ="bookingID" value="<%= doc.getString("bookingID") %>">
											
											    <div class="form-group">
											        <label for="startDateTime">Start Date and Time:</label>
											        <input type="datetime-local" style="color:black;" class="form-control" id="startDateTime" name="startDateTime" value=<%= doc.getString("StartDateTime") %> readonly>
											    </div>
											     <div class="form-group">
											        <label for="endDateTime">End Date and Time:</label>
											        <input type="datetime-local" class="form-control" id="endDateTime" name="endDateTime" value=<%= doc.getString("EndDateTime") %> required>
											    </div>
											    <div class="form-group">
                                                    <label for="exampleInput">Miles (if more than 1 day):</label>
                                                    <input type="text" class="form-control" id="miles" name ="miles"
                                                        placeholder="Enter miles" required>
                                                </div>
                                                <button type="submit" class="btn btn-primary">Submit</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
<%
    i++;
}
%>

        </tbody>
                    </table>
                </div>
            </div>

            <!-- Payments Collection Tab -->
            <div class="tab-pane fade" id="payments">

                <div id="payments-table-container" class="table-responsive">
                    <table id="payments-table" class="table">
        <thead>
          <tr>
            <th>PaymentID</th>
            <th>BookingID</th>
            <th>PaymentAmount</th>
            <th>PaymentDateTime</th>
            <th>PaymentMethod</th>
            <th>PaymentMode</th>
          </tr>
        </thead>
        <tbody>
        
             <%                
                                     MongoCollection<Document>  collection2= db.getCollection("payment");
       	         MongoCursor < Document > cursor2 = collection2.find().iterator();
       	            int i2=1;
       	      
       	         while (cursor2.hasNext()) {
       	        	Document doc2 = cursor2.next();
       	        	// if(!((String)doc.getString("userID")).equals((String)session.getAttribute("email"))){
       	        		// System.out.println((String)doc.getString("UserName")+" "+(String)session.getAttribute("email"));
       	        		//System.out.println((String)doc.getString("UserName") != (String)session.getAttribute("email"));
       	        	// continue;
       	        	 //}
       	        	 
       	        	
                     %>
                  
                  
                  <tr>
                         
                          
                     <td><%=i2++ %> </td>
                     <td><%=doc2.getString("paymentID") %></td>   
                     
                        <td><%=doc2.getString("bookingID") %> </td> 
                        <td><%=doc2.getString("paymentAmount") %> </td>
                        <td><%=doc2.getString("paymentDateTime") %></td>
                        <td><%=doc2.getString("paymentMethod") %> </td>
                        <td><%=doc2.getString("paymentMode") %> </td>   
                          
                    
                  </tr>
                  <% 
                  
       	         }
                  %>
        
        
        
        
        
        
        
        
        

        </tbody>
      </table>
                </div>
            </div>

            <!--

 Feedback Collection Tab -->
            <div class="tab-pane fade" id="feedback">

                <div id="feedback-table-container" class="table-responsive">
                    <table id="feedback-table" class="table">
        <thead>
          <tr>
            <th>FeedbackID</th>
            <th>UserID</th>
            <th>VehicleID</th>
            <th>FeedbackDesc</th>
            <th>Rating</th>
          </tr>
        </thead>
        <tbody>
          <!-- Placeholder data, replace with actual data -->
     <%                
    MongoCollection<Document> collection1 = db.getCollection("feedback");
    MongoCursor<Document> cursor1 = collection1.find().iterator();
    int i1 = 1;

    while (cursor1.hasNext()) {
        Document doc1 = cursor1.next();
        // Uncomment the following lines if you want to filter by userID
        // if(!((String)doc.getString("userID")).equals((String)session.getAttribute("email"))){
        //     continue;
        // }

%>
<tr>
    <td><%=doc1.getString("feedbackID") %></td>
    <td><%=doc1.getString("userIDFeedback") %></td>   
    <td><%=doc1.getString("vehicleIDFeedback") %></td> 
    <td><%=doc1.getString("feedbackDesc") %></td>
<td><%=doc1.getString("rating") %></td>

</tr>
<%
    }
%>

        </tbody>
      </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Data Modals -->
    <div class="modal" id="addDataModalVehicles">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Add Data to Vehicles</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <!-- Modal Body -->
                <div class="modal-body">
                    <!-- Vehicle data input form goes here -->
                    <form>
                        <div class="form-group">
                            <label for="vehicleModel">Vehicle Model</label>
                            <input type="text" class="form-control" id="vehicleModel" placeholder="Enter Vehicle Model">
                        </div>
                        <!-- Add more fields as needed -->
                        <button type="button" class="btn btn-primary">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal" id="addDataModalBookings">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Add Data to Bookings</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <!-- Modal Body -->
                <div class="modal-body">
                    <!-- Booking data input form goes here -->
                    <form>
                        <div class="form-group">
                            <label for="bookingUser">User ID</label>
                            <input type="text" class="form-control" id="bookingUser" placeholder="Enter User ID">
                        </div>
                        <!-- Add more fields as needed -->
                        <button type="button" class="btn btn-primary">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal" id="addDataModalPayments">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Add Data to Payments</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

            </div>
        </div>
    </div>

    <div class="modal" id="addDataModalFeedback">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Add Data to Feedback</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script>var status = document.getElementById("status").value;
if (status == "successmiles") {
    // Code to execute if the condition is true
    alert("bill updated", "success");
} else if(status=="faileda"){
    // Code to execute if the condition is false
    alert("failed", "failed");
}
</script>
</body>



</html>