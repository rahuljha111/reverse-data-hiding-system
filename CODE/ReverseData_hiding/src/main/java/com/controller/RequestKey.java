package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RequestKey
 */
@WebServlet("/requestKey")
public class RequestKey extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DB_URL = "jdbc:mysql://localhost:3306/VTJIM07_25";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "root";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RequestKey() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 HttpSession session = request.getSession(false);
	        if (session == null || session.getAttribute("username") == null) {
	            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	            response.getWriter().write("You must be logged in to request the master key.");
	            return;
	        }

	        String username = (String) session.getAttribute("username");

	        // Connect to DB and insert request record
	        try {
	        		
	        		Class.forName("com.mysql.jdbc.Driver");
	        		
	        		Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
	             PreparedStatement ps = conn.prepareStatement("INSERT INTO master_key_requests (username, status,request_time) VALUES (?,?, NOW())");

	            ps.setString(1, username);
	            ps.setString(2, "pending");
	            ps.executeUpdate();

	            response.getWriter().write("Master key request submitted successfully.");
	        } catch (SQLException e) {
	            e.printStackTrace();
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	            response.getWriter().write("Failed to submit master key request.");
	        } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
}
