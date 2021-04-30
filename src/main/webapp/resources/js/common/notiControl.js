function fetchNotiCount(){
	const url = 'communocation/fetchnoticount';
	fetch(url,{
		method : "POST",
	}).then(response=>{
		if(response.ok){
			return response.text();
		}
	}).then((text)=>{
		console.dir(text);
	});
	
}