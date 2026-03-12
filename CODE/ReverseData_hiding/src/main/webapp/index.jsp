<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Reversible Data Hiding System</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(rgba(0,0,0,0.15), rgba(0,0,0,0.25)),
                  url('images/rhd1.png')
                  no-repeat center center fixed;
      background-size: cover;
      color: #fff;
      overflow-x: hidden;
    }

    header {
      width: 100%;
      background: rgba(0, 0, 0, 0.8);
      backdrop-filter: blur(10px);
      border-bottom: 1px solid rgba(0,229,255,0.3);
      position: fixed;
      top: 0;
      left: 0;
      z-index: 1000;
    }

    .header-container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .logo {
      font-size: 1.7em;
      font-weight: 700;
      color: #00e5ff;
      text-shadow: 0 0 10px #00e5ff;
    }

    nav a {
      color: #fff;
      text-decoration: none;
      margin-left: 25px;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    nav a:hover {
      color: #00e5ff;
      text-shadow: 0 0 10px #00e5ff;
    }

    .hero {
      height: 100vh;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      text-align: center;
      padding: 0 10%;
      background: rgba(0,0,0,0.01);
    }

    .hero h1 {
      font-size: 3em;
      font-weight: 700;
      color: #00e5ff;
      text-shadow: 0 0 25px rgba(0,229,255,0.6);
      margin-bottom: 25px;
    }

    .hero p {
      font-size: 1.1em;
      color: #dff9fb;
      max-width: 700px;
      margin-bottom: 40px;
      line-height: 1.6;
    }

    .hero a {
      background: linear-gradient(90deg, #00e5ff, #0099ff);
      color: #000;
      padding: 14px 40px;
      border-radius: 30px;
      font-weight: 600;
      text-decoration: none;
      box-shadow: 0 0 25px rgba(0,229,255,0.7);
      transition: all 0.3s ease;
    }

    .hero a:hover {
      transform: scale(1.1);
      background: #fff;
      color: #00e5ff;
      box-shadow: 0 0 35px rgba(0,229,255,0.9);
    }

    section.features {
      display: flex;
      justify-content: center;
      flex-wrap: wrap;
      gap: 30px;
      padding: 80px 10%;
      background: rgba(0,0,0,0.6);
      border-top: 1px solid rgba(0,229,255,0.3);
    }

    .feature {
      background: rgba(255,255,255,0.08);
      padding: 30px;
      border-radius: 12px;
      text-align: center;
      width: 280px;
      box-shadow: 0 0 25px rgba(0,0,0,0.3);
      transition: all 0.3s ease;
    }

    .feature:hover {
      transform: translateY(-10px);
      box-shadow: 0 0 35px rgba(0,229,255,0.6);
    }

    .feature h3 {
      color: #00e5ff;
      margin-bottom: 10px;
    }

    footer {
      text-align: center;
      padding: 40px 20px;
      background: rgba(0,0,0,0.9);
      border-top: 1px solid rgba(0,229,255,0.3);
      color: #aaa;
    }

    footer a {
      color: #00e5ff;
      text-decoration: none;
      margin: 0 10px;
    }

    footer a:hover {
      color: #fff;
      text-decoration: underline;
    }

    @media (max-width: 768px) {
      .header-container {
        flex-direction: column;
        text-align: center;
      }
      nav {
        margin-top: 10px;
      }
      .hero h1 { font-size: 2.2em; }
    }
  </style>
</head>

<body>
<header>
  <div class="header-container">
    <div class="logo">Reversible Data Hiding</div>
    <nav>
      <a href="owner.jsp">Uploader</a>
      <a href="login.jsp">Receiver</a>
    </nav>
  </div>
</header>

<section class="hero">
  <!-- <h1>Secure & Reversible Data Hiding in Encrypted Images</h1>
  <p>
    Experience next-generation image protection where encryption meets reversibility.  
    Our system ensures both high security and complete image restoration capability — powered by advanced RDH algorithms.
  </p> -->
  <!-- <a href="register.jsp">Start Secure Upload</a> -->
</section>

<section class="features">
  <div class="feature">
    <h3>Pixel-Level Encryption</h3>
    <p>Encrypt pixel data using advanced block-based cryptographic methods.</p>
  </div>
  <div class="feature">
    <h3>Data Embedding</h3>
    <p>Embed confidential data in encrypted domains with no distortion in recovery.</p>
  </div>
  <div class="feature">
    <h3>Lossless Recovery</h3>
    <p>Achieve perfect reconstruction of both secret data and original images.</p>
  </div>
</section>

<footer>
  <p>© 2025 Reversible Data Hiding Project • Designed by Baji Babu</p>
  <p>
    <a href="#">About</a> |
    <a href="#">Privacy</a> |
    <a href="#">Contact</a>
  </p>
</footer>
</body>
</html>
