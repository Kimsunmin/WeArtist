let userNickNameList = new Array();
userNameList = new Array();
let allUserList = null;
function getAlluser(){
	const url = '/communication/alluserlist';
	
	fetch(url,{
		method : "GET"
	}).then(response =>{
		if(response.ok){
			return response.text();
		}
	}).then((text)=>{
		allUserList = JSON.parse(text);
		for(let i =0; i<allUserList.length; i++){
			userNickNameList.push(allUserList[i].nickName);
			userNameList.push(allUserList[i].name);
		}
		let inputSearch = document.getElementById("inp_search_user");
//		autoCompleteByNickName(inputSearch,userNickNameList);
		autoCompleteByUserName(inputSearch,userNameList);
	});
}

function autoCompleteByUserName(inp, arr) {
	var currentFocus;
	inp.addEventListener("input", function(e) {
		var a, b, i, val = this.value;
		closeAllLists();
		if (!val) {
			return false;
		}
		currentFocus = -1;
		let fixedCard = document.getElementById("auto_search");
		fixedCard.style="width:30vw; z-index:999; visibility:visible; margin-top:7.7vh;"
		a = document.createElement("DIV");
		a.setAttribute("id", this.id + "autocomplete-list");
		a.setAttribute("class", "autocomplete-items");
		for (i = 0; i < arr.length; i++) {
			if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
				let ul = document.createElement("ul");
				ul.setAttribute("class", "list-group list-group-flush");
				let li= document.createElement("li");
				li.setAttribute("class","list-group-item");
				li.style="border:1px thin;"
				let testDiv = document.createElement("div");
				testDiv.setAttribute("class","d-flex flex-column")
				let nameTag = document.createElement("a");
				nameTag.innerHTML = arr[i].substr(0, val.length);
				nameTag.innerHTML +=arr[i].substr(val.length);
				nameTag.innerHTML +="<input type='hidden' value='" + arr[i] + "'>";
				nameTag.setAttribute("href","/personal/personal?nickName="+allUserList[i].nickName);
				nameTag.setAttribute("class","text-muted fs-5")
				let nickNameTag = document.createElement("a");
				nickNameTag.setAttribute("href","/personal/personal?nickName="+allUserList[i].nickName);
				nickNameTag.setAttribute("class","text-muted fs-6")
				nickNameTag.innerHTML = allUserList[i].nickName
				
				testDiv.append(nameTag,nickNameTag);
				li.appendChild(testDiv);
				ul.appendChild(li);
				a.appendChild(ul);
				fixedCard.appendChild(a);
			}
		}
	});
	inp.addEventListener("keydown", function(e) {
		var x = document.getElementById(this.id + "autocomplete-list");
		if (x) x = x.getElementsByTagName("div");
		if (e.keyCode == 40) {
			currentFocus++;
			addActive(x);
		} else if (e.keyCode == 38) { //up
			currentFocus--;
			addActive(x);
		} else if (e.keyCode == 13) {
			e.preventDefault();
			if (currentFocus > -1) {
				if (x) x[currentFocus].click();
			}
		}
	});
	function addActive(x) {
		if (!x) return false;
		removeActive(x);
		if (currentFocus >= x.length) currentFocus = 0;
		if (currentFocus < 0) currentFocus = (x.length - 1);
		x[currentFocus].classList.add("autocomplete-active");
	}

	function removeActive(x) {
		for (var i = 0; i < x.length; i++) {
			x[i].classList.remove("autocomplete-active");
		}
	}
	function closeAllLists(elmnt) {
		var x = document.getElementsByClassName("autocomplete-items");
		for (var i = 0; i < x.length; i++) {
			if (elmnt != x[i] && elmnt != inp) {
				x[i].parentNode.removeChild(x[i]);
			}
		}
		let fixedCard = document.getElementById("auto_search");
		fixedCard.style="width:20vw; z-index:999; visibility:hidden;"

	}
}