<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Encrypt Image - Reversible Data Hiding</title>
<style>
    body {
        background: linear-gradient(135deg, #141E30, #243B55);
        font-family: 'Poppins', sans-serif;
        color: #fff;
        text-align: center;
        margin: 0;
        padding: 0;
    }
    .container {
        margin: 40px auto;
        padding: 30px;
        background: rgba(255,255,255,0.1);
        border-radius: 20px;
        width: 70%;
        box-shadow: 0 0 20px rgba(0,0,0,0.4);
    }
    img {
        max-width: 80%;
        border-radius: 15px;
        margin-top: 20px;
    }
    button {
        margin-top: 25px;
        padding: 12px 25px;
        font-size: 16px;
        color: #fff;
        background: #00c6ff;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        transition: 0.3s;
    }
    button:hover {
        background: #0072ff;
        transform: scale(1.05);
    }
    h2 {
        letter-spacing: 1px;
        margin-bottom: 10px;
    }
</style>
</head>
<body>

<div class="container">
    <h2>Original Uploaded Image</h2>
    <%
        javax.servlet.http.HttpSession sess = request.getSession();
        java.awt.image.BufferedImage original = (java.awt.image.BufferedImage) sess.getAttribute("originalImage");
        if (original != null) {
            java.io.ByteArrayOutputStream baos = new java.io.ByteArrayOutputStream();
            javax.imageio.ImageIO.write(original, "png", baos);
            String base64Img = Base64.getEncoder().encodeToString(baos.toByteArray());
    %>
        <img src="data:image/png;base64,<%=base64Img%>" alt="Original Image"/><br>
        <form method="post" action="encrypt">
            <button type="submit">Encrypt Image (Pixel Permutation)</button>
        </form>
    <%
        } else {
    %>
        <p>No image found in session. Please <a href="upload.jsp" style="color:#00c6ff;">upload</a> an image first.</p>
    <%
        }
    %>
</div>

</body>
</html>
