package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ShareImage
 */
@WebServlet("/shareImage")
public class ShareImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShareImage() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    private Connection getConnection() throws SQLException, ClassNotFoundException {
    	Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/VTJIM07_25", "root", "root");
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
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.getWriter().write("Not logged in.");
            return;
        }

        int senderId = (int) session.getAttribute("userId");
        String recipientUsername = req.getParameter("recipient");
        if (recipientUsername == null || recipientUsername.isEmpty()) {
            resp.getWriter().write("Recipient username is required.");
            return;
        }

        byte[] stImage = (byte[]) session.getAttribute("stegoImagePNG");
        if (stImage == null) {
            resp.getWriter().write("No stego image found in session.");
            return;
        }

        try (Connection conn = getConnection()) {
            int receiverId = -1;
            PreparedStatement findUser = conn.prepareStatement("SELECT id FROM users WHERE username=?");
            findUser.setString(1, recipientUsername);
            ResultSet rs = findUser.executeQuery();
            if (rs.next()) receiverId = rs.getInt("id");
            rs.close(); findUser.close();

            if (receiverId == -1) {
                resp.getWriter().write("Recipient not found.");
                return;
            }

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO shared_images (sender_id, receiver_id, image_data, filename) VALUES (?,?,?,?)");
            ps.setInt(1, senderId);
            ps.setInt(2, receiverId);
            ps.setBytes(3, stImage);
            ps.setString(4, "stego_image.png");
            ps.executeUpdate();
            ps.close();

            resp.getWriter().write("✅ Image successfully shared with " + recipientUsername);

        } catch (SQLException e) {
            e.printStackTrace();
            resp.getWriter().write("Database error: " + e.getMessage());
        } catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    }

}
