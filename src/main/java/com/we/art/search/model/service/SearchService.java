package com.we.art.search.model.service;

import java.util.List;
import java.util.Map;

public interface SearchService {

	public List<Map<String,Object>> selectBoardByTag(String tag);
	
	public List<Map<String,Object>> selectAllImageFile();
	
	public List<Map<String,Object>> selectBoardByTitle(String bdTitle);
	
	public List<Map<String,Object>> selectBoardByContent(String bdContent);
	
	public List<Map<String,Object>> selectBoardByName(String name);
	
	public Map<String,String> selectUserProfile(String nickName);
}
