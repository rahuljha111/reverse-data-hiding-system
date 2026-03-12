<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reversible Data Hiding - Dashboard</title>
<style>
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
  }

  body {
    height: 100vh;
    background: radial-gradient(circle at top left, #0b1220, #020617 70%);
    color: #ffffff;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  header {
    width: 100%;
    padding: 20px 0;
    text-align: center;
    background: linear-gradient(90deg, #0ea5e9, #38bdf8, #0ea5e9);
    background-size: 200% 200%;
    animation: gradientMove 6s infinite alternate;
    color: #fff;
    box-shadow: 0 0 25px rgba(14,165,233,0.3);
  }

  @keyframes gradientMove {
    0% { background-position: left; }
    100% { background-position: right; }
  }

  header h1 {
    letter-spacing: 1px;
    font-size: 28px;
  }

  nav {
    margin-top: 60px;
    display: flex;
    gap: 50px;
  }

  nav a {
    text-decoration: none;
    color: #fff;
    font-weight: 600;
    letter-spacing: 0.5px;
    font-size: 18px;
    padding: 15px 35px;
    border: 2px solid transparent;
    border-radius: 8px;
    background: rgba(255,255,255,0.05);
    box-shadow: 0 0 10px rgba(255,255,255,0.1);
    transition: all 0.4s ease;
    position: relative;
    overflow: hidden;
  }

  nav a::before {
    content: '';
    position: absolute;
    top: 0; left: -100%;
    width: 100%; height: 100%;
    background: linear-gradient(90deg, #0ea5e9, #38bdf8);
    transition: all 0.4s ease;
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
    transform: translateY(-3px);
    color: #fff;
    box-shadow: 0 0 15px rgba(56,189,248,0.4);
  }

  .content {
    margin-top: 80px;
    text-align: center;
    max-width: 700px;
    line-height: 1.6;
    color: #d1d5db;
    background: rgba(255,255,255,0.05);
    padding: 30px;
    border-radius: 15px;
    backdrop-filter: blur(10px);
    box-shadow: 0 0 20px rgba(56,189,248,0.2);
  }

  .content h2 {
    color: #38bdf8;
    margin-bottom: 15px;
    font-size: 24px;
  }

  footer {
    position: absolute;
    bottom: 10px;
    color: #94a3b8;
    font-size: 14px;
  }

  /* Floating background animation */
  .circles {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    z-index: -1;
  }

  .circles span {
    position: absolute;
    display: block;
    width: 20px;
    height: 20px;
    background: rgba(56,189,248,0.15);
    animation: move 25s linear infinite;
    bottom: -150px;
    border-radius: 50%;
  }

  @keyframes move {
    0% { transform: translateY(0) rotate(0deg); opacity: 1; }
    100% { transform: translateY(-1000px) rotate(720deg); opacity: 0; }
  }

  .circles span:nth-child(1) { left: 25%; width: 80px; height: 80px; animation-delay: 0s; }
  .circles span:nth-child(2) { left: 10%; width: 20px; height: 20px; animation-delay: 2s; animation-duration: 12s; }
  .circles span:nth-child(3) { left: 70%; width: 20px; height: 20px; animation-delay: 4s; }
  .circles span:nth-child(4) { left: 40%; width: 60px; height: 60px; animation-delay: 0s; animation-duration: 18s; }
  .circles span:nth-child(5) { left: 65%; width: 110px; height: 110px; animation-delay: 0s; }
  .circles span:nth-child(6) { left: 75%; width: 150px; height: 150px; animation-delay: 3s; }
  .circles span:nth-child(7) { left: 35%; width: 25px; height: 25px; animation-delay: 7s; animation-duration: 45s; }

</style>
</head>
<body>

<div class="circles">
  <span></span><span></span><span></span><span></span><span></span><span></span><span></span>
</div>

<header>
  <h1>Reversible Data Hiding - Secure Steganography</h1>
</header>

<nav>
  <a href="upload1.jsp"><span>Upload Stego Image</span></a>
  <a href="operResponse.jsp"><span>Open Response</span></a>
  <a href="login.jsp"><span>Logout</span></a>
</nav>

<div class="content">
  <h2>Welcome to the RDH Uploader Portal</h2>
  <p>
    Manage your stego image uploads securely and track responses in real-time.  
    This portal ensures every operation is protected with advanced reversible data hiding techniques for data confidentiality and integrity.
  </p>
</div>

<footer>© 2025 Reversible Data Hiding System | Secure Digital Embedding</footer>

</body>
</html>
