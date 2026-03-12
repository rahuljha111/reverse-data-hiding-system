package com.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.service.RDHUtils;

/**
 * Servlet implementation class ExtractShared
 */
@WebServlet("/uploadExtract")
@MultipartConfig(maxFileSize = 50_000_000)  // 50MB max upload size
public class ExtractShared extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExtractShared() {
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
		Part filePart = request.getPart("stegoFile");
	    if (filePart == null || filePart.getSize() == 0) {
	        response.getWriter().println("No file uploaded.");
	        return;
	    }

	    InputStream fileContent = filePart.getInputStream();
	    BufferedImage stegoImage = ImageIO.read(fileContent);
	    if (stegoImage == null) {
	        response.getWriter().println("Invalid image file.");
	        return;
	    }

	    String masterKeyInput = request.getParameter("masterKey");
	    if (masterKeyInput == null || masterKeyInput.trim().isEmpty()) {
	        response.getWriter().println("Master key is required.");
	        return;
	    }

	    String decoded = RDHUtils.decodeMasterKey(masterKeyInput);
	    if (decoded == null || !decoded.contains(":")) {
	        response.getWriter().println("Invalid master key format.");
	        return;
	    }
	    String[] parts = decoded.split(":", 2);
	    if (parts.length < 2) {
	        response.getWriter().println("Bad master key format.");
	        return;
	    }
	    String seedHex = parts[1];
	    long seed = RDHUtils.seedFromHex(seedHex);

	    RDHUtils.ExtractResult er;
	    try {
	        er = RDHUtils.extractReversibleLSB(stegoImage);
	    } catch (Exception e) {
	        response.getWriter().println("Failed to extract message: " + e.getMessage());
	        return;
	    }

	    HttpSession session = request.getSession();

	    if (er == null || er.message == null) {
	        session.setAttribute("errorMessage", "No hidden message found.");
	        session.removeAttribute("recoveredMessage");
	        session.removeAttribute("recoveredImagePNG");
	        response.sendRedirect("result.jsp");
	        return;
	    }

	    // Here, add your validation logic for the master key correctness:
	    // For example, check if the seed used in permutation matches the master key seed
	    // or check if the extracted message can be successfully inverse permuted

	    // If key is invalid, set error message
	    // (Assuming if inverse permutation fails or seed doesn't match, key is invalid)
	    BufferedImage originalRecovered = null;
	    try {
	        originalRecovered = RDHUtils.inversePermuteImage(er.recoveredImage, seed);
	    } catch (Exception e) {
	        session.setAttribute("errorMessage", "Invalid master key.");
	        session.removeAttribute("recoveredMessage");
	        session.removeAttribute("recoveredImagePNG");
	        response.sendRedirect("result.jsp");
	        return;
	    }

	    // If no error, save recovered message and image to session
	    session.setAttribute("recoveredMessage", er.message);
	    session.setAttribute("recoveredImagePNG", RDHUtils.bufferedImageToBytesPNG(originalRecovered));
	    session.removeAttribute("errorMessage");

	    response.sendRedirect("result.jsp");
	}

}
