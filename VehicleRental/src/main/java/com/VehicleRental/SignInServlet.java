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
@WebServlet("/signin")
public class SignInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		RequestDispatcher dispatcher = null;
		HttpSession session = request.getSession();


		MongoCloud mongoInstance1 = new MongoCloud("vehicle","customer");
		String temp =mongoInstance1.validateCustomer(email,password,session);
		System.out.print(temp);
		if(temp.equals("admin"))
		{		System.out.print("qww");

			session.setAttribute("role", "admin");
			session.setAttribute("email", email);
			dispatcher = request.getRequestDispatcher("admin.jsp");
		}


		
		else if(temp.equals("customer")) {
			session.setAttribute("role", "customer");
			session.setAttribute("email", email);
			dispatcher = request.getRequestDispatcher("home.jsp");
		}
		
		else {
			request.setAttribute("status", "faileda");
			dispatcher = request.getRequestDispatcher("signin.jsp");
		}
		dispatcher.forward(request, response);
		
	}

}
