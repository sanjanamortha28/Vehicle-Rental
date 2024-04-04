package com.VehicleRental;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.VehicleRental.MongoCloud;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String number = request.getParameter("number").toString();
		String cname = request.getParameter("cname");
		
		RequestDispatcher dispatcher = null;
		HttpSession session = request.getSession();

		MongoCloud mongoInstance1 = new MongoCloud("vehicle","customer");
		boolean temp =mongoInstance1.insert1(cname,number,email,password);
		System.out.print(temp);
		if(temp)
		{	session.setAttribute("role", "customer");
			session.setAttribute("email", email);
			System.out.print(email);
			dispatcher = request.getRequestDispatcher("home.jsp");
			
		}
		else
		{	session.setAttribute("role", "alreadycustomer");
			dispatcher = request.getRequestDispatcher("signin.jsp");

		}
	
		dispatcher.forward(request, response);
		
	}

}
