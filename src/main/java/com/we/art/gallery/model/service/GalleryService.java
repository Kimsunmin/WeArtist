package com.we.art.gallery.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.we.art.gallery.model.vo.Gallery;

public interface GalleryService {
	
	public int insertAllGalleryInfo(List<Gallery> gallerList, String userId);
	public int updateGalleryInfo(List<MultipartFile> files, String userId);
	public List<Gallery> selectGalleryInfoByUserId(String userId);
	public String selectGalleryInforByImgOrder(String imgOrder,String userId);
	public List<Map<String, Object>> selectGalleryByUserId(String userId);
	public List<Map<String, Object>> selectGalleryByRandom();
}
