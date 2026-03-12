<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stego Image - RDH Demo</title>
<style>
 body { font-family:'Poppins',sans-serif; background:#0b1220; color:#fff; padding:36px; text-align:center; }
 .card { width:80%; margin:0 auto; background:rgba(255,255,255,0.02); padding:24px; border-radius:10px; }
 img { max-width:70%; border-radius:8px; box-shadow:0 8px 30px rgba(0,0,0,0.5); margin-top:15px; }
 input[type=text] { width:60%; padding:8px; border-radius:6px; border:1px solid rgba(255,255,255,0.06); background:#071026; color:#fff; }
 button { padding:10px 16px; background:#06b6d4; border:none; color:#fff; border-radius:8px; cursor:pointer; margin:8px; }
 .hint { font-size:14px; color:#9ca3af; margin-top:10px; }
 .btn-row { margin-top:15px; }
</style>
</head>
<body>
 <div class="card">
   <h2>Stego Image (message embedded)</h2>
   <%
       javax.servlet.http.HttpSession sess = request.getSession();
       byte[] stPNG = (byte[]) sess.getAttribute("stegoImagePNG");
       if (stPNG != null) {
           String b64 = Base64.getEncoder().encodeToString(stPNG);
   %>
       <img id="stegoImg" src="data:image/png;base64,<%=b64%>" alt="Stego Image"/><br/>

       <div class="btn-row">
         <!-- Download (Save) button -->
         <button type="button" onclick="downloadImage()">💾 Save Image</button>

         <!-- Share button -->
         <button type="button" onclick="shareImage()">📤 Share Image</button>
       </div>

       <div class="hint">Use the master key shown earlier (after encryption) to extract the message and recover original.</div>

       <form method="post" action="extract" style="margin-top:18px;">
          <input type="text" name="masterKey" placeholder="Paste master key (or leave empty to use saved key)" />
          <br/>
          <button type="submit">Extract & Recover Original</button>
       </form>
   <%
       } else {
   %>
     <p>No stego image found. Embed a message first.</p>
   <%
       }
   %>
 </div>

 <script>
function downloadImage() {
  const img = document.getElementById("stegoImg");
  const link = document.createElement("a");
  link.href = img.src;
  link.download = "stego_image.png";
  link.click();
}

async function shareImage() {
  const recipient = prompt("Enter recipient username to share this image:");
  if (!recipient) return;

  // Send recipient username to servlet
  try {
    const resp = await fetch("shareImage", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: "recipient=" + encodeURIComponent(recipient)
    });

    const text = await resp.text();
    alert(text);
  } catch (err) {
    alert("Error sharing image: " + err.message);
  }
}
</script>
</body>
</html>
