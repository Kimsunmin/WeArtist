package com.we.art.gallery.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.we.art.board.model.service.BoardService;
import com.we.art.common.code.ConfigCode;
import com.we.art.common.code.ErrorCode;
import com.we.art.common.exception.ToAlertException;
import com.we.art.gallery.model.service.GalleryService;
import com.we.art.gallery.model.vo.Gallery;
import com.we.art.user.model.vo.User;

@Controller
@SessionAttributes("userInfo")
public class GalleryController {
	
	private final BoardService boardService;
	private final GalleryService galleryService;
	
	public GalleryController(BoardService boardService,GalleryService galleryService) {
		this.boardService = boardService;
		this.galleryService = galleryService;
	}
	
	@GetMapping("gallery/{userId}")
	public String ShowGallery(@PathVariable(name = "userId")String userId,
							  @SessionAttribute(name="userInfo", required = false)User user,
							  Model model) {
		List<Map<String, Object>> galleryList = new ArrayList<Map<String,Object>>();
		
		// 탑바에서 접속시 사용
		if(userId.equals("main")) {
			galleryList = galleryService.selectGalleryByRandom();	
		}else if(!userId.equals(user == null ? "" : user.getUserId())
				&& galleryService.selectGalleryByUserId(userId).isEmpty()) {
			throw new ToAlertException(ErrorCode.GALLERYISNULL);
		}else {
			galleryList = galleryService.selectGalleryByUserId(userId);
		}
		
		
		model.addAttribute("galleryList",galleryList);
		model.addAttribute("galleryUserId", userId);
		return "gallery/gallery";
	}
	
	@GetMapping("galleryinfo")
	public String setGallery(@SessionAttribute(name="userInfo", required = false)User user,Model model) {
		String userId = user.getUserId();
		
		model.addAttribute("userGalleryData", galleryService.selectGalleryInfoByUserId(userId));
		model.addAttribute("userBoardData", boardService.selectBoardByUserId(userId));
		return "gallery/galleryinfo";
	}
	
	// 갤러리에 필요한 이미지정보를 받아온다
	@PostMapping("galleryupload")
	public String uploadGallery(@RequestBody List<Gallery> gallerList) {		
		System.out.println("controller : " + gallerList);
		String userId = gallerList.get(0).getUserId();
		
		galleryService.insertAllGalleryInfo(gallerList, userId);
		
		return "gallery/gallery";
	}
	
	@GetMapping("headtest")
	public String headtest() {
		return "gallery/headTest";
	}
	
	@GetMapping("load/{urlPath}")
	public String loadImage(@PathVariable("urlPath")String imgOrder) {
		
		String userId = "test01";
		
		return galleryService.selectGalleryInforByImgOrder(imgOrder, userId);
	}
}

















