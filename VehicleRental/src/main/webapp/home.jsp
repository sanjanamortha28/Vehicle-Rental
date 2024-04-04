<%@page import="com.mongodb.MongoClientURI" %>
<%@page import="com.mongodb.client.FindIterable" %>
<%@page import="com.mongodb.client.MongoCollection" %>
<%@page import="com.mongodb.client.MongoDatabase" %>
<%@page import="com.mongodb.MongoClient" %>
<%@page import="com.mongodb.client.MongoCursor" %>
<%@page import="org.bson.Document" %>
<%@page import="com.VehicleRental.MongoCloud" %>
<%@page import="java.util.*" %>
<%@page import="java.time.LocalDateTime" %>
<%@page import="java.time.format.DateTimeFormatter" %>

<%@page import="com.mongodb.MongoClientURI" %>
    
<%
   response.setHeader("Cache-control","no-cache");
   response.setHeader("Cache-control","no-store");
   response.setHeader("Pragma","no-cache");
   response.setDateHeader("Expire",0);
 
%>
    <script type="text/javascript">
    $(document).ready(function () {

        $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable({
            "scrollX": true
        });

    });

</script>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tabbed Tables</title>
  <!-- Bootstrap CSS -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha384-dV4GNfZIIYQMlprJO6DSvMZ/E+ZHYyBPov6LGRSwsb8Skv5iJw4IQCOINhhCr9p6" crossorigin="anonymous">
  
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <!-- Custom CSS -->
 <style>
 
 
 
 
  /* Custom styling for the table */
  .table {
    width: 100%;
    margin-bottom: 1rem;
    color: #212529;
  }

  .table th,
  .table td {
    padding: 0.75rem;
    vertical-align: top;
    border-top: 1px solid #dee2e6;
  }
  

  /* Styling for the navigation tabs */
  .nav-tabs {
    border-bottom: 2px solid #dee2e6;
  }

  .nav-tabs .nav-item {
    margin-bottom: -1px;
  }

  .nav-tabs .nav-link {
    color: black;
    background-color: #0276eb;
    border: 1px solid transparent;
    border-top-left-radius: 0.25rem;
    border-top-right-radius: 0.25rem;
  }
.tab-content{
    border: 1px solid grey;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);


}
  .nav-link.active {
    color: white;
    background-color: #0276eb;
    border-color: #dee2e6 #dee2e6 #fff;
  }

  /* Styling for the modal */
  .modal-content {
    border: none;
  }

  .modal-header {
    background-color: #007bff;
    color: #fff;
    border-bottom: 1px solid #dee2e6;
  }

  .modal-title {
    font-weight: bold;
  }

  .modal-body {
    padding: 20px;
  }

  /* Styling for the logout button */
  #logout-btn {
    margin-top: -10px;
  }
</style>

</head>
<body>

<div class="container mt-5">
    <h1>Vehicle Rental Application      <a href="signoutservlet" class="btn btn-danger" style="float: right;" id="logout-btn">Logout</a>
    </h1><input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
        

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" id="myTabs">
       <li class="nav-item">
      <a class="nav-link active" id="vehicles-tab" data-toggle="tab" href="#vehicles">Vehicles</a>
    </li>
    <li class="nav-item">
      <a class="nav-link " id="bookings-tab" data-toggle="tab" href="#bookings">Bookings</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" id="payments-tab" data-toggle="tab" href="#payments">Payments</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" id="feedback-tab" data-toggle="tab" href="#feedback">Feedback</a>
    </li>
 
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">

    <div id="vehicles" class="tab-pane fade show active">
      <h3>Vehicles</h3>
<form method="POST" class="form login" action="example">
    <input type="datetime-local" name="startDateTimeInput" required>
    <input type="datetime-local" name="endDateTimeInput" required>
    <button type="submit">Submit</button>
</form>
      <table class="table" id="vehiclesTable">
        <thead>
          <tr>
            <th>VehicleID</th>
            <th>VehicleType</th>
            <th>Brand</th>
            <th>Rental Rate</th>
            <th>Location</th>
          </tr>
        </thead>
        <tbody>
            <%         
            int[] vehicle=new int[9];
        MongoClientURI URI = new MongoClientURI("mongodb+srv://prabhu:123@cluster0.qycnevx.mongodb.net/?retryWrites=true&w=majority");
        MongoClient mongoClient = new MongoClient(URI); 
        MongoDatabase dbv = mongoClient.getDatabase("vehicle");
        MongoCollection<Document> collectionv = dbv.getCollection("booking");
        MongoCollection<Document> coll = dbv.getCollection("vehicles");

        MongoCursor<Document> cursorv = collectionv.find().iterator();
        MongoCursor<Document> cur = coll.find().iterator();
        int iv = 1;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        String a=(String)request.getAttribute("startDateTimeInput");
        String b=(String)request.getAttribute("endDateTimeInput");

		if( a!= null && b != null){
			System.out.print(a);
			System.out.print(b);

			LocalDateTime s = LocalDateTime.parse(a, formatter);
	        LocalDateTime e = LocalDateTime.parse(b, formatter);
	        while (cursorv.hasNext()) {
	            Document docv = cursorv.next();
	            String x=(String)docv.getString("StartDateTime");
	            String y=(String)docv.getString("EndDateTime");
	            System.out.println(x);
	            System.out.println(y);

	            LocalDateTime dateTimeA=LocalDateTime.parse(x, formatter);
	            LocalDateTime dateTimeB=LocalDateTime.parse(y, formatter);

	            
	            if ((dateTimeA.isAfter(s) && dateTimeA.isBefore(e)) ||
	                    (dateTimeB.isAfter(s) && dateTimeB.isBefore(e)) ||
	                    (dateTimeA.isEqual(s) || dateTimeB.isEqual(e))) {
	            	System.out.println("defeteced");
	            	vehicle[Integer.parseInt(docv.getString("VehicleID"))]=1;
					continue;	            }
	          
	        }
	        while (cur.hasNext()) {
	            Document doc = cur.next();
	            // Uncomment the following lines if you want to filter by userID
	        if(vehicle[Integer.parseInt(doc.getString("VehicleID"))]==1){
	        	continue;
	        }
	        %>
	        <tr>
	            <td><%=doc.getString("VehicleID") %></td>
	            <td><%=doc.getString("VehicleType") %></td>   
	            <td><%=doc.getString("VehicleModel") %></td> 
	            <td><%=doc.getString("RentalRate") %></td>
	            <td><%=doc.getString("Location") %></td>
	        </tr>
	        <%

	       
		}
		}
        //LocalDateTime startDateTimeInput = LocalDateTime.parse((String)request.getAttribute("startDateTimeInput"), formatter);
        //LocalDateTime endDateTimeInput = LocalDateTime.parse((String)request.getAttribute("endDateTimeInput"), formatter);
		
        else{
        while (cur.hasNext()) {
            Document docv = cur.next();
            
            // Uncomment the following lines if you want to filter by userID
            // if(!((String)doc.getString("userID")).equals((String)session.getAttribute("email"))){
            //   continue;
            // }

    %>
    <tr>
        <td><%=docv.getString("VehicleID") %></td>
        <td><%=docv.getString("VehicleType") %></td>   
        <td><%=docv.getString("VehicleModel") %></td> 
        <td><%=docv.getString("RentalRate") %></td>
        <td><%=docv.getString("Location") %></td>
    </tr>
    <%
        }}
        

        %>
       
        </tbody>
      </table>

    </div>
    <div id="bookings" class="tab-pane fade ">
      <h3>Bookings</h3>
      <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
      
      <table class="table" id="bookingsTable">
        <thead>
          <tr>
            <th>BookingID</th>
            <th>UserID</th>
            <th>VehicleID</th>
            <th>PickupLocation</th>
            <th>Drop-offLocation</th>
            
            <th>TotalCost</th>
            <th>Status</th>
            <th>Payment</th>
          </tr>
        </thead>
        <tbody>
          <!-- Placeholder data, replace with actual data -->
      <%                

    MongoDatabase db = mongoClient.getDatabase("vehicle");
    MongoCollection<Document> collection = db.getCollection("booking");
    MongoCursor<Document> cursor = collection.find().iterator();
    int i = 1;

    while (cursor.hasNext()) {
        Document doc = cursor.next();
        // Uncomment the following lines if you want to filter by userID
        System.out.print(session.getAttribute("email"));
     if(!((String)doc.getString("UserID")).equals((String)session.getAttribute("email"))){
          continue;
       }

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
            PAY
        </button>
    </td>
</tr>

                            <!-- Add a modal popup form for each row -->
<div class="modal" id="popupFormModal<%= i %>">
                    
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Add Data</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body">
        <!-- Input form for adding data goes here -->
<form method="POST" class="form login" action="payments">

    <div class="form-group">
        <label for="userIDPayment">UserID:</label>
        <input type="text" class="form-control" id="userIDPayment" name="userIDPayment" value="<%=session.getAttribute("email")%>" readonly>
    </div>

    <div class="form-group">
        <label for="bookingID">BookingID:</label>
        <input type="text" class="form-control" id="bookingID" name="bookingID" value="<%=doc.getString("bookingID") %>" readonly>
    </div>

        <input type="hidden" class="form-control" id="paymentAmount" name="paymentAmount" value=<%=doc.getString("totalCost") %> >

    <div class="form-group">
        <label for="paymentMode">Payment Mode:</label>
        <select class="form-control" id="paymentMode" name="paymentMode">
            <option value="Initial Payment">Initial Payment</option>
            <option value="Final Payment">Final Payment</option>
        </select>
    </div>

    <div class="form-group">
        <label for="paymentMethod">Payment Method:</label>
        <select class="form-control" id="paymentMethod" name="paymentMethod">
            <option value="Credit Card">Credit Card</option>
            <option value="Debit Card">Debit Card</option>
        </select>
    </div>

    <div class="form-group">
        <label for="cardNumber">Card Number:</label>
        <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="Enter card number">
    </div>

    <div class="form-group">
        <label for="cvv">CVV:</label>
        <input type="text" class="form-control" id="cvv" name="cvv" placeholder="Enter CVV">
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
      <button class="btn btn-primary add-btn" data-target="#addDataModal" data-toggle="modal">Add Booking</button>
    </div>

    <div id="payments" class="tab-pane fade">
      <h3>Payments</h3>
      <table class="table" id="paymentsTable">
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
       	        	if(!((String)doc2.getString("userID")).equals((String)session.getAttribute("email"))){
       	        	 continue;
       	        	 }
       	        	 
       	        	
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

    <div id="feedback" class="tab-pane fade">
      <h3>Feedback</h3>
      <table class="table" id="feedbackTable">
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
        if(!((String)doc1.getString("userIDFeedback")).equals((String)session.getAttribute("email"))){
           continue;
         }

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
      <button class="btn btn-primary add-btn" data-target="#addfeedbackModal" data-toggle="modal">Add Feedback</button>
    </div>

    
  </div>
</div>




<!-- Add Data Modal -->
<div class="modal" id="addDataModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Add Data</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body">
        <!-- Input form for adding data goes here -->

<form method="POST" class="form login" action="booking">
    <!-- Update form fields based on feedback, payments, and bookings collections -->
    <!-- For example, for Bookings Collection -->

    <div class="form-group">
        <label for="userID">UserID:</label>
        <input type="text" class="form-control" id="userID" name ="userID" value = <%=session.getAttribute("email")%> readonly>
    </div>
    <div class="form-group">
        <label for="vehicleID">VehicleID:</label>
<select id="vehicleID" name="vehicleID" required>
    <option value="1">Sedan001 - Sedan</option>
    <option value="2">Sedan002 - Sedan</option>
    <option value="3">SUV001 - SUV</option>
    <option value="4">SUV002 - SUV</option>
    <option value="5">Truck001 - Truck</option>
    <option value="6">Truck002 - Truck</option>
    <option value="7">Sedan004 - Sedan</option>
    <option value="8">Sedan006 - Sedan</option>
</select>    </div>
    <div class="form-group">
        <label for="pickupLocation">Pickup Location:</label>
        <input type="text" class="form-control" id="pickupLocation" name="pickupLocation" required>
    </div>
    <div class="form-group">
        <label for="dropoffLocation">Drop-off Location:</label>
        <input type="text" class="form-control" id="dropoffLocation" name="dropoffLocation" required>
    </div>
    <div class="form-group">
        <label for="startDateTime">Start Date and Time:</label>
        <input type="datetime-local" class="form-control" id="startDateTime" name="startDateTime" required>
    </div>
    <div class="form-group">
        <label for="endDateTime">End Date and Time:</label>
        <input type="datetime-local" class="form-control" id="endDateTime" name="endDateTime" required>
    </div>
    
    <div class="form-group">
        <label for="insurance">Insurance Options:</label>
<select id="insurance" name="insurance" required>
    <option value="0">No Insurance</option>
    <option value="1">Standard Insurance(34$)</option>
    <option value="2">Premium Insurance(55$)</option>
</select>    </div>

    <button type="submit" class="btn btn-primary" >Submit</button>
</form>

      </div>

    </div>
  </div>
</div>


<!-- Add payments Modal -->
<div class="modal" id="addPaymentsModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Add Data</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body">
        <!-- Input form for adding data goes here -->
        <form method="POST" class="form login" action="payments">
         

<div class="form-group">
  <label for="userIDPayment">UserID:</label>
  <input type="text" class="form-control" id="userIDPayment" name="userIDPayment" value = <%=session.getAttribute("email")%> readonly>
</div>
<div class="form-group">
  <label for="bookingID">BookingID:</label>
  <input type="text" class="form-control" id="bookingID" name="bookingID">
</div>
<div class="form-group">
  <label for="paymentAmount">Payment Amount:</label>
  <input type="text" class="form-control" id="paymentAmount" name="paymentAmount">
</div>
<div class="form-group">
  <label for="paymentMode">Payment Mode:</label>
  <select class="form-control" id="paymentMode" name="paymentMode">
    <option value="Initial Payment">Initial Payment</option>
    <option value="Final Payment">Final Payment</option>
  </select>
</div>
<div class="form-group">
  <label for="paymentDateTime">Payment Date and Time:</label>
  <input type="text" class="form-control" id="paymentDateTime" name="paymentDateTime">
</div>
<div class="form-group">
  <label for="paymentMethod">Payment Method:</label>
  <select class="form-control" id="paymentMethod" name="paymentMethod">
    <option value="Credit Card">Credit Card</option>
    <option value="Debit Card">Debit Card</option>
  </select>
</div>
<div class="form-group">
  <label for="paymentStatus">Payment Status:</label>
  <input type="text" class="form-control" id="paymentStatus" name="paymentStatus">
</div>
<button type="submit" class="btn btn-primary" >Submit</button>

        </form>
      </div>

    </div>
  </div>
</div>




<!-- Add feedback Modal -->
<div class="modal" id="addfeedbackModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Add Data</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body">
        <!-- Input form for adding data goes here -->
        <form method="POST" class="form login" action="feedback">
          

<div class="form-group">
  <label for="userIDFeedback">UserID:</label>
  <input type="text" class="form-control" id="userIDFeedback" name="userIDFeedback" value = <%=session.getAttribute("email")%> readonly>
</div>
 <div class="form-group">
        <label for="vehicleID">VehicleID:</label>
<select id="vehicleID" name="vehicleID" required>
    <option value="1">Sedan001 - Sedan</option>
    <option value="2">Sedan002 - Sedan</option>
    <option value="3">SUV001 - SUV</option>
    <option value="4">SUV002 - SUV</option>
    <option value="5">Truck001 - Truck</option>
    <option value="6">Truck002 - Truck</option>
    <option value="7">Sedan004 - Sedan</option>
    <option value="8">Sedan006 - Sedan</option>
</select>    </div>
<div class="form-group">
  <label for="feedbackDesc">Feedback Description:</label>
  <input type="text" class="form-control" id="feedbackDesc" name="feedbackDesc">
</div><div class="form-group">
        <label for="vehicleID">Rating:</label>
<select id="rating" name="rating" required>
    <option value="1">worst</option>
    <option value="2">bad</option>
    <option value="3">satisfied</option>
    <option value="4">good</option>
    <option value="5">excellent</option>
</select>    </div>

<button type="submit" class="btn btn-primary" >Submit</button>

        </form>
      </div>

    </div>
  </div>
</div>



<!-- Bootstrap JS and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Custom JS -->
<!-- Add an event listener to detect changes in the Payment Mode select -->

<script type="text/javascript">
var status = document.getElementById("status").value;
if (status == "overlap" || status=="failed") {
    // Code to execute if the condition is true
    alert("Unable to book, Date Overlapped", "failed");
} else if(status=="success"){
    // Code to execute if the condition is false
    alert("Booking Done!!!", "success");
}
else if (status == "paymentsuccess") {
    // Code to execute if the condition is true
    alert("Payment done", "success");
} else if(status=="paymentfailed"){
    // Code to execute if the condition is false
    alert("payment error", "failed");
}
else if (status == "feedbacksuccess") {
    // Code to execute if the condition is true
    alert("feedback done", "success");
} else if(status=="feedbackfailed"){
    // Code to execute if the condition is false
    alert("feedback error", "failed");
}
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>


<script>
    function checkOverlap() {
    	
    	
        // Make an AJAX request to the server to update the value of f
        // Assuming you have a server-side endpoint to update the value
        // Here, I'm simulating a server request with a timeout
        setTimeout(() => {
            // Assuming the server updates the value of f to 1
            // You can replace this with your actual server interaction
            document.getElementById('labelValue').innerText = '1';
        }, 500);
    }
</script>
</body>
</html>
