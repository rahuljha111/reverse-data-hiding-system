<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Upload Image - Reversible Data Hiding</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

<style>
/* === GLOBAL RESET === */
*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
html, body { height: 100%; scroll-behavior: smooth; font-family: 'Poppins', sans-serif; }

/* === BACKGROUND === */
body {
  background: radial-gradient(circle at 20% 20%, #0a1128, #010409);
  color: #e0f2fe;
  overflow-x: hidden;
  position: relative;
}

/* Futuristic background image */
body::before {
  content: "";
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: url('https://cdn.pixabay.com/photo/2017/08/30/01/05/cyber-security-2693844_1280.jpg') center/cover no-repeat;
  opacity: 0.25;
  z-index: -2;
  filter: brightness(0.6);
}
body::after {
  content: "";
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: linear-gradient(135deg, rgba(0,0,0,0.8), rgba(6,182,212,0.15));
  z-index: -1;
}

/* === HEADER === */
header {
  background: rgba(0,0,0,0.4);
  backdrop-filter: blur(12px);
  padding: 25px 60px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid rgba(255,255,255,0.1);
  position: sticky;
  top: 0;
  z-index: 10;
}
header h1 {
  color: #4fd1c5;
  font-size: 1.8rem;
  letter-spacing: 2px;
  text-shadow: 0 0 12px #06b6d4;
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
  font-size: 2.4rem;
  color: #81e6d9;
  text-shadow: 0 0 15px #38b2ac;
  animation: fadeIn 1.5s ease;
}
.hero p {
  color: #bde0fe;
  font-size: 1.1rem;
  margin-top: 10px;
  opacity: 0.9;
  animation: fadeInUp 2s ease;
}
@keyframes fadeIn { from {opacity:0;} to {opacity:1;} }
@keyframes fadeInUp { from {opacity:0; transform:translateY(30px);} to {opacity:1; transform:translateY(0);} }

/* === UPLOAD CONTAINER === */
.upload-box {
  max-width: 500px;
  margin: 40px auto 100px;
  padding: 40px 50px;
  background: rgba(255,255,255,0.07);
  border: 1px solid rgba(6,182,212,0.4);
  border-radius: 20px;
  box-shadow: 0 0 40px rgba(6,182,212,0.25);
  backdrop-filter: blur(12px);
  text-align: center;
  animation: fadeInUp 2s ease;
}
.upload-box h3 {
  color: #67e8f9;
  margin-bottom: 25px;
  text-shadow: 0 0 8px #0ea5e9;
  font-size: 1.6rem;
}
input[type=file] {
  display: block;
  margin: 20px auto;
  padding: 10px;
  background: rgba(0,0,0,0.5);
  color: #e0f2fe;
  border: 1px dashed #06b6d4;
  border-radius: 8px;
  width: 100%;
  cursor: pointer;
  transition: 0.3s;
}
input[type=file]:hover {
  background: rgba(6,182,212,0.1);
  border-color: #0bc5ea;
}
button {
  padding: 12px 0;
  width: 100%;
  background: linear-gradient(135deg, #06b6d4, #0891b2);
  border: none;
  border-radius: 50px;
  color: #fff;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}
button:hover {
  background: linear-gradient(135deg, #38b2ac, #06b6d4);
  box-shadow: 0 0 20px rgba(6,182,212,0.8);
  transform: scale(1.05);
}

/* === FOOTER === */
footer {
  background: rgba(0, 0, 0, 0.4);
  backdrop-filter: blur(10px);
  color: #81e6d9;
  text-align: center;
  padding: 20px 10px;
  font-size: 0.9rem;
  letter-spacing: 1px;
  position: fixed;
  bottom: 0;
  width: 100%;
}
@media (max-width: 768px) {
  header { flex-direction: column; }
  .upload-box { width: 90%; padding: 30px; }
  .hero h2 { font-size: 1.9rem; }
}
</style>
</head>
<body>

<!-- HEADER -->
<header>
  <h1>Reversible Data Hiding</h1>
  <nav>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="masterKeyRequests">Receiver Request</a>
    <a href="login.jsp">Logout</a>
  </nav>
</header>

<!-- HERO SECTION -->
<section class="hero">
  <h2>Upload Encrypted Image</h2>
  <p>Securely upload your image for reversible data hiding and encryption.</p>
</section>

<!-- UPLOAD FORM -->
<div class="upload-box">
  <h3>Select Image File</h3>
  <form method="post" action="upload" enctype="multipart/form-data">
    <input type="file" name="image" accept="image/*" required />
    <button type="submit">Encrypt & Upload</button>
  </form>
</div>

<!-- FOOTER -->
<footer>
  © 2025 Reversible Data Hiding | Secure, Smart & Confidential
</footer>

</body>
</html>
