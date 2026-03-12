package com.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.service.RDHUtils;

/**
 * Servlet implementation class ExtractServlet
 */
@WebServlet("/extract")
public class ExtractServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExtractServlet() {
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
        byte[] stegoPng = (byte[]) s.getAttribute("stegoImagePNG");
        if (stegoPng == null) { resp.sendRedirect("upload.jsp"); return; }
        BufferedImage stego = RDHUtils.readImage(new ByteArrayInputStream(stegoPng));

        String masterKeyInput = req.getParameter("masterKey");
        if (masterKeyInput == null || masterKeyInput.isEmpty()) {
            // if not provided in form, fallback to session masterKey
            masterKeyInput = (String) s.getAttribute("masterKey");
            if (masterKeyInput == null || masterKeyInput.isEmpty()) {
                resp.getWriter().println("Master key missing. Provide key.");
                return;
            }
        }

        // decode master key
        String decoded = RDHUtils.decodeMasterKey(masterKeyInput); // "seed:<hex>"
        String[] parts = decoded.split(":", 2);
        if (parts.length < 2) {
            resp.getWriter().println("Bad key format.");
            return;
        }
        String seedHex = parts[1];
        long seed = RDHUtils.seedFromHex(seedHex);

        // extract message and recovered (permuted) image
        RDHUtils.ExtractResult er = RDHUtils.extractReversibleLSB(stego);
        String message = er.message;
        BufferedImage permutedRecovered = er.recoveredImage;

        // inverse permute to obtain original image
        BufferedImage originalRecovered = RDHUtils.inversePermuteImage(permutedRecovered, seed);

        s.setAttribute("recoveredMessage", message);
        s.setAttribute("recoveredImagePNG", RDHUtils.bufferedImageToBytesPNG(originalRecovered));

        resp.sendRedirect("result.jsp");
    }

}
