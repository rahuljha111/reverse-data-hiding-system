<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upload Stego Image & Enter Key</title>
<style>
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
  }

  body {
    min-height: 100vh;
    background: radial-gradient(circle at top left, #020617, #0b1220, #111827);
    color: #ffffff;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    overflow-x: hidden;
    position: relative;
  }

  /* Floating glowing elements */
  .glow {
    position: absolute;
    width: 400px;
    height: 400px;
    border-radius: 50%;
    filter: blur(180px);
    opacity: 0.4;
    z-index: 0;
    animation: float 10s infinite alternate ease-in-out;
  }

  .glow1 {
    background: #38bdf8;
    top: 10%;
    left: -10%;
  }

  .glow2 {
    background: #06b6d4;
    bottom: 10%;
    right: -10%;
  }

  @keyframes float {
    0% { transform: translateY(0) scale(1); }
    100% { transform: translateY(-50px) scale(1.1); }
  }

  header {
    width: 100%;
    text-align: center;
    padding: 25px 0;
    background: linear-gradient(90deg, #0ea5e9, #38bdf8, #06b6d4);
    background-size: 200% 200%;
    animation: gradientMove 6s ease infinite alternate;
    box-shadow: 0 0 25px rgba(14,165,233,0.4);
    position: relative;
    z-index: 2;
  }

  @keyframes gradientMove {
    0% { background-position: left; }
    100% { background-position: right; }
  }

  header h1 {
    font-size: 26px;
    font-weight: 600;
    letter-spacing: 1px;
    color: #fff;
  }

  nav {
    margin-top: 40px;
    display: flex;
    justify-content: center;
    gap: 40px;
    z-index: 2;
  }

  nav a {
    text-decoration: none;
    color: #fff;
    font-weight: 600;
    font-size: 16px;
    padding: 12px 30px;
    border: 2px solid #06b6d4;
    border-radius: 8px;
    position: relative;
    transition: all 0.4s ease;
    overflow: hidden;
    background: rgba(255,255,255,0.05);
  }

  nav a::before {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, #06b6d4, #38bdf8);
    transition: all 0.5s ease;
    z-index: 0;
  }

  nav a:hover::before {
    left: 0;
  }

  nav a span {
    position: relative;
    z-index: 1;
  }

  nav a:hover {
    color: #fff;
    box-shadow: 0 0 15px rgba(6,182,212,0.5);
    transform: translateY(-3px);
  }

  .card {
    width: 600px;
    margin-top: 70px;
    background: rgba(255,255,255,0.05);
    border-radius: 12px;
    padding: 40px 30px;
    text-align: center;
    box-shadow: 0 0 25px rgba(6,182,212,0.2);
    backdrop-filter: blur(10px);
    position: relative;
    z-index: 2;
    transition: transform 0.4s ease, box-shadow 0.4s ease;
  }

  .card:hover {
    transform: scale(1.02);
    box-shadow: 0 0 35px rgba(56,189,248,0.35);
  }

  .card h2 {
    color: #38bdf8;
    margin-bottom: 20px;
    font-weight: 600;
  }

  input[type=file], input[type=text] {
    width: 80%;
    padding: 12px;
    margin: 10px 0;
    border-radius: 6px;
    border: 1px solid rgba(255,255,255,0.1);
    background: rgba(15,23,42,0.8);
    color: #fff;
    outline: none;
    transition: all 0.3s ease;
  }

  input[type=file]:focus, input[type=text]:focus {
    border-color: #06b6d4;
    box-shadow: 0 0 10px rgba(6,182,212,0.3);
  }

  button {
    padding: 12px 24px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 600;
    color: #fff;
    background: linear-gradient(90deg, #06b6d4, #0ea5e9);
    margin-top: 20px;
    margin-right: 10px;
    transition: all 0.3s ease;
    box-shadow: 0 0 15px rgba(6,182,212,0.3);
  }

  button:hover {
    transform: translateY(-2px);
    box-shadow: 0 0 25px rgba(56,189,248,0.4);
  }

  #requestBtn {
    background: linear-gradient(90deg, #f97316, #fb923c);
    box-shadow: 0 0 15px rgba(251,146,60,0.3);
  }

  #requestBtn:hover {
    box-shadow: 0 0 25px rgba(251,146,60,0.5);
    transform: translateY(-2px);
  }

  footer {
    position: absolute;
    bottom: 20px;
    text-align: center;
    color: #94a3b8;
    font-size: 13px;
  }
</style>

<script>
function requestMasterKey() {
  if (!confirm("Are you sure you want to request the master key?")) return;

  fetch('requestKey', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: 'requestKey=true'
  })
  .then(response => response.text())
  .then(data => alert(data))
  .catch(err => alert('Request failed: ' + err));
}
</script>
</head>

<body>

<div class="glow glow1"></div>
<div class="glow glow2"></div>

<header>
  <h1>Reversible Data Hiding - Secure Extraction Portal</h1>
</header>

<nav>
  <a href="upload1.jsp"><span>Upload Stego Image</span></a>
  <a href="operResponse.jsp"><span>Open Response</span></a>
  <a href="login.jsp"><span>Logout</span></a>
</nav>

<%
String username=(String)session.getAttribute("username");
if (username == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<div class="card">
  <h2>Upload Stego Image & Enter Master Key</h2>
  <form method="post" action="uploadExtract" enctype="multipart/form-data">
    <input type="file" name="stegoFile" accept="image/png" required /><br/>
    <input type="text" name="masterKey" placeholder="Enter master key" required /><br/>
    <button type="submit">Extract & Recover</button>
  </form>

  <button id="requestBtn" type="button" onclick="requestMasterKey()">Request Master Key</button>
</div>

<footer>
  © 2025 Reversible Data Hiding System | Secure Stego Image Extraction
</footer>

</body>
</html>
