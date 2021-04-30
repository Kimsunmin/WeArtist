let searchType;

function search(){
let searchBox = document.getElementById("search_box");
console.log(searchType);
	if(searchType=='tag'){
		selectBoardByTag(searchBox.value);
	}else if(searchType=='bdTitle'){
		selectBoardByTitle(searchBox.value);
	}else if(searchType=='bdContent'){
		selectBoardByContent(searchBox.value);
	}else if(searchType=='name'){
		selectBoardByName(searchBox.value);
	}
}

function selectBoardByTag(tag){
	
	const url = "/search/tag?tag="+tag
	console.log(tag);
	fetch(url,{
		method : "GET"
	}).then(response=>{
		if(response.ok){
			return response.text();
		}
	}).then((text)=>{
		document.getElementById("search_box").value="";
		let boardList = JSON.parse(text);
		drawSearchResult(boardList);
	});
}




function selectBoardByTitle(bdTitle){
	const url = '/search/bdTitle?bdTitle='+bdTitle;
	fetch(url,{
		method : "GET"
	}).then(response=>{
		if(response.ok){
			return response.text();
		}
	}).then((text)=>{
		let boardList = JSON.parse(text);
		document.getElementById("search_box").value="";
		drawSearchResult(boardList);
		
	});
}

function selectBoardByContent(bdContent){
	const url = '/search/bdContent?bdContent='+bdContent;
	fetch(url,{
		method : "GET"
	}).then(response=>{
		if(response.ok){
			return response.text();
		}
	}).then((text)=>{
		document.getElementById("search_box").value="";
		let boardList = JSON.parse(text);
		drawSearchResult(boardList);
	});
}

function selectBoardByName(name){
	const url = '/search/name?name='+name;
	fetch(url,{
		method : "GET"
	}).then(response=>{
		if(response.ok){
			return response.text();
		}
	}).then((text)=>{
		document.getElementById("search_box").value="";
		let boardList = JSON.parse(text);
		drawSearchResult(boardList);
	});
}

function selectBoardAll(){
	console.log("selectBoardAll")
	const url = '/search/all';
	fetch(url,{
		method : "GET"
	}).then(response=>{
		if(response.ok){
			return response.text();
		}
	}).then((text)=>{
		let boardList = JSON.parse(text);
		drawSearchResult(boardList);
	});
}


function drawSearchResult(boardList){
		imageList = boardList;
		let imageLayout = document.getElementById("image_layout");
		while(imageLayout.hasChildNodes()){
			imageLayout.removeChild(imageLayout.firstChild);
		}
		console.dir(imageList);
		for(let i = 0; i<imageList.length; i++){
		let wrapImageBox = document.createElement("div");
		wrapImageBox.setAttribute("class","col-lg-3 col-md-4");
		
		let imageBox = document.createElement("div");
		imageBox.setAttribute("class","venue-gallery image_item")
		imageBox.setAttribute("data-imagelink",imageList[i].fSavePath+"/"+imageList[i].fRename);
		imageBox.setAttribute("data-fidx",imageList[i].fIdx);
		imageBox.setAttribute("data-nickname",imageList[i].nickName);
		
		let image = document.createElement("img");
		image.setAttribute("class","img-fluid");
		image.src = "/images/"+boardList[i].fSavePath+"/"+boardList[i].fRename
		
		imageBox.appendChild(image);
		wrapImageBox.appendChild(imageBox);
		imageLayout.appendChild(wrapImageBox);	
		}
				
		let imageItemList = document.querySelectorAll('.image_item');
		
		for(let i=0;i<imageItemList.length; i++){
			imageItemList[i].addEventListener('click',(e)=>{
				showModal(imageItemList[i].dataset.imagelink,imageItemList[i].dataset.fidx,imageItemList[i].dataset.nickname);
			});
			
			}	
}

function movePersonalPage(){
	let nickName = document.getElementById("user_nickname").innerHTML;
	location.href="/personal/personal?nickName="+nickName;
}


  let myModalEl = document.getElementById('exampleModal')
  myModalEl.addEventListener('hidden.bs.modal', function (event) {
	  let carouselInner = document.querySelector(".carousel-inner");
	  while(carouselInner.hasChildNodes()){
		  carouselInner.removeChild(carouselInner.firstChild);
	  }
  });
  
  let modalCloseBtn = document.getElementById('btn_modal_close');
  modalCloseBtn.addEventListener('click',function(){
	  $('#exampleModal').modal("hide");
  })
  myModalEl.addEventListener('shown.bs.modal',function(event){
	
  });


let list = document.querySelectorAll('.btn-check');
	list.forEach((e)=>{
		if(e.checked){
			searchType = e.dataset.type;
		}
		e.addEventListener('click',(event)=>{
			searchType = event.target.dataset.type;
			if(searchType=='all'){
				selectBoardAll();
			}
		});
	});


