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
 * Servlet implementation class EmbedServlet
 */
@WebServlet("/embed")
public class EmbedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmbedServlet() {
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
		HttpSession s = req.getSession();
        // Use the encrypted (permuted) image as the base into which we hide message
        BufferedImage encrypted = (BufferedImage) s.getAttribute("encryptedImage");
        if (encrypted == null) { resp.sendRedirect("upload.jsp"); return; }

        String message = req.getParameter("message");
        if (message == null) message = "";

        RDHUtils.EmbedResult er = RDHUtils.embedReversibleLSB(encrypted, message);

        // Save stego image and bytes
        s.setAttribute("stegoImage", er.stego);
        s.setAttribute("stegoImagePNG", RDHUtils.bufferedImageToBytesPNG(er.stego));

        // Keep the same masterKey (seed already displayed after encryption) — extraction requires seed
        // Redirect to view stego
        resp.sendRedirect("viewStego.jsp");
    }

}
