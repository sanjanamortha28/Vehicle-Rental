
<%
   response.setHeader("Cache-control","no-cache");
   response.setHeader("Cache-control","no-store");
   response.setHeader("Pragma","no-cache");
   response.setDateHeader("Expire",0);

   // Check if the user is already logged in
 
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login and Signup</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }

        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group button {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            background-color: #007bff; /* Blue color */
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease; /* Add smooth transition */
        }

        .form-group button:hover {
            background-color: #0056b3; /* Darker shade of blue on hover */
        }

        .switch-form {
            margin-top: 20px;
            font-size: 14px;
        }

        .switch-form a {
            color: #007bff;
            text-decoration: none;
        }

        .switch-form a:hover {
            text-decoration: underline; /* Underline on hover */
        }
    </style>
</head>
<body>

<div class="container">
    <div id="loginForm">
        <h2>Login</h2> <input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
        
        <form  method="POST" class="form login" action="signin">
        
        <div class="form-group">
            <label for="loginUsername">Username:</label>
            <input type="text" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="loginPassword">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <button type="submit" >Login</button>
        </div>
        <div class="switch-form">
            <p>Don't have an account? <a href="#" onclick="toggleForm('signupForm')">Sign up</a></p>
        </div>
        </form>
    </div>

    <div id="signupForm" style="display: none;">
        <h2>Sign up</h2>
        <form  method="POST" class="form signup" action="signup">
        
        <div class="form-group">
            <label for="signupUsername">Username:</label>
            <input type="text" id="cname" name="cname" required>
        </div>
        <div class="form-group">
            <label for="signupPassword">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="signupEmail">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="signupPhoneNumber">Phone Number:</label>
            <input type="tel" id="cnumber" name="cnumber" placeholder="Format: 123-456-7890" required>
        </div>
        <div class="form-group">
            <button type="submit" >Sign up</button>
        </div>
        <div class="switch-form">
            <p>Already have an account? <a href="#" onclick="toggleForm('loginForm')">Login</a></p>
        </div>
        </form>
    </div>
</div>

<script>
    function toggleForm(formId) {
        document.getElementById('loginForm').style.display = formId === 'loginForm' ? 'block' : 'none';
        document.getElementById('signupForm').style.display = formId === 'signupForm' ? 'block' : 'none';
    }

    function login() {
        // Add your login logic here
        alert('Login button clicked');
    }

    function signup() {
        // Add your signup logic here
        alert('Sign up button clicked');
    }
</script>


<script type="text/javascript">
var status = document.getElementById("status").value;
if (status == "customer") {
    // Code to execute if the condition is true
    alert("logged in", "success");
} else if(status=="faileda"){
    // Code to execute if the condition is false
    alert("wrong input", "failed");
}


</script>

</body>
</html>
