package com.we.art.communication.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

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

import com.we.art.common.code.NotificationCode;
import com.we.art.communication.model.service.CommunicationService;
import com.we.art.communication.model.vo.Following;
import com.we.art.communication.model.vo.History;
import com.we.art.user.model.vo.User;

@Controller
@RequestMapping("communication")
@SessionAttributes("userInfo")
public class CommunicationController {

	private final CommunicationService communicationService;

	public CommunicationController(CommunicationService communicationService) {
		this.communicationService = communicationService;
	}

	@GetMapping("alluser")
	public String allUser(@SessionAttribute("userInfo") User userInfo, Model model) {
		List<User> allUserList = communicationService.selectAllUser();
		model.addAttribute("allUserList", allUserList);
		return "communication/alluser";
	}

	@GetMapping("alluserlist")
	@ResponseBody
	public List<User> fetchAllUserList() {
		List<User> allUserList = communicationService.selectAllUser();
		return allUserList;
	}

	@PostMapping("followingimpl")
	@ResponseBody
	public String followingImpl(@SessionAttribute("userInfo") User userInfo, @RequestBody Following following,
			Model model) {
		int res = communicationService.insertFollowing(following);
		if (res != 0) {
			History history = new History();
			history.setFromId(following.getFromId());
			history.setToId(following.getToId());
			history.setNotiMethod(NotificationCode.FOLLOWING.toString());
			history.setBdNo(null);
			List<Map<String,String>> checkDataList = new ArrayList<>();
			checkDataList = communicationService.certificateHistory(history);
			if(checkDataList.size()==0){
				history = new History();
				history.setFromId(following.getFromId());
				history.setToId(following.getToId());
				history.setNotiMethod(NotificationCode.FOLLOWING.toString());
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String notiTime = sdf.format(cal.getTime());
				history.setNotiTime(notiTime);
				history.setBdNo(null);
				history.setBdTitle(null);
				if (communicationService.insertHistory(history) != 0) {
					return "success";
				} else {
					return "failed";
				}

			}else {
				return "success";
			}
			
		} else {
			return "failed";
		}
	}

	@PostMapping("unfollowingimpl")
	@ResponseBody
	public String unfollowingImpl(@SessionAttribute("userInfo") User userInfo, @RequestBody Following following,
			Model model) {
		int res = communicationService.deleteFollowing(following);
		if (res != 0) {
				return "success";
		} else {
			return "failed";
		}
	}
	
	@GetMapping("fetchnoticountimpl")
	@ResponseBody
	public List<Map<String,Object>> fetchNotiCount(Model model) {
		User userInfo = (User)model.getAttribute("userInfo");
		if(userInfo!=null) {
			List<Map<String,Object>> historyList = communicationService.selectHistoryById(userInfo.getUserId());
			System.out.println(historyList);
			if(historyList.size()==0) {
				historyList = new ArrayList<>();
			}
			System.out.println(historyList);
			return historyList;
		}else {
			return new ArrayList<>();
		}
	}
	
	@PostMapping("updatehistoryimpl")
	@ResponseBody
	public String updateHistoryImpl(@RequestBody History history, Model model) {
		User userInfo = (User)model.getAttribute("userInfo");
		System.out.println("히스토리 : "+ history);
		if(userInfo!=null) {
			int res = communicationService.updateHistory(history);
			if(res!=0) {
				return "success";
			}else {
				return "failed";
			}
		}else {
			return "failed";
		}
	}
	
	@GetMapping("selectmessagehistoryimpl")
	@ResponseBody
	public String insertMessageHistoryImpl(@RequestParam("userId") String userId) {
		Map<String,String> result= communicationService.selectMessageHistory(userId);
		if(result!=null) {
			return "success";
		}else {
			return "failed";
		}
	}
	
	@GetMapping("insertmessagehistoryimpl")
	@ResponseBody
	public String insertMessageNotiImpl(@RequestParam("userId") String userId) {
		int res = communicationService.insertMessageHistory(userId);
		if(res!=0) {
			return "success";
		}else {
			return "failed";
		}
	}
	
	
	
	
	
	
	
	
}
