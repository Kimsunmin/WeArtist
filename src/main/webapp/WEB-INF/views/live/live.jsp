<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/topMenuHead.jsp"%>

<section id="hero" class="position-relative">
	<div class="container mx-auto">
		<div class="d-flex card w-80 position-absolute top-30 start-50 translate-middle" style="top: 40%">
			<div class="card-header d-flex justify-content-between">
				<div class="align-self-center" id="hostUserId">
					${liveHostUserId}
				</div>
				<div class="flex-inline justify-content-end">
					<div class="btn btn-danger btn-sm" id="btn-close" onclick="history.back()">
						X
					</div> 
				</div>
			</div>
			<div class="d-flex justify-content-center">
				<div class="w-60" style="width: 640px; max-width:1000px; height: 480px;">
					<video id="localVideo" autoplay muted playsinline class="position-absolute"></video>
				</div>
				<div class="w-50">
					<div class="card">
						<div id="chatRoom" class="card-body d-flex flex-column justify-content-end overflow-scroll" style="max-height: 407px; height: 407px">
											
						</div>	
						<div class="card-footer">
							
							<div class="input-group mb-3">
							  <input type="text" class="form-control" id="messageInput"aria-label="Recipient's username" aria-describedby="button-addon2">
							  <div class="input-group-append">
							    <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="sendMessage()">></button>
							  </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<script type="text/javascript" src="${context}/resources/js/live/liveChat.js"></script>
<script type="text/javascript" src="${context}/resources/js/live/liveHost.js"></script>
</body>
</html>