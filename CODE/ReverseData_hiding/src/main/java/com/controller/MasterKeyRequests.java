package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MasterKeyRequests
 */
@WebServlet("/masterKeyRequests")
public class MasterKeyRequests extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String DB_URL = "jdbc:mysql://localhost:3306/VTJIM07_25";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "root";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MasterKeyRequests() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Request> pendingRequests = new ArrayList<>();
        try  {
        	Class.forName("com.mysql.jdbc.Driver");
    		
    		Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
         
            String sql = "SELECT * FROM master_key_requests WHERE status = 'pending'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Request r = new Request();
                r.id = rs.getInt("id");
                r.username = rs.getString("username");
                r.status = rs.getString("status");
                r.requestTime = rs.getTimestamp("request_time");
                pendingRequests.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("requests", pendingRequests);
        req.getRequestDispatcher("masterKeyRequests.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Update the request with the master key and change status to 'approved'
        String idStr = req.getParameter("id");
        String masterKey = req.getParameter("masterKey");

        if (idStr != null && masterKey != null && !masterKey.trim().isEmpty()) {
            int id = Integer.parseInt(idStr);
            try  {
            	Class.forName("com.mysql.jdbc.Driver");
        		
        		Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             
                String sql = "UPDATE master_key_requests SET status = ? WHERE id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, "approved: " + masterKey);
                ps.setInt(2, id);
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        resp.sendRedirect("masterKeyRequests");
    }

    public static class Request {
        public int id;
        public String username;
        public String status;
        public Timestamp requestTime;
    }
}
