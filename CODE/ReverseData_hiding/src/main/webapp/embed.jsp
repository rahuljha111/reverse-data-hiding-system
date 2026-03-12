<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Embed Message - RDH Demo</title>
<style>
 body { font-family: 'Poppins', sans-serif; background:#0f1724; color:#fff; padding:40px; }
 .box { width:800px; margin:0 auto; background:rgba(255,255,255,0.03); padding:26px; border-radius:10px; }
 textarea { width:100%; height:160px; border-radius:8px; padding:12px; border:1px solid rgba(255,255,255,0.08); background:#081026; color:#fff; }
 button { padding:10px 16px; background:#06b6d4; border:none; color:#fff; border-radius:8px; cursor:pointer; margin-top:12px; }
</style>
</head>
<body>
 <div class="box">
   <h2>Enter message to hide inside encrypted image</h2>
   <form method="post" action="embed">
     <textarea name="message" placeholder="Type secret message here (UTF-8)"></textarea><br/>
     <button type="submit">Embed & Generate Stego</button>
   </form>
 </div>
</body>
</html>
