import {GLTFLoader} from '/resources/js/gallery/GLTFLoader.js';

// 기본사용한는 전역변수
let scene, camera, renderer, controls,textureLoader;
let container = document.querySelector('.middle');

let targetList = []; // 클릭할 객체 -> 액자안에 그림 배열
let galleryData = new Object();
let imgData = new Object();
let mouse = { x:0, y:0}; // 마우스 클릭시 x,y축을 저장

let isGalleryNull = () => {
	initGallery();
	if(Object.keys(imgData).length > 0){
		init();
		animate();
	}else{
		document.querySelector('#divUpload').className = 'card position-absolute';
	}
}

let initGallery = () => {
	let list = document.querySelector('#userGalleryList');
	for(let item of list.children){
		let temp = new Object();
		temp.title = item.dataset.title;
		temp.content = item.dataset.content;
		temp.path = item.dataset.path;
		galleryData[item.id] = temp;
		imgData[item.id] = item.dataset.path;  
	}
}

let init = () => {
	initGallery();
    scene = new THREE.Scene();

    // 기본 세팅
    const CLIENT_WIDTH = container.clientWidth
    const CLIENT_HEIGHT = container.clientHeight;
    const VIEW_ANGLE = 45;
    const ASPECT = CLIENT_WIDTH / CLIENT_HEIGHT;
    const NEAR = 0.1;
    const FAR = 20000;

    camera = new THREE.PerspectiveCamera( VIEW_ANGLE, ASPECT, NEAR, FAR);
    camera.position.z = 2;
	console.dir(camera);

    // middle에 랜더한다
    renderer = new THREE.WebGLRenderer();
    renderer.setSize(CLIENT_WIDTH,CLIENT_HEIGHT);
    container.appendChild(renderer.domElement);

    controls = new THREE.OrbitControls(camera, renderer.domElement);
    // 위,아래로 시점 변경불가능 설정
    controls.maxPolarAngle = controls.getPolarAngle();
    controls.minPolarAngle = controls.getPolarAngle();

    //줌속도 , 회전 속도 설정
    controls.panSpeed = 0.5;
    controls.rotateSpeed = 0.2;
    controls.update();

    const color = 'white';
    const intensity = 0.9;
    const ypos = 0.1;

    const leftLight = new THREE.DirectionalLight(color, intensity);
    leftLight.position.set(5, ypos, 0);

    const rightLight = new THREE.DirectionalLight(color, intensity);
    rightLight.position.set(-5, ypos, 0);

    const frontLight = new THREE.DirectionalLight(color, intensity);
    frontLight.position.set(0, ypos, 5);

    const backLight = new THREE.DirectionalLight(color, intensity);
    backLight.position.set(0, ypos, -5);
	
	textureLoader = new THREE.TextureLoader();
	

    let target;
    const gltfLoader = new GLTFLoader();
    const url = '/resources/landscape_gallery_by_stoneysteiner/scene.gltf';
    gltfLoader.load(url, (gltf) => {
       	const root = gltf.scene;
        scene.add(root);

        // 오브젝트 객체의 정보를 출력해준다
        console.dir(root.getObjectByName('Cube003'));

        // Cube003의 children은 액자인지 그림만인지... 하튼 객체 찾아냄
        target = root.getObjectByName('Cube003');
        for(let item of target.children){
			item.material.map = textureLoader.load(imgData[item.name]);
            targetList.push(item);
        }
        // 상하좌우 조명설치
        root.add(rightLight);
	    root.add(leftLight);
	    root.add(frontLight);
	    root.add(backLight);
        root.add(camera);
    });

    document.addEventListener('click', onDocumentMouseDown);
	window.addEventListener('resize',onWindowResize);

}

let onDocumentMouseDown = (event) => {
    mouse.x = (event.clientX / window.innerWidth) * 2 - 1;
    mouse.y = - ( event.clientY / window.innerHeight ) * 2 + 1;
    console.log('Click.' + mouse.x + ' : ' + mouse.y);

    let ray = new THREE.Raycaster();
    ray.setFromCamera( mouse, camera );
    let intersects = ray.intersectObjects( targetList);
    console.dir(intersects);
    if(intersects.length > 0){       
        targetList.forEach((e) => {
            // 클릭했을때 눌린 객체가 그림인지 아닌지 확인하는 조건문
            if(e.name === intersects[0].object.name && galleryData[e.name]){
				clickObject(e.name);
            }
        })
    }
}

let clickObject = (objName) => {
	document.querySelector('#imgInfo').src = galleryData[objName].path;	
	document.querySelector('#imgTitle').innerText = galleryData[objName].title;	
	//document.querySelector('#imgContent').innerText = galleryData[objName].content;	
	document.querySelector("#divTest").className = 'card position-absolute';
	document.removeEventListener('click',onDocumentMouseDown);
	document.querySelector('#btn_back').addEventListener('click',back);
}

// 상세페이지 닫을시 다음 요소들을 초기화 해준다.
let back = () => {
	document.querySelector('#imgInfo').src = '';
	document.querySelector('#divTest').className = 'd-none';
	document.addEventListener('click', onDocumentMouseDown);
}

// 화면 사이즈에 맞춰서 다시 랜더링 해준다
let onWindowResize = () => {
	camera.aspect = window.innerWidth / window.innerHeight;
	camera.updateProjectionMatrix();
	renderer.setSize(window.innerWidth, window.innerHeight);
}

let animate = () =>{
    requestAnimationFrame(animate);
    render();
}

let render = () => {	
    renderer.render(scene,camera);
}

isGalleryNull();
//init();
//animate();