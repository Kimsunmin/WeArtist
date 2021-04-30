package com.we.art.search.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.we.art.common.util.file.FileVo;
import com.we.art.search.model.service.SearchService;
import com.we.art.user.model.vo.User;

@Controller
@RequestMapping("search")
@SessionAttributes("userInfo")
public class SearchController {
	
	
	private final SearchService searchService;
	
	
	public SearchController(SearchService searchService) {
		this.searchService = searchService;
	}


	@GetMapping("main")
	public String searchMain(Model model) {
		User userInfo = (User)model.getAttribute("userInfo");
		List<Map<String,Object>> imageList = searchService.selectAllImageFile();
		System.out.println("이미지 리스트 : "+imageList);
		if(imageList.size()==0) {
			imageList = new ArrayList<Map<String,Object>>();
		}
		model.addAttribute("imageList",imageList);
		return "search/search_sub";
	}
	
	
	@GetMapping("tag")
	@ResponseBody
	public List<Map<String,Object>> searchByTag(@RequestParam("tag") String tag, Model model) {
		System.out.println("검색할 태그 : "+ tag);
		List<Map<String, Object>> searchResultList = searchService.selectBoardByTag("#"+tag);
		if(searchResultList.size()==0) {
			searchResultList = new ArrayList<>();
		}
		System.out.println("검색 결과 : "+searchResultList);
		return searchResultList;
	}
	
	@GetMapping("bdTitle")
	@ResponseBody
	public List<Map<String,Object>> searchByTitle(@RequestParam("bdTitle") String bdTitle, Model model){
		List<Map<String,Object>> searchResultList = searchService.selectBoardByTitle(bdTitle);
		if(searchResultList.size()==0) {
			searchResultList = new ArrayList<>();
		}
		System.out.println("검색 결과 : "+ searchResultList);
		return searchResultList;
	}
	
	@GetMapping("bdContent")
	@ResponseBody
	public List<Map<String,Object>> searchByContent(@RequestParam("bdContent") String bdContent, Model model){
		List<Map<String,Object>> searchResultList = searchService.selectBoardByContent(bdContent);
		if(searchResultList.size()==0) {
			searchResultList = new ArrayList<>();
		}
		System.out.println("검색 결과 : "+ searchResultList);
		return searchResultList;
	}
	
	@GetMapping("name")
	@ResponseBody
	public List<Map<String,Object>> searchByName(@RequestParam("name") String name, Model model){
		List<Map<String,Object>> searchResultList = searchService.selectBoardByName(name);
		if(searchResultList.size()==0) {
			searchResultList = new ArrayList<>();
		}
		System.out.println("검색 결과 : "+ searchResultList);
		return searchResultList;
	}	
	
	@GetMapping("all")
	@ResponseBody
	public List<Map<String,Object>> searchAll(Model model){
		System.out.println("보드올실행");
		List<Map<String,Object>> searchResultList = searchService.selectAllImageFile();
		if(searchResultList.size()==0) {
			searchResultList = new ArrayList<>();
		}
		System.out.println("검색 결과 : "+ searchResultList);
		return searchResultList;
	}	
	
	@GetMapping("selectuserprofileimpl")
	@ResponseBody
	public Map<String,String> selectUserProfileImpl(@RequestParam("nickName")String nickName){
		Map<String,String> userProfile = searchService.selectUserProfile(nickName);
		return userProfile;
		
	}
	
	
	
	
	
	
	
	
	
}
