<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Secure Login | Reversible Data Hiding</title>
<style>
  /* Global Reset */
  * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }

  /* Background with image + gradient overlay */
  body {
    background: url('images/a3.webp') no-repeat center center/cover;
    min-height: 100vh;
    position: relative;
    overflow: hidden;
  }

  /* Dark transparent overlay for contrast */
  body::before {
    content: "";
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(0,0,0,0.4);
    backdrop-filter: blur(2px);
    z-index: 0;
  }

  /* Header navigation */
  header {
    width: 100%;
    padding: 20px 50px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: white;
    z-index: 2;
    position: relative;
  }
  header h1 {
    font-size: 1.8em;
    letter-spacing: 1px;
    color: #00c6ff;
  }
  nav a {
    color: white;
    margin-left: 25px;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.3s ease;
  }
  nav a:hover {
    color: #00c6ff;
  }

  /* Hero text layer */
  .hero {
    text-align: center;
    color: #fff;
    margin-top: 80px;
    z-index: 2;
    position: relative;
  }
  .hero h2 {
    font-size: 2.2em;
    margin-bottom: 10px;
  }
  .hero p {
    font-size: 1.1em;
    opacity: 0.8;
  }

  /* Login card container */
  .login-container {
    position: relative;
    z-index: 2;
    background: rgba(255, 255, 255, 0.1);
    width: 360px;
    margin: 60px auto;
    padding: 40px 30px;
    border-radius: 15px;
    box-shadow: 0 0 25px rgba(0,255,255,0.3);
    backdrop-filter: blur(10px);
    text-align: center;
    color: #fff;
    transition: all 0.4s ease;
  }
  .login-container:hover {
    transform: translateY(-5px);
    box-shadow: 0 0 35px rgba(0,255,255,0.6);
  }

  .login-container h2 {
    margin-bottom: 25px;
    color: #00c6ff;
    font-weight: 600;
  }

  /* Input fields */
  input[type=text], input[type=password] {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    border: none;
    border-radius: 6px;
    outline: none;
    font-size: 1em;
    background: rgba(255,255,255,0.2);
    color: #fff;
    transition: background 0.3s, box-shadow 0.3s;
  }
  input[type=text]:focus, input[type=password]:focus {
    background: rgba(255,255,255,0.3);
    box-shadow: 0 0 10px #00c6ff;
  }

  /* Button */
  button {
    width: 100%;
    padding: 12px;
    background: linear-gradient(90deg, #00c6ff, #0072ff);
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 1em;
    cursor: pointer;
    margin-top: 15px;
    transition: background 0.3s ease, transform 0.2s;
  }
  button:hover {
    background: linear-gradient(90deg, #0072ff, #00c6ff);
    transform: scale(1.03);
  }

  .error {
    color: #ff4c4c;
    font-size: 0.9em;
    margin-top: 10px;
  }

  /* Footer */
  footer {
    text-align: center;
    color: #aaa;
    position: relative;
    z-index: 2;
    bottom: 0;
    padding: 20px;
  }
  footer span {
    color: #00c6ff;
  }

</style>
</head>
<body>

<header>
  <h1>Reversible Data Hiding</h1>
  <nav>
    <a href="owner.jsp">Uploader</a>
    <a href="login.jsp">Receiver</a>
  </nav>
</header>

<section class="hero">
  <h2>Secure Image-Based Communication</h2>
  <p>Encrypt, Hide, and Share Sensitive Data Safely</p>
</section>

<div class="login-container">
  <h2>Sender Login</h2>
  <form method="post" action="OwnerLoginServlet">
    <input type="text" name="username" placeholder="Username" required autofocus>
    <input type="password" name="password" placeholder="Password" required>
    <button type="submit">Login</button>
  </form>

  <%
    String error = (String) request.getAttribute("error");
    if (error != null) {
  %>
    <div class="error"><%= error %></div>
  <%
    }
  %>
</div>

<footer>
  © 2025 <span>SecureVision Labs</span> | Advanced Encryption & Reversible Data Hiding Framework
</footer>

</body>
</html>
