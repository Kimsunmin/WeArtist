# WeArtist 팀프로젝트
***
>가상의 전시관에 전시를 할 수 있는 사이트

+ 팀원 (맡은 기능)
  + 김선민(본인)
    + Gallery Page, Live Page, Upload Page
  + 김종환
    + Join Page, Profile Page
  + 장영우
    + DirectMessage, Chat, Main Page, MyPage
  + 김지연
    + Login Page, Index Page

### Index Page Screenshot
![WeArtist_index](https://user-images.githubusercontent.com/19908489/116662870-4c66da00-a9d1-11eb-8ff3-a8bbcc1f79ee.jpg)


## Gallery Page 소개 
***
회원이 업로드한 작품을 가상의 전시관에 전시하는 페이지

## 구현기능
***
>전시관 불러오기
```JavaScript
let target;
  const gltfLoader = new GLTFLoader();
  const url = '/resources/landscape_gallery_by_stoneysteiner/scene.gltf';
  //gltfLoader.load() 이용하여 Gallery gltf파일을 불러온다.
  gltfLoader.load(url, (gltf) => {
    const root = gltf.scene;
    scene.add(root); // 불러온 gltf파일을 Scene에 추가한다.
    
    target = root.getObjectByName('Cube003'); // 3D오브젝트 객체에서 필요한 오브젝트를 불러온다.
    // 불러온 오브젝트를 돌며 회원이 업로드한 작품을 올린다.
    for(let item of target.children){
      item.material.map = textureLoader.load(imgData[item.name]);
      targetList.push(item);
    }
  
    root.add(camera);
    
});
```

## 어려려웠던 점
***
이미 만들어져 있던 GLTF파일에서 필요한 3D객체를 찾아 이미지를 교체하는 과정


![WeArtist_Gallery](https://user-images.githubusercontent.com/19908489/116664644-b7191500-a9d3-11eb-8a2c-ed1e0a180e0d.jpg)

