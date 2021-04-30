let fileList = [];

let srcToBlob = (src,outputBox,viewBox) => {
	let inputObj = src;
	let outputObj = document.querySelector(outputBox);
	
	loadImage(inputObj,(img,data)=>{
		img.toBlob((blob)=>{
			let rotateFile = new File([blob],data.name,{type : 'JPEG'});
			let reader = new FileReader();
			reader.onload = (e) => {
				fileList.push(rotateFile);
				outputObj.src = e.target.result;
				document.querySelector(viewBox).className = 'd-flex position-absolute';
            }
            reader.readAsDataURL(rotateFile);
		},'JPEG')		
	},{orientation : 4});
}

let sendImageTest = () => {
	
	let formData = new FormData();
	for(let i=0; i<fileList.length; i++){
		console.dir(fileList[i]);
		formData.append('test',fileList[i]); 
	}
	
	console.dir(formData);
	fetch('/sendimage',{
		method : 'POST',
		body : formData
	})
	.then(res => res.text)
	.then(res => {alert(res)});	
}