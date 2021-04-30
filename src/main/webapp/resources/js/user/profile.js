
 let nicknameCheckFlg = false;
 
let nicknameCheck = () => {
      let nickName = document.getElementById("nickName");
      let curNick = document.getElementById("curNick");
      if(nickName.value != curNick.value ){
         fetch("/user/nicknamecheck?nickName=" + nickName.value,{
            method:"GET"
         })
         .then(response => response.text())
         .then(text =>{
            if(text == 'success'){
               nicknameCheckFlg = true;
               nickname_check.innerHTML = '사용 가능한 닉네임 입니다.';
            }else{
               nicknameCheckFlg = false;
               nickname_check.innerHTML = '사용 불가능한 닉네임 입니다.';
               nickName.value="";
            }
         })
         
      }else if(!nickName.value){
         alert("닉네임을 입력하지 않으셨습니다.");
      }else{
      nicknameCheckFlg = true;
      nickname_check.innerHTML = '사용 가능한 닉네임 입니다.';
   }
 }
   
   
 let preview = (input) => {
	console.dir(input);
	if(input.files && input.files[0]){
		for(let item of input.files){
			let reader = new FileReader();
		
			reader.onload = (e) => {
				console.dir(e);
				let img = document.getElementById('picture');
				img.src = e.target.result;
				
				imgArea.appendChild(img);
			}
			reader.readAsDataURL(item);
		}
	}
	submitBtn();
	
}

let submitBtn = () => {
	//if(isTagClose()){
		document.querySelector('#frm-pic').submit();	
	//}
}
	
  document.querySelector('#frm-profile').addEventListener('submit',(e)=>{
	   let password = pw.value;
	   let regExp = /^(?!.*[ㄱ-힣])(?=.*\W)(?=.*\d)(?=.*[a-zA-Z])(?=.{8,})/;
	   
	   if(!nicknameCheckFlg){
		   e.preventDefault();
		   alert("닉네임 중복검사를 하지 않으셨습니다.");
		   nickName.focus()
	   }
	   
	   if(!(regExp.test(password))){
		   //form의 데이터 전송을 막음
		   e.preventDefault();
		   pw_confirm.innerHTML = '비밀번호는 숫자,영문자,특수문자 조합의 8글자 이상인 문자열입니다.';
		   pw.value='';
	   }
   });
   