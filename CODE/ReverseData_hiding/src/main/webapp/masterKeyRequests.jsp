<%@page import="com.controller.MasterKeyRequests.Request"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Master Key Requests</title>
<style>
  body { font-family: Arial, sans-serif; margin: 30px; }
  table { border-collapse: collapse; width: 80%; margin: 0 auto; }
  th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
  button { padding: 6px 12px; cursor: pointer; }
  .keyInput { display: none; margin-top: 6px; }
</style>
<script>
  function showInput(id) {
    document.getElementById('keyInput_' + id).style.display = 'inline-block';
    document.getElementById('approveBtn_' + id).style.display = 'none';
  }
</script>
</head>
<body>

<h2 style="text-align:center;">Pending Master Key Requests</h2>

<%
    List<Request> requests = (List<Request>) request.getAttribute("requests");
    if (requests == null || requests.isEmpty()) {
%>
    <p style="text-align:center;">No pending requests.</p>
<%
    } else {
%>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Request Time</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% for (Request r : requests) { %>
                <tr>
                    <td><%= r.id %></td>
                    <td><%= r.username %></td>
                    <td><%= r.requestTime %></td>
                    <td>
                        <button id="approveBtn_<%= r.id %>" onclick="showInput(<%= r.id %>)">Approve</button>
                        <form method="post" style="display:inline;" action="masterKeyRequests">
                            <input type="hidden" name="id" value="<%= r.id %>" />
                            <input type="text" name="masterKey" id="keyInput_<%= r.id %>" class="keyInput" placeholder="Enter master key" required />
                            <button type="submit" class="keyInput" id="submitBtn_<%= r.id %>" style="display:none;">Submit</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <script>
      // Show submit button when input appears
      document.querySelectorAll('.keyInput').forEach(el => {
        el.addEventListener('input', function() {
          const submitBtn = this.parentElement.querySelector('button[type=submit]');
          if (this.value.trim() !== '') {
            submitBtn.style.display = 'inline-block';
          } else {
            submitBtn.style.display = 'none';
          }
        });
      });
    </script>
<%
    }
%>

</body>
</html>
