package com.we.art.communication.model.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.we.art.communication.model.repository.CommunicationRepository;
import com.we.art.communication.model.service.CommunicationService;
import com.we.art.communication.model.vo.Following;
import com.we.art.communication.model.vo.History;
import com.we.art.user.model.vo.User;
@Service
public class CommunicationServiceImpl implements CommunicationService{

	private final CommunicationRepository communicationRepository;
	
	
	public CommunicationServiceImpl(CommunicationRepository communicationRepository) {
		this.communicationRepository = communicationRepository;
	}


	@Override
	public List<User> selectAllUser() {
		return communicationRepository.selectAllUser();
	}


	@Override
	public int insertHistory(History history) {
		return communicationRepository.insertHistory(history);
	}


	@Override
	public int insertFollowing(Following following) {
		return communicationRepository.insertFollowing(following);
	}

	@Override
	public int deleteFollowing(Following following) {
		return communicationRepository.deleteFollowing(following);
	}


	@Override
	public List<Map<String, Object>> selectHistoryById(String userId) {
		return communicationRepository.selectHistoryById(userId);
	}


	@Override
	public int updateHistory(History history) {
		return communicationRepository.updateHistory(history);
	}


	@Override
	public List<Map<String, String>> certificateHistory(History history) {
		return communicationRepository.certificateHistory(history);
	}


	@Override
	public int insertMessageHistory(String userId) {
		return communicationRepository.insertMessageHistory(userId);
	}


	@Override
	public Map<String, String> selectMessageHistory(String userId) {
		return communicationRepository.selectMessageHistory(userId);
	}
	
}
