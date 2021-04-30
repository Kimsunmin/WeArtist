package com.we.art.search.model.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.we.art.common.util.file.FileVo;
import com.we.art.search.model.repository.SearchRepository;
import com.we.art.search.model.service.SearchService;

@Service
public class SearchServiceImpl implements SearchService{

	private final SearchRepository searchRepository;
	
	public SearchServiceImpl(SearchRepository searchRepository) {
		this.searchRepository = searchRepository;
	}

	@Override
	public List<Map<String, Object>> selectBoardByTag(String tag) {
		return searchRepository.selectBoardByTag(tag);
	}

	@Override
	public List<Map<String,Object>> selectAllImageFile() {
		return searchRepository.selectAllImageFile();
	}

	@Override
	public List<Map<String, Object>> selectBoardByTitle(String bdTitle) {
		return searchRepository.selectBoardByTitle(bdTitle);
	}

	@Override
	public List<Map<String, Object>> selectBoardByContent(String bdContent) {
		return searchRepository.selectBoardByContent(bdContent);
	}

	@Override
	public List<Map<String, Object>> selectBoardByName(String name) {
		return searchRepository.selectBoardByName(name);
	}

	@Override
	public Map<String, String> selectUserProfile(String nickName) {
		return searchRepository.selectUserProfile(nickName);
	}
	
	

}
