<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reversible Data Hiding - Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

<style>
/* === GLOBAL RESET === */
*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
html, body { height: 100%; scroll-behavior: smooth; font-family: 'Poppins', sans-serif; }

/* === BACKGROUND === */
body {
  background: radial-gradient(circle at 20% 20%, #091833, #020617);
  color: #e0e7ff;
  overflow-x: hidden;
  position: relative;
}

/* Futuristic animated lines background */
body::before {
  content: "";
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: url('https://cdn.pixabay.com/photo/2016/11/29/03/53/cyber-1869233_1280.jpg') center/cover no-repeat;
  opacity: 0.25;
  z-index: -2;
  filter: brightness(0.6);
}
body::after {
  content: "";
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: linear-gradient(135deg, rgba(0,0,0,0.8), rgba(6,182,212,0.2));
  z-index: -1;
}

/* === HEADER === */
header {
  background: rgba(0, 0, 0, 0.35);
  backdrop-filter: blur(10px);
  padding: 25px 50px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: sticky;
  top: 0;
  z-index: 10;
  border-bottom: 1px solid rgba(255,255,255,0.1);
}

header h1 {
  color: #4fd1c5;
  font-size: 1.8rem;
  letter-spacing: 2px;
  text-shadow: 0 0 10px #06b6d4;
  user-select: none;
}

nav a {
  color: #e0f2fe;
  text-decoration: none;
  font-weight: 600;
  margin-left: 25px;
  transition: 0.3s;
}
nav a:hover {
  color: #06b6d4;
  text-shadow: 0 0 8px #0bc5ea;
}

/* === HERO SECTION === */
.hero {
  text-align: center;
  padding: 80px 20px 40px;
}
.hero h2 {
  font-size: 2.8rem;
  color: #81e6d9;
  text-shadow: 0 0 15px #38b2ac;
  animation: fadeIn 2s ease-in;
}
.hero p {
  color: #bde0fe;
  font-size: 1.1rem;
  margin-top: 10px;
  opacity: 0.9;
  animation: fadeInUp 2s ease-in;
}
@keyframes fadeIn { from {opacity: 0;} to {opacity: 1;} }
@keyframes fadeInUp { from {opacity: 0; transform: translateY(30px);} to {opacity: 1; transform: translateY(0);} }

/* === DASHBOARD CARDS === */
main {
  display: flex;
  justify-content: center;
  align-items: stretch;
  flex-wrap: wrap;
  gap: 30px;
  padding: 60px 40px 120px;
}

.card {
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(6,182,212,0.4);
  border-radius: 20px;
  width: 300px;
  padding: 40px 30px;
  text-align: center;
  box-shadow: 0 0 30px rgba(6,182,212,0.3);
  backdrop-filter: blur(15px);
  transition: transform 0.4s ease, box-shadow 0.4s ease;
}
.card:hover {
  transform: translateY(-15px) scale(1.05);
  box-shadow: 0 0 50px rgba(6,182,212,0.7);
}
.card h3 {
  color: #67e8f9;
  margin-bottom: 20px;
  font-size: 1.5rem;
  text-shadow: 0 0 8px #0ea5e9;
}

.btn {
  display: inline-block;
  background: linear-gradient(135deg, #06b6d4, #0891b2);
  color: #fff;
  font-weight: 600;
  padding: 12px 0;
  width: 100%;
  border: none;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: none;
}
.btn:hover {
  background: linear-gradient(135deg, #38b2ac, #06b6d4);
  box-shadow: 0 0 20px rgba(6,182,212,0.8);
  transform: scale(1.05);
}

/* === FOOTER === */
footer {
  background: rgba(0, 0, 0, 0.4);
  backdrop-filter: blur(12px);
  color: #81e6d9;
  text-align: center;
  padding: 20px 10px;
  font-size: 0.9rem;
  letter-spacing: 1px;
  position: fixed;
  bottom: 0;
  width: 100%;
}

/* === RESPONSIVE === */
@media (max-width: 768px) {
  header {
    flex-direction: column;
  }
  main {
    flex-direction: column;
    align-items: center;
    padding: 40px 20px;
  }
  .hero h2 { font-size: 2rem; }
}
</style>
</head>

<body>

<!-- HEADER -->
<header>
  <h1>Reversible Data Hiding</h1>
  <nav>
    <a href="upload.jsp">Upload</a>
    <a href="masterKeyRequests">Receiver_Request</a>
    <a href="login.jsp">Logout</a>
  </nav>
</header>

<!-- HERO SECTION -->
<section class="hero">
  <h2>Secure. Encrypt. Hide.</h2>
  <p>Manage your secure image encryption and data hiding operations with full transparency and control.</p>
</section>

<!-- MAIN DASHBOARD -->
<main>
  <div class="card">
    <h3>Upload Stego Image</h3>
    <a href="upload.jsp" class="btn">Go to Upload</a>
  </div>

  <div class="card">
    <h3>Receiver Requests</h3>
    <a href="masterKeyRequests" class="btn">View Requests</a>
  </div>

  <div class="card">
    <h3>Extract Hidden Data</h3>
    <a href="extract.jsp" class="btn">Decrypt / Extract</a>
  </div>

  <div class="card">
    <h3>Analytics</h3>
    <a href="analytics.jsp" class="btn">View Dashboard</a>
  </div>
</main>

<!-- FOOTER -->
<footer>
  © 2025 Reversible Data Hiding | Designed for Secure & Intelligent Data Embedding
</footer>

</body>
</html>
