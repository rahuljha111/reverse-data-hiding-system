<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Register | Reversible Data Hiding System</title>
<style>
/* ======= BASE RESET ======= */
* {
  margin: 0; padding: 0; box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}
body {
  min-height: 100vh;
  background: radial-gradient(circle at top left, #051937, #0b1220 70%);
  color: #fff;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

/* ======= BACKGROUND LAYERS ======= */
.bg-image {
  position: fixed;
  top: 0; left: 0; width: 100%; height: 100%;
  background: url('images/a5.webp') center/cover no-repeat;
  filter: brightness(0.35) blur(0.5px);
  z-index: 0;
}
.bg-gradient {
  position: fixed;
  top: 0; left: 0; width: 100%; height: 100%;
  background: radial-gradient(circle at 20% 30%, rgba(0,255,255,0.25), transparent 60%),
              radial-gradient(circle at 80% 70%, rgba(0,120,255,0.2), transparent 70%);
  animation: moveGradient 12s ease-in-out infinite alternate;
  z-index: 1;
}
@keyframes moveGradient {
  0% { transform: scale(1) translate(0,0); }
  100% { transform: scale(1.2) translate(30px,20px); }
}

/* ======= HEADER ======= */
header {
  width: 100%;
  padding: 20px 60px;
  display: flex; justify-content: space-between; align-items: center;
  position: fixed; top: 0; left: 0;
  background: rgba(255,255,255,0.05);
  backdrop-filter: blur(8px);
  border-bottom: 1px solid rgba(255,255,255,0.1);
  z-index: 5;
}
header h1 {
  font-size: 1.7em;
  color: #00e5ff;
  letter-spacing: 1px;
  text-shadow: 0 0 10px rgba(0,229,255,0.5);
}
nav a {
  color: #fff;
  text-decoration: none;
  margin-left: 25px;
  font-weight: 500;
  transition: 0.3s;
}
nav a:hover {
  color: #00e5ff;
  text-shadow: 0 0 6px #00e5ff;
}

/* ======= REGISTER CARD ======= */
.card {
  position: relative;
  z-index: 3;
  background: rgba(255,255,255,0.07);
  backdrop-filter: blur(12px);
  border: 1px solid rgba(255,255,255,0.15);
  padding: 40px 30px;
  border-radius: 15px;
  width: 380px;
  text-align: center;
  margin-top: 120px;
  box-shadow: 0 0 25px rgba(0,229,255,0.25);
  transition: all 0.4s ease;
}
.card:hover {
  box-shadow: 0 0 40px rgba(0,229,255,0.45);
  transform: translateY(-6px);
}
.card h2 {
  color: #00e5ff;
  font-size: 1.6em;
  margin-bottom: 25px;
  font-weight: 600;
}

/* Inputs */
input {
  width: 90%;
  padding: 12px;
  margin: 10px 0;
  border: none;
  border-radius: 8px;
  background: rgba(255,255,255,0.12);
  color: #fff;
  font-size: 1em;
  outline: none;
  transition: 0.3s;
}
input:focus {
  background: rgba(255,255,255,0.25);
  box-shadow: 0 0 12px #00e5ff;
}

/* Button */
button {
  width: 95%;
  padding: 12px;
  margin-top: 15px;
  background: linear-gradient(90deg, #00e5ff, #0070ff);
  border: none;
  color: #fff;
  font-weight: 600;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s;
}
button:hover {
  transform: scale(1.05);
  background: linear-gradient(90deg, #0070ff, #00e5ff);
}

/* Links */
.card a {
  color: #00e5ff;
  text-decoration: none;
  display: inline-block;
  margin-top: 12px;
  font-size: 0.9em;
  transition: 0.3s;
}
.card a:hover { text-decoration: underline; }

/* Messages */
.error { color: #ff6b6b; font-size: 0.9em; margin-top: 10px; }
.success { color: #34d399; font-size: 0.9em; margin-top: 10px; }

/* ======= FOOTER ======= */
footer {
  text-align: center;
  position: fixed;
  bottom: 10px;
  width: 100%;
  color: #999;
  font-size: 0.9em;
  z-index: 5;
}
footer::before {
  content: '';
  display: block;
  width: 60%;
  height: 1px;
  background: linear-gradient(90deg, transparent, #00e5ff, transparent);
  margin: 10px auto;
  opacity: 0.4;
}
footer span { color: #00e5ff; }

/* ======= FLOATING PARTICLES ======= */
.particle {
  position: absolute;
  width: 6px; height: 6px;
  background: #00e5ff;
  border-radius: 50%;
  opacity: 0.5;
  animation: float 10s infinite ease-in-out;
}
@keyframes float {
  0% { transform: translateY(0); opacity: 0.3; }
  50% { transform: translateY(-30px); opacity: 0.8; }
  100% { transform: translateY(0); opacity: 0.3; }
}
.particle:nth-child(1){ top:10%; left:15%; animation-delay:0s; }
.particle:nth-child(2){ top:40%; left:80%; animation-delay:2s; }
.particle:nth-child(3){ top:70%; left:25%; animation-delay:4s; }
.particle:nth-child(4){ top:85%; left:60%; animation-delay:1s; }
.particle:nth-child(5){ top:30%; left:50%; animation-delay:3s; }
</style>
</head>

<body>

<div class="bg-image"></div>
<div class="bg-gradient"></div>
<div class="particle"></div>
<div class="particle"></div>
<div class="particle"></div>
<div class="particle"></div>
<div class="particle"></div>

<header>
  <h1>Reversible Data Hiding</h1>
  <nav>
    <a href="owner.jsp">Uploader</a>
    <a href="login.jsp">Receiver</a>
  </nav>
</header>

<div class="card">
  <h2>Create Account</h2>
  <form method="post" action="register">
    <input type="text" name="username" placeholder="Username" required /><br/>
    <input type="password" name="password" placeholder="Password" required /><br/>
    <input type="password" name="confirmPassword" placeholder="Confirm Password" required /><br/>
    <button type="submit">Register</button>
  </form>

  <a href="login.jsp">Already have an account? Login</a>

  <% 
     String msg = request.getParameter("msg");
     if ("success".equals(msg)) { %>
       <p class="success">✅ Registration successful! You can now log in.</p>
  <% } else if ("error".equals(msg)) { %>
       <p class="error">❌ Registration failed. Username may already exist.</p>
  <% } else if ("mismatch".equals(msg)) { %>
       <p class="error">❌ Passwords do not match.</p>
  <% } %>
</div>

<footer>
  © 2025 <span>SecureVision Labs</span> | Reversible Data Hiding Platform
</footer>

</body>
</html>
