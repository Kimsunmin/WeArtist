import { GLTFLoader } from '/resources/js/gallery/GLTFLoader.js';

let scene, camera, renderer;
let container = document.querySelector('.middle');

let init = () => {
	scene = new THREE.Scene();

	const CLIENT_WIDTH = container.clientWidth
	const CLIENT_HEIGHT = container.clientHeight;
	const VIEW_ANGLE = 45;
	const ASPECT = CLIENT_WIDTH / CLIENT_HEIGHT;
	const NEAR = 0.1;
	const FAR = 20000;

	camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR);

	renderer = new THREE.WebGLRenderer();
	renderer.setSize(CLIENT_WIDTH, CLIENT_HEIGHT);
	container.appendChild(renderer.domElement);

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

	const gltfLoader = new GLTFLoader();
	const url = '/resources/landscape_gallery_by_stoneysteiner/scene.gltf';
	gltfLoader.load(url, (gltf) => {
		const root = gltf.scene;
		scene.add(root);
		root.add(rightLight);
		root.add(leftLight);
		root.add(frontLight);
		root.add(backLight);
		root.add(camera);
	});
	window.addEventListener('resize', onWindowResize);
}

let onWindowResize = () => {
	camera.aspect = window.innerWidth / window.innerHeight;
	camera.updateProjectionMatrix();
	renderer.setSize(window.innerWidth, window.innerHeight);
}

let animate = () => {
	requestAnimationFrame(animate);
	render();
}

let render = () => {
	camera.rotation.y += 0.001;
	renderer.render(scene, camera);
}

init();
animate();