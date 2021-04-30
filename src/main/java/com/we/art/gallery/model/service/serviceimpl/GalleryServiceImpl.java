package com.we.art.gallery.model.service.serviceimpl;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.we.art.gallery.model.repository.GalleryRepository;
import com.we.art.gallery.model.service.GalleryService;
import com.we.art.gallery.model.vo.Gallery;

@Service
public class GalleryServiceImpl implements GalleryService{
	
	private final GalleryRepository galleryRepository;
	
	public GalleryServiceImpl(GalleryRepository galleryRepository) {
		
		this.galleryRepository = galleryRepository;
	}
	
	@Override
	public int insertAllGalleryInfo(List<Gallery> galleryList, String userId) {
		int res = 0;
		List<Gallery> dataList = galleryRepository.selectGalleryInfoByUserId(userId);
		List<String> orderList = new ArrayList<String>();
		List<Gallery> updateList = new ArrayList<Gallery>();
		List<Gallery> insertList = new ArrayList<Gallery>();
		List<Gallery> deleteList = new ArrayList<Gallery>();
		
		for(Gallery item : dataList) {
			orderList.add(item.getImgOrder());
		}
		
		for(Gallery data : galleryList) {
			if(orderList.contains(data.getImgOrder())) {
				if(data.getPath().contains("defaultImg")) {
					deleteList.add(data);
				}else {
					updateList.add(data);
				}
			}else {
				insertList.add(data);
			}
		}
		
		if(dataList.isEmpty()) {
			res += galleryRepository.insertAllGalleryInfo(galleryList);
		}else {
			if(!insertList.isEmpty()) {
				res += galleryRepository.insertAllGalleryInfo(insertList);
			}
			
			if(!updateList.isEmpty()) {
				res += galleryRepository.updateAllGalleryInfo(updateList);
			}
			
			if(!deleteList.isEmpty()) {
				res += galleryRepository.deleteAllGalleryInfo(deleteList);
			}
		}
		
		return res;
	}

	@Override
	public int updateGalleryInfo(List<MultipartFile> files, String userId) {
		
		return 0;
	}

	@Override
	public List<Gallery> selectGalleryInfoByUserId(String userId) {
		List<Gallery> dataList = galleryRepository.selectGalleryInfoByUserId(userId);
		List<Gallery> commandList = new ArrayList<Gallery>();
		
		for(int i=0; i<12; i++) {
			commandList.add(null);
		}
		
		for(Gallery item : dataList) {
			int idx = Integer.parseInt(item.getImgOrder())-1;
			commandList.set(idx, item);
		}
		
		return commandList;
	}

	@Override
	public String selectGalleryInforByImgOrder(String imgOrder, String userId) {
		// TODO Auto-generated method stub
		return galleryRepository.selectGalleryInforByImgOrder(imgOrder, userId);
	}

	@Override
	public List<Map<String, Object>> selectGalleryByUserId(String userId) {
		List<Gallery> dataList = galleryRepository.selectGalleryInfoByUserId(userId);
		List<Map<String, Object>> commanList = new ArrayList<Map<String,Object>>();
		
		for(Gallery item : dataList) {
			Map<String, Object> commanMap = new HashMap<String, Object>();
			commanMap.put("imgOrder", item.getImgOrder());
			commanMap.put("title", galleryRepository.selectTitleByBdNO(item.getBdNo()));
			commanMap.put("content", galleryRepository.selectContentByBdNO(item.getBdNo()));
			commanMap.put("path",item.getPath());
			commanList.add(commanMap);
		}
		
		
		return commanList;
	}

	@Override
	public List<Map<String, Object>> selectGalleryByRandom() {
		List<Map<String, Object>> commanList = new ArrayList<Map<String,Object>>();
		Set<Integer> randomSet = new HashSet<Integer>();
		
		while(randomSet.size() < 12) {
			randomSet.add(new Random().nextInt(galleryRepository.selectGalleryAllCount()-1)+1);
			System.out.println(randomSet);
		}
		
		List<Integer> list = new ArrayList<Integer>(randomSet);
		List<Map<String, Object>> tempList = new ArrayList<Map<String,Object>>();
		tempList = galleryRepository.selectGalleryByRandom(list);
		System.out.println("first : " + tempList);
		
		for(Map<String, Object> item : tempList) {
			Map<String, Object> commanMap = new HashMap<String, Object>();
			commanMap.put("imgOrder", commanList.size()+1);
			commanMap.put("title", item.get("bdTitle"));
			commanMap.put("content", item.get("bdContent"));
			commanMap.put("path", "/images/"
								  + item.get("fSavePath")
								  + item.get("fRename"));
			System.out.println("Map : " + commanMap);
			commanList.add(commanMap);
		}
		
		System.out.println(commanList);
		return commanList;
	}
	
}
