<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login | Reversible Data Hiding System</title>
<style>
/* =============== GLOBAL =============== */
* {
  margin: 0; padding: 0; box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}
body {
  background: linear-gradient(120deg, #040b1a, #071e3d);
  color: #fff;
  overflow-x: hidden;
  position: relative;
  min-height: 100vh;
}

/* =============== BACKGROUND LAYERS =============== */
.bg-overlay {
  background: url('images/a4.webp') center/cover no-repeat;
  filter: brightness(0.3) blur(2px);
  position: absolute; inset: 0; z-index: 0;
}
.bg-gradient {
  position: absolute; inset: 0;
  background: radial-gradient(circle at 30% 50%, rgba(0,217,255,0.25), transparent 70%),
              radial-gradient(circle at 70% 50%, rgba(0,132,255,0.15), transparent 70%);
  animation: moveBg 10s infinite alternate;
  z-index: 1;
}
@keyframes moveBg {
  from { transform: scale(1) translate(0,0); }
  to { transform: scale(1.2) translate(30px,20px); }
}

/* =============== HEADER =============== */
header {
  width: 100%;
  padding: 20px 60px;
  display: flex; justify-content: space-between; align-items: center;
  position: relative; z-index: 2;
  background: rgba(255,255,255,0.05);
  backdrop-filter: blur(8px);
  border-bottom: 1px solid rgba(255,255,255,0.1);
}
header h1 {
  color: #00e5ff;
  font-size: 1.8em;
  letter-spacing: 1px;
}
nav a {
  color: #fff;
  margin-left: 25px;
  text-decoration: none;
  font-weight: 500;
  transition: 0.3s;
}
nav a:hover { color: #00e5ff; text-shadow: 0 0 5px #00e5ff; }

/* =============== HERO SECTION =============== */
.hero {
  text-align: center;
  margin-top: 70px;
  position: relative;
  z-index: 2;
}
.hero h2 {
  font-size: 2em;
  font-weight: 600;
  color: #00e5ff;
  text-shadow: 0 0 15px rgba(0,229,255,0.5);
}
.hero p {
  font-size: 1.1em;
  margin-top: 10px;
  opacity: 0.85;
}

/* =============== LOGIN CARD =============== */
.card {
  position: relative;
  z-index: 3;
  background: rgba(255,255,255,0.08);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255,255,255,0.15);
  padding: 35px 25px;
  border-radius: 15px;
  width: 380px;
  margin: 60px auto;
  text-align: center;
  box-shadow: 0 0 25px rgba(0,229,255,0.2);
  transition: all 0.3s ease-in-out;
}
.card:hover {
  box-shadow: 0 0 40px rgba(0,229,255,0.4);
  transform: translateY(-5px);
}
.card h2 {
  color: #00e5ff;
  margin-bottom: 25px;
  font-weight: 600;
}

/* Inputs & button */
input {
  width: 90%;
  padding: 12px;
  margin: 10px 0;
  border: none;
  border-radius: 6px;
  background: rgba(255,255,255,0.15);
  color: #fff;
  outline: none;
  font-size: 0.95em;
  transition: all 0.3s;
}
input:focus {
  background: rgba(255,255,255,0.25);
  box-shadow: 0 0 10px #00e5ff;
}

button {
  width: 95%;
  padding: 12px;
  margin-top: 15px;
  background: linear-gradient(90deg, #00e5ff, #006eff);
  border: none;
  color: #fff;
  font-weight: 600;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}
button:hover {
  transform: scale(1.05);
  background: linear-gradient(90deg, #006eff, #00e5ff);
}

/* Status messages */
.error { color: #ff6b6b; font-size: 0.9em; margin-top: 10px; }
.success { color: #34d399; font-size: 0.9em; margin-top: 10px; }

.card a {
  color: #00e5ff;
  text-decoration: none;
  font-size: 0.9em;
  transition: 0.3s;
}
.card a:hover { text-decoration: underline; }

/* =============== FOOTER =============== */
footer {
  position: relative;
  text-align: center;
  padding: 20px;
  z-index: 2;
  color: #aaa;
  font-size: 0.9em;
}
footer span { color: #00e5ff; }
footer::before {
  content: '';
  display: block;
  width: 60%;
  height: 1px;
  background: linear-gradient(90deg, transparent, #00e5ff, transparent);
  margin: 10px auto;
  opacity: 0.5;
}
</style>
</head>

<body>

<div class="bg-overlay"></div>
<div class="bg-gradient"></div>

<header>
  <h1>Reversible Data Hiding</h1>
  <nav>
    <a href="owner.jsp">Uploader</a>
    <a href="login.jsp">Receiver</a>
  </nav>
</header>

<section class="hero">
  <h2>Secure Image Communication</h2>
  <p>Hide confidential data safely using reversible encryption techniques</p>
</section>

<div class="card">
  <h2>Welcome Back</h2>
  <form method="post" action="login">
    <input type="text" name="username" placeholder="Username" required /><br/>
    <input type="password" name="password" placeholder="Password" required /><br/>
    <button type="submit">Login</button>
  </form>

  <div style="margin-top:10px;">
    <a href="register.jsp">Don’t have an account? Register</a>
  </div>

  <% 
     String msg = request.getParameter("msg");
     if ("invalid".equals(msg)) { %>
       <p class="error">❌ Invalid username or password.</p>
  <% } else if ("logout".equals(msg)) { %>
       <p class="success">✅ You’ve been logged out successfully.</p>
  <% } %>
</div>

<footer>
  © 2025 <span>SecureVision Labs</span> | Reversible Data Hiding & Encryption Framework
</footer>

</body>
</html>
