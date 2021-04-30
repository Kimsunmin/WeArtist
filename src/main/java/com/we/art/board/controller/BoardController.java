package com.we.art.board.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.we.art.board.model.service.BoardService;
import com.we.art.board.model.vo.Board;
import com.we.art.common.code.NotificationCode;
import com.we.art.common.util.file.FileVo;
import com.we.art.communication.model.service.CommunicationService;
import com.we.art.communication.model.vo.History;
import com.we.art.communication.model.vo.Like;
import com.we.art.communication.model.vo.LikeHistory;
import com.we.art.user.model.vo.User;

@Controller
@SessionAttributes("userInfo")
public class BoardController {

	private final BoardService boardService;
	private final CommunicationService communicationService; 
	public BoardController(BoardService boardService,CommunicationService communicationService) {
		this.boardService = boardService;
		this.communicationService = communicationService;
	}
	
	@PostMapping("/sibal")
	public String uploadBorad(@RequestParam List<MultipartFile> files, Board board,
			Model model) {
		User user = (User)model.getAttribute("userInfo");
		// board객체에 업로드한 회원의 아이디를 넣는다.
//		String userId = "test01";
		String userId = user.getUserId();
		
		board.setUserId(userId);
		
		boardService.insertBoard(board, files);
		return "redirect:fileupload2";
	}
    
	@GetMapping("fileupload")
	public String test() {
		return "personal/fileupload";
	}
	
	@GetMapping("fileupload2")
	public String test2() {
		return "personal/fileupload2";
	}
	
	@GetMapping("fetchselectedboard")
	@ResponseBody
	public Map<String,Object> fetchSelectedBoard(@RequestParam("bdNo") String bdNo) {
		Map<String,Object> commandMap = new HashMap<String,Object>();
		commandMap = boardService.selectBoardByBdNo(bdNo);
		return commandMap;
	}
	
	
	@GetMapping("fetchlikeuserlist")
	@ResponseBody
	public List<Map<String,String>> fetchlikeuserlist(@RequestParam("bdNo") String bdNo){
		List<Map<String,String>> likeUserList = boardService.selectLikeListByBdNo(bdNo);
		System.out.println(likeUserList);
		if(likeUserList==null) {
			likeUserList = new ArrayList<>();
		}
		
		return likeUserList;
	}
	
	
	@GetMapping("certificatelike")
	@ResponseBody
	public String certificateLike(@RequestParam("bdNo") String bdNo, @RequestParam("lkId") String lkId) {
		Map<String,String> like = boardService.certificateLike(bdNo, lkId);
		//좋아요을 한 적이 없다면 테이블을 조회한 값이 null이다.
		if(like==null) {
			System.out.println("좋아요 한 적 없음");
			return "ok"; //좋아요를 할 수있음
		}else {
			System.out.println("좋아요 한 적있음");
			return "no"; //좋아요를 취소할 수 있음.
		}
	}
	
	@PostMapping("insertlike")
	@ResponseBody
	public String insertLike(@RequestBody Map<String,String> mapData,Model model) {
		User userInfo = (User)model.getAttribute("userInfo");
		System.out.println("MapData : "+ mapData);
		if(userInfo!=null) {
			int res = boardService.insertLike(mapData.get("bdNo"), userInfo.getUserId());
			if(res!=0) {
				System.out.println("getUserId : "+ userInfo.getUserId());
				System.out.println("toId : "+mapData.get("toId") );
				if(!userInfo.getUserId().equals(mapData.get("toId"))) { //좋아요를 누른 게시물이 본인의 것이 아닐 때만 좋아요 히스토리 테이블에 담는다.
					History history = new History();
					history.setFromId(userInfo.getUserId());
					history.setToId(mapData.get("toId"));
					history.setNotiMethod(NotificationCode.LIKE.toString());
					history.setBdNo(mapData.get("bdNo"));
					
					List<Map<String,String>> checkDataList = new ArrayList<>();
					checkDataList = communicationService.certificateHistory(history);
					System.out.println("체크리스트 : "+checkDataList);
					if(checkDataList.size()==0) {
						history = new History();
						history.setFromId(userInfo.getUserId());
						history.setToId(mapData.get("toId"));
						history.setNotiMethod(NotificationCode.LIKE.toString());
						Calendar cal = Calendar.getInstance();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String notiTime = sdf.format(cal.getTime());
						history.setNotiTime(notiTime);
						history.setBdNo(mapData.get("bdNo"));
						history.setBdTitle(mapData.get("bdTitle"));
						if (communicationService.insertHistory(history) != 0) {
							return "sendNoti";
						} else {
							return "failed";
						}
					}else {
						return "notSendNoti";
					}
				}else {
					return "notSendNoti";
				}
			}else {
				return "failed";
			}
		}else {
			//로그인을 안한 상태에서 좋아요를 누르려고 할 시
			return "failed";
		}

	}
	
	
	@GetMapping("deletelike")
	@ResponseBody
	public String deleteLike(@RequestParam("bdNo") String bdNo, @RequestParam("lkId") String lkId) {
		int res = boardService.deleteLike(bdNo, lkId);
		if(res!=0) {
			return "success";
		}else {
			return "failed";
		}
	}
	
	@GetMapping("selectlikecount")
	@ResponseBody
	public int selectLikeCount(@RequestParam("bdNo") String bdNo) {
		int likeCount = boardService.selectLikeCount(bdNo);
		System.out.println("좋아요 갯수 : "+ likeCount);
		return likeCount;
	}
	
	@PostMapping("deleteboardimpl")
	@ResponseBody
	public String deleteBoardById(@RequestBody Map<String,String> param) {
		int res = boardService.deleteBoardById(param.get("bdNo"));
		if(res!=0) {
			return "success";
		}else {
			return "failed";
		}
	}
	
	
	
	
	
	
}
