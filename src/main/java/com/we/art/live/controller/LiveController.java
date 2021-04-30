package com.we.art.live.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.we.art.common.util.socket.SocketHandler;
import com.we.art.user.model.vo.User;

@Controller
@RequestMapping("/live")
public class LiveController {
	
	@Autowired
	SocketHandler sh;
	
	@GetMapping("/host")
	public String live(@SessionAttribute(name="userInfo", required = false)User user,Model model) {
		String userId = user.getUserId();
		model.addAttribute("liveHostUserId", userId);
		return "live/live";
	}
	
	@GetMapping("/guest")
	public String showlive() {
		System.out.println(sh.getUserList());
		return "live/showLive";
	}
	
}
