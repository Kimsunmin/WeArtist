class ThreeJSBoot{
	renderer;
	scene;
	camera;
	light;
	controls;
	
	createStage(htmlElement){
		this.scene = new THREE.Scene();
		this.#setRenderal(htmlElement);
		this.#setLight();
		this.#setCamera(htmlElement);
		this.#setControls();
	}
	
	#setRenderal(e){		
		 this.renderer = new THREE.WebGLRenderer();
		 this.renderer.setSize( e.clientWidth, e.clientHeight );
		 e.appendChild( this.renderer.domElement );
	}
	
	#setLight(){	
		 this.light = new THREE.DirectionalLight('white', 1);
		 this.light.position.set(-3, 2, 10);
		 this.scene.add(this.light);
	}
	
	#setCamera(e){
		this.camera 
		= new THREE.PerspectiveCamera( 75, e.clientWidth / e.clientHeight, 0.1, 1000 );
		this.camera.position.z = 10;
	}
	
	#setControls(){
		this.controls = new THREE.OrbitControls(this.camera, this.renderer.domElement);
		this.controls.update();		
	}
	
	createObject(geometry,property,material){
		let mashMaterial = material?material:new THREE.MeshPhongMaterial(property);
		return new THREE.Mesh(geometry,mashMaterial);		
	}
	
	#loadFont(url){
		return new Promise((resolve,reject) => {
			new THREE.FontLoader().load(url,resolve);
		})
	}
	
	createText(url,text,color,size,height,material){
		//async함수는 return값이 있을 경우 return값을 resolve 하는 promise를 반환한다.
		//클래스의 메서드안 의 함수안에서 선언된 this == undefined 
		//클래스는 기본적으로 strict모드이기 때문에
		//화살표 함수 안에서 선언된 this == 화살표 함수의 스코프에 있는 this값을 따라간다.
		let asyncFont = async () => {
			let font = await this.#loadFont(url);
			const fontGeo = new THREE.TextGeometry(text, {
					font: font,
					size: size?size:1,
					height: height?height:0.3,
					curveSegments: 12		
			});
			
			const meshMaterial = material?material:new THREE.MeshPhongMaterial({color:color});	
			const objText = new THREE.Mesh(fontGeo,meshMaterial);
			return objText; 
		}
		
		return asyncFont();
	}
	
	createObjectFromObj(objUrl,mtlUrl){
		let asyncObj = async () =>{
			let mtl = await this.#loadMtl(mtlUrl);
			let obj = await this.#loadObj(objUrl,mtl);
			this.scene.add(obj);
			return obj;
		}
		
		return asyncObj();
	}
	
	#loadMtl(url){
		return new Promise((resolve,reject)=>{
			new THREE.MTLLoader().load(url,resolve);
		});	
	}
	
	#loadObj(url,mtl){
		mtl.preload();
		const objLoader = new THREE.OBJLoader();
		objLoader.setMaterials(mtl);
		return new Promise((resolve,reject)=>{
			objLoader.load(url,resolve);
		});	
	}
	
	
	
	
	
	
	
	
	
	
	
}