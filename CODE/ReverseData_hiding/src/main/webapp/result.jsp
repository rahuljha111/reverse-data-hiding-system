<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recovered Results - RDH Demo</title>
<style>
 body{ font-family:'Poppins',sans-serif; background:#eef2f7; padding:40px; color:#111; }
 .card{ width:80%; margin:0 auto; background:#fff; padding:24px; border-radius:8px; box-shadow:0 10px 30px rgba(0,0,0,0.08); }
 pre { white-space:pre-wrap; word-wrap:break-word; background:#f7fafc; padding:12px; border-radius:6px; }
 img { max-width:60%; display:block; margin:18px auto; border-radius:6px; }
</style>
</head>
<body>
<header>
<nav>
<a href="login.jsp">Logout</a>

</nav>

</header>

 <div class="card">
   <h2>Recovered Message</h2>
   <%
       javax.servlet.http.HttpSession sess = request.getSession();
       String msg = (String) sess.getAttribute("recoveredMessage");
       byte[] origPNG = (byte[]) sess.getAttribute("recoveredImagePNG");
       if (msg != null) {
   %>
       <pre><%= msg %></pre>
   <%
       } else {
   %>
       <p>No recovered message available.</p>
   <%
       }
       if (origPNG != null) {
           String b64 = Base64.getEncoder().encodeToString(origPNG);
   %>
       <h3>Recovered Original Image</h3>
       <img src="data:image/png;base64,<%=b64%>" alt="Recovered Original" />
   <%
       } else {
   %>
       <p>No recovered image available.</p>
   <%
       }
   %>
 </div>
</body>
</html>
