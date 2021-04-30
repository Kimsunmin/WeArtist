<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<input type="text" id="msg">
	<button id="btnSend"></button>
	<script type="text/javascript">
		window.onload = function() {
			document.querySelector("#btnSend").addEventListener('click',
					function(evt) {
						evt.preventDefault();
						let msg = document.getElementById("msg").value;
						console.log(msg);
						socket.send(msg);
					});
			
			connect();
		};
	</script>
	<script type="text/javascript">
		var socket = null;
		function connect() {
			var ws = new WebSocket("ws://localhost:9898/replyEcho?bno=1234");
			socket = ws;

			ws.onopen = function() {
				console.log('Info: connection opened.');
			};

			ws.onmessage = function(event) {
				console.log("receiveMessage : ", event.data + '\n');
			};

			ws.onclose = function(event) {
				console.log('Info: connection closed.');
				//   setTimeout( function(){ connect(); }, 1000); // retry connection!!
			};
			ws.onerror = function(event) {
				console.log('Error:' + err);
			};

		}
	</script>
</body>
</html>