package com.we.art.communication.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.we.art.communication.model.vo.Following;
import com.we.art.communication.model.vo.History;
import com.we.art.user.model.vo.User;

public interface CommunicationService {

	public List<User> selectAllUser();

	public int insertHistory(History history);

	public int insertFollowing(Following following);

	public int deleteFollowing(Following following);

	public List<Map<String, Object>> selectHistoryById(String userId);

	public int updateHistory(History history);
	
	public List<Map<String,String>> certificateHistory(History history);
	
	public int insertMessageHistory(String userId);
	
	public Map<String,String> selectMessageHistory(String userId);
}

