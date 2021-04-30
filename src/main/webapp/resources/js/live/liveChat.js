const contentDivClassName = 'my-1 flex-wrap btn btn-secondary text-start text-white';
const guestDivClassName = 'w-100 d-flex justify-content-end';
const hostDivClassName = 'w-100 d-flex';

let insertChatRoom = (isHost,text) => {
	let chatTile = document.createElement('div');
	
	let chatContent = document.createElement('div');
	chatContent.className = contentDivClassName;
	chatContent.innerText = text;
	chatContent.style.maxWidth = '60%';
	
	if(isHost){	
		chatTile.className = hostDivClassName;
	}else{
		chatTile.className = guestDivClassName;
	}
	
	chatTile.appendChild(chatContent);
	document.querySelector('#chatRoom').appendChild(chatTile);	
}
