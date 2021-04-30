package com.we.art.personal.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.we.art.board.model.service.BoardService;
import com.we.art.common.util.file.FileVo;
import com.we.art.communication.model.vo.Following;
import com.we.art.personal.model.service.PersonalService;
import com.we.art.user.model.vo.User;

@Controller
@RequestMapping("personal")
@SessionAttributes("userInfo")
public class PersonalController {

	
	private final PersonalService personalService;
	private final BoardService boardService;
	
	public PersonalController(PersonalService personalService,BoardService boardService) {
		this.personalService = personalService;
		this.boardService = boardService;
		
	}

	@GetMapping("personal")
	public String personalPage(@RequestParam("nickName") String nickName,Model model) {
		User userInfo = (User) model.getAttribute("userInfo");
		System.out.println(userInfo);
		User user = new User();
		user.setNickName(nickName);
		Map<String,String> personalUserInfo = personalService.selectUserByNickName(user);
		String pageState = null; 
		
		//이 유저의 팔로워 수, 팔로잉 한 수를 구한다.
		int followingCount = personalService.selectFollowingCount(personalUserInfo.get("userId"));
		int followerCount = personalService.selectFollowerCount(personalUserInfo.get("userId"));
	
		
		if(userInfo==null) {
			pageState="notLogin";
			
		}else {
			//만약 로그인한 유저가 본인의 개인 상세 페이지를 들어왔다면
			if(userInfo.getNickName().equals(nickName)) {
				//프로필 설정 버튼 on, 팔로잉 버튼 off 해야한다.
				System.out.println("isMine");
				pageState = "isMine";
				//만약 내가 이사람을 팔로잉 한 상태라면
			}else if(personalService.selectUserIsFollowing(new Following(userInfo.getUserId(),personalUserInfo.get("userId")))!=null) {
				//팔로잉 버튼을 언팔로우 버튼으로 바꿔야한다.
				System.out.println("isFollowed");
				pageState = "isFollowed";
			}else {
				System.out.println("nothing");
				pageState = "nothing";
			}
		}
		
		List<Map<String,Object>> boardInfo = boardService.selectBoardByUserId(personalUserInfo.get("userId"));
		if(boardInfo!=null) {
			for(int i = 0; i< boardInfo.size(); i++) {
				System.out.println("게시물정보 :"+boardInfo.get(i).get("board"));		
				System.out.println("파일들 정보 :"+boardInfo.get(i).get("files"));		
			}
		}else {
			boardInfo = new ArrayList<>();
		}
		model.addAttribute("curUserInfo",userInfo);
		model.addAttribute("followingCount",followingCount);
		model.addAttribute("followerCount",followerCount);
		model.addAttribute("pageState",pageState);
		model.addAttribute("personalBoardInfoList",boardInfo);
		model.addAttribute("personalUserInfo",personalUserInfo);
		return "personal/personal_page";
	}

	@GetMapping("resetfollowingcountimpl")
	@ResponseBody
	public int reSetFollowingCountimpl(@RequestParam("nickName") String nickName){
		User user = new User();
		user.setNickName(nickName);
		Map<String,String> personalUserInfo = personalService.selectUserByNickName(user);
		return personalService.selectFollowerCount(personalUserInfo.get("userId"));
	}
	
	@GetMapping("resetfollowercountimpl")
	@ResponseBody
	public int reSetFollowerCountimpl(@RequestParam("nickName") String nickName){
		User user = new User();
		user.setNickName(nickName);
		Map<String,String> personalUserInfo = personalService.selectUserByNickName(user);
		return personalService.selectFollowingCount(personalUserInfo.get("userId"));
	}
	
	
	
	@GetMapping("personalprivate")
	public String personalPrivatePage() {
		return "personal/personal_private_page";
	}
	
	@GetMapping("fetchfollowinglist")
	@ResponseBody
	public List<User> fetchFollowingList(@RequestParam("userId") String userId){
		List<User> followingList = new ArrayList<>();
		System.out.println("받은 유저아이디 : "+ userId);
		followingList = personalService.selectFollowingList(userId);
		System.out.println("팔로잉리스트 : "+ followingList);
		return followingList;
	}
	
	
	@GetMapping("fetchfollowerlist")
	@ResponseBody
	public List<User> fetchFollowerList(@RequestParam("userId") String userId){
		List<User> followerList = new ArrayList<>();
		followerList = personalService.selectFollowerList(userId);
		System.out.println(followerList);
		return followerList;
	}
}