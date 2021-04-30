let boardListClassName;
let galleryImg;
let galleryImgList = [];

let close = () => {
	document.querySelector('#BoardList').className = 'd-none';
}

let backPage = (nickName) => {
	location.href = location.origin + '/personal/personal?nickName='+nickName;
}

let init = () => {
	
	// 보드리스트의 class을 미리 저장해둔다
	boardListClassName = "card w-50 mx-auto position-fixed top-50 start-50 translate-middle shadow";
	
	// 이미지 마다 클릭 이벤트를 작성한다.
	for(let i=1; i<13; i++){
		let galleryImgDiv = document.querySelector('#gallery-img'+i);
		
		galleryImgDiv.className = 'position-relative ' + galleryImgDiv.className;
		
		galleryImgDiv.addEventListener('click',()=>{	
			galleryImg = 'gallery-img'+i;
			document.querySelector('#BoardList').className = boardListClassName;
			document.querySelector('#btn-close').addEventListener('click',close);
			});
	}
	
}

let removeGalleryInfo = () => {
	galleryImgList.forEach((item, index) => {
		if(item.imgOrder == imgOrder){
			temp = galleryImgList.splice(index,1);
			galleryImgList = temp;
		}
	})
	document.querySelector('#'+galleryImg).src = '/resources/img/defaultImg.png';
	document.querySelector('#BoardList').className = 'd-none';
}

let setGalleryInfo = (bdNo,fIdx,userId,src) => {
	let imgObj = new Object();
	imgObj.bdNo = bdNo;
	imgObj.fIdx = fIdx;
	imgObj.userId = userId;
	imgObj.path = src;
	imgObj.imgOrder = galleryImg.substring(11);
	console.dir(imgObj);
	
	setGalleryImgList(imgObj);
	console.dir(galleryImgList);
	document.querySelector('#'+galleryImg).src = src;
	document.querySelector('#BoardList').className = 'd-none';
}

let uploadGalleryInfo = (nickName) => {
	let headerObj = new Headers();

	headerObj.append("content-type","application/json");
	fetch('/galleryupload',{
		method : 'POST',
		headers : headerObj,
		body : JSON.stringify(galleryImgList)
	})
	.then(res => {
		location.href = location.origin + '/personal/personal?nickName=' + nickName;
	});
}

let setGalleryImgList = (imgObj) => {
	let flg = true;
	galleryImgList.forEach((item)=>{
		if(item.imgOrder == imgObj.imgOrder){
			let temp = new Object();
			temp = imgObj;
			imgObj = item;
			item = temp;
			flg = false;
		}	
	})
	
	if(flg){
		galleryImgList.push(imgObj);	
	}
}

init();













