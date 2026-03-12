<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Base64" %>
<%
    HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (int) sess.getAttribute("userId");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/VTJIM07_25","root","root");
        ps = conn.prepareStatement("SELECT id, image_data, sender_id, created_at FROM shared_images WHERE receiver_id = ?");
        ps.setInt(1, userId);
        rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shared Images Inbox</title>
<style>
 body { background:#0b1220; color:#fff; font-family:'Poppins',sans-serif; padding:36px; }
 .card { background:rgba(255,255,255,0.05); padding:20px; border-radius:10px; margin-bottom:20px; text-align:center; }
 img { max-width:60%; border-radius:8px; margin-bottom:10px; }
 input { padding:8px; width:60%; background:#071026; color:#fff; border:1px solid rgba(255,255,255,0.06); border-radius:6px; }
 button { padding:8px 16px; background:#06b6d4; color:#fff; border:none; border-radius:6px; cursor:pointer; margin-top:10px; }
</style>
</head>
<body>
<h2>📥 Shared Images</h2>
<%
    while (rs.next()) {
        int shareId = rs.getInt("id");
        byte[] img = rs.getBytes("image_data");
        String base64 = Base64.getEncoder().encodeToString(img);
%>
  <div class="card">
    <img src="data:image/png;base64,<%=base64%>" alt="Stego Image"/><br/>
    <form method="post" action="extractShared">
      <input type="hidden" name="shareId" value="<%=shareId%>"/>
      <input type="text" name="masterKey" placeholder="Enter master key"/>
      <button type="submit">Extract Message</button>
    </form>
  </div>
<%
    }
%>
</body>
</html>
<%
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
