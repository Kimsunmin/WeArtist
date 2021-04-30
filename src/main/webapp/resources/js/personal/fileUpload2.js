const tagClassName = 'mx-2 my-2 rgyPostIt';
const addTag = document.querySelector('#add_tag');
const addTagInput = document.querySelector('#add_tag_input');
const addTagText = document.querySelector('#add_tag_text');
const tag = document.querySelector('#tag');
const imgArea = document.querySelector('.img_area');

let init = () => {
	addTag.addEventListener('click',()=>{
		if(!isTagClose()){
			insertNewTag();
		}
		addTagInput.className = tagClassName;
		addTagText.focus();
	})
	
	addTagText.addEventListener('keyup',isEnter);
}

let inputAutoSize = () => {
	let size = addTagText.value.length;
	if(size > 2){
		addTagText.size = size;	
	}else if(size){
		addTagText,size = 2;
	}
}

let insertNewTag = () => {
	let tagDiv = document.createElement('div');
	tagDiv.className = tagClassName;
	tagDiv.innerText = '#'+addTagText.value;
		
	let parentDiv = addTagInput.parentNode;
	parentDiv.insertBefore(tagDiv,addTagInput);
	
	addTagInput.className = 'd-none';
	tag.value += tagDiv.innerText + " ";
	
	addTagText.value = "";
	addTagText.size = 2;
}

let isEnter = () => {
	// addTageText에 값이 있으며 엔터를 클릭했을때
	if(window.event.keyCode == 13 && addTagText.value){
		insertNewTag();		
	}else{
		// 둘다 해당하지 않을 경우 입력한 문자열에 맞게 사이즈를 변환
		inputAutoSize();
	}
}

let isTagClose = () => {
	if(addTagInput.className == 'd-none'){
		return true;
	}else{
		return false;
	}
}

let preview = (input) => {
	console.dir(input);
	if(input.files && input.files[0]){
		for(let item of input.files){
			let reader = new FileReader();
		
			reader.onload = (e) => {
				console.dir(e);
				let img = document.createElement('img');
				img.width = 100;
				img.height = 100;
				img.src = e.target.result;
				img.className = 'mx-2 my-2';
				
				imgArea.appendChild(img);
			}
			reader.readAsDataURL(item);
		}
	}
}

let submitBtn = () => {
	if(isTagClose()){
		console.dir(document.querySelector('form'));
		document.querySelector('form').submit();	
	}
	window.opener.location.reload();

}


init();