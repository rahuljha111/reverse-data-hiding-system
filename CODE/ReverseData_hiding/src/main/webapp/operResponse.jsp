<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Master Key Requests - RDH System</title>
<style>
  /* RESET & GLOBAL */
  * { margin:0; padding:0; box-sizing:border-box; font-family:'Poppins', sans-serif; }
  body {
    min-height:100vh;
    background: radial-gradient(circle at top left, #020617, #0b1220, #111827);
    color:#fff;
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:flex-start;
    overflow-x:hidden;
    position:relative;
  }

  /* GLOW ELEMENTS */
  .glow {
    position:absolute;
    width:400px;
    height:400px;
    border-radius:50%;
    filter:blur(200px);
    opacity:0.4;
    z-index:0;
    animation:float 10s infinite alternate ease-in-out;
  }
  .glow1 { background:#06b6d4; top:-10%; left:-10%; }
  .glow2 { background:#38bdf8; bottom:-10%; right:-10%; }
  @keyframes float {
    0% { transform:translateY(0) scale(1); }
    100% { transform:translateY(-50px) scale(1.1); }
  }

  /* HEADER */
  header {
    width:100%;
    text-align:center;
    padding:25px 0;
    background:linear-gradient(90deg,#0ea5e9,#38bdf8,#06b6d4);
    background-size:200% 200%;
    animation:gradientMove 6s ease infinite alternate;
    box-shadow:0 0 25px rgba(14,165,233,0.4);
    z-index:2;
  }
  header h1 {
    font-size:26px;
    font-weight:600;
    color:#fff;
    letter-spacing:1px;
  }
  @keyframes gradientMove {
    0% { background-position:left; }
    100% { background-position:right; }
  }

  /* NAVBAR */
  nav {
    display:flex;
    justify-content:center;
    gap:40px;
    margin-top:25px;
    z-index:2;
  }
  nav a {
    text-decoration:none;
    color:#fff;
    font-weight:600;
    font-size:15px;
    padding:12px 28px;
    border:2px solid #06b6d4;
    border-radius:8px;
    position:relative;
    transition:all 0.4s ease;
    background:rgba(255,255,255,0.05);
    overflow:hidden;
  }
  nav a::before {
    content:"";
    position:absolute;
    top:0; left:-100%;
    width:100%; height:100%;
    background:linear-gradient(90deg,#06b6d4,#38bdf8);
    transition:all 0.5s ease;
    z-index:0;
  }
  nav a:hover::before { left:0; }
  nav a span { position:relative; z-index:1; }
  nav a:hover {
    color:#fff;
    box-shadow:0 0 15px rgba(6,182,212,0.5);
    transform:translateY(-3px);
  }

  /* TABLE SECTION */
  .table-container {
    width:80%;
    background:rgba(255,255,255,0.05);
    border-radius:12px;
    margin-top:60px;
    box-shadow:0 0 25px rgba(6,182,212,0.2);
    backdrop-filter:blur(10px);
    z-index:2;
    padding:20px;
    transition:transform 0.4s ease, box-shadow 0.4s ease;
  }

  .table-container:hover {
    transform:scale(1.02);
    box-shadow:0 0 35px rgba(56,189,248,0.35);
  }

  table {
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
  }
  thead {
    background:linear-gradient(90deg,#06b6d4,#0ea5e9);
    color:#fff;
  }
  th, td {
    padding:14px 20px;
    text-align:center;
  }
  th {
    font-weight:600;
    letter-spacing:1px;
  }
  tr:nth-child(even) {
    background:rgba(255,255,255,0.03);
  }
  tr:hover {
    background:rgba(56,189,248,0.1);
    box-shadow:0 0 20px rgba(56,189,248,0.3);
  }
  td {
    color:#e2e8f0;
    font-size:15px;
  }

  /* FOOTER */
  footer {
    position:fixed;
    bottom:20px;
    text-align:center;
    color:#94a3b8;
    font-size:13px;
  }
</style>
</head>
<body>

<div class="glow glow1"></div>
<div class="glow glow2"></div>

<header>
  <h1>Reversible Data Hiding - Master Key Requests</h1>
</header>

<nav>
  <a href="upload1.jsp"><span>Upload Stego Image</span></a>
  <a href="operResponse.jsp"><span>Open Response</span></a>
  <a href="login.jsp"><span>Logout</span></a>
</nav>

<div class="table-container">
  <table>
    <thead>
      <tr>
        <th>Request ID</th>
        <th>Username</th>
        <th>Master Key</th>
      </tr>
    </thead>
    <tbody>
    <%
     String DB_URL = "jdbc:mysql://localhost:3306/VTJIM07_25";
     String DB_USER = "root";
     String DB_PASS = "root";
     String username=(String)session.getAttribute("username");

     Class.forName("com.mysql.jdbc.Driver");
     Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
     String sql="select * from master_key_requests where username='"+username+"'";
     PreparedStatement ps=conn.prepareStatement(sql);
     ResultSet rs=ps.executeQuery();

     while(rs.next()) {
    %>
      <tr>
        <td><%=rs.getInt(1)%></td>
        <td><%=rs.getString(2)%></td>
        <td><%=rs.getString(3)%></td>
      </tr>
    <%
     }
     conn.close();
    %>
    </tbody>
  </table>
</div>

<footer>
  © 2025 Reversible Data Hiding System | Secure Key Access Dashboard
</footer>

</body>
</html>
