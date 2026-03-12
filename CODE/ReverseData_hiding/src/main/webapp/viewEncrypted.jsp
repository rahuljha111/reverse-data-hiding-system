<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Encrypted Image - Reversible Data Hiding</title>
<style>
    body {
        background: linear-gradient(135deg, #232526, #414345);
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
        box-shadow: 0 0 20px rgba(0,0,0,0.5);
    }
    .key-box {
        background: rgba(0,0,0,0.3);
        border-radius: 12px;
        padding: 15px;
        margin-top: 25px;
        display: inline-block;
        font-size: 18px;
        letter-spacing: 1px;
        color: #00ffea;
        border: 1px solid #00ffea;
        word-break: break-all;
    }
    button {
        margin-top: 30px;
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
    <h2>Encrypted Image (Pixel Permutation)</h2>
    <%
        javax.servlet.http.HttpSession sess = request.getSession();
        byte[] encPNG = (byte[]) sess.getAttribute("encryptedImagePNG");
        String masterKey = (String) sess.getAttribute("masterKey");

        if (encPNG != null) {
            String base64Enc = Base64.getEncoder().encodeToString(encPNG);
    %>
        <img src="data:image/png;base64,<%=base64Enc%>" alt="Encrypted Image"/><br>

        <% if (masterKey != null) { %>
            <div class="key-box">
                <strong>Master Key (store safely):</strong><br/><%= masterKey %>
            </div>
        <% } %>

        <form action="embed.jsp" method="get">
            <button type="submit">Hide Secret Text in Image</button>
        </form>

    <%
        } else {
    %>
        <p>No encrypted image found. Please <a href="upload.jsp" style="color:#00c6ff;">upload</a> and encrypt an image first.</p>
    <%
        }
    %>
</div>

</body>
</html>
