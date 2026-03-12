package com.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.service.RDHUtils;

/**
 * Servlet implementation class EncryptServlet
 */
@WebServlet("/encrypt")
public class EncryptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EncryptServlet() {
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
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 HttpSession sess = req.getSession();
	        BufferedImage original = (BufferedImage) sess.getAttribute("originalImage");
	        if (original == null) {
	            resp.sendRedirect("upload.jsp");
	            return;
	        }
	        // generate seed hex and permute
	        String seedHex = RDHUtils.generateSeedHex();
	        long seed = RDHUtils.seedFromHex(seedHex);
	        BufferedImage permuted = RDHUtils.permuteImage(original, seed);

	        // Store permuted image and seed
	        sess.setAttribute("encryptedImage", permuted); // name 'encryptedImage' used by viewEncrypted.jsp
	        sess.setAttribute("permSeedHex", seedHex);

	        // Generate masterKey now (display immediately)
	        String masterKey = RDHUtils.encodeMasterKey(seedHex);
	        sess.setAttribute("masterKey", masterKey);

	        // Optionally store PNG bytes for convenience
	        sess.setAttribute("encryptedImagePNG", RDHUtils.bufferedImageToBytesPNG(permuted));

	        resp.sendRedirect("viewEncrypted.jsp");
	    }

}
