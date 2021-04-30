package com.we.art.personal.model.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.we.art.communication.model.vo.Following;
import com.we.art.personal.model.repository.PersonalRepository;
import com.we.art.personal.model.service.PersonalService;
import com.we.art.user.model.vo.User;

@Service
public class PersonalServiceImpl implements PersonalService{

	private final PersonalRepository personalRepository;
	
	public PersonalServiceImpl(PersonalRepository personalRepository) {
		this.personalRepository = personalRepository;
	}


	@Override
	public Map<String,String> selectUserByNickName(User user) {
		return personalRepository.selectUserByNickName(user);
	}


	@Override
	public Following selectUserIsFollowing(Following following) {
		return personalRepository.selectUserIsFollowing(following);
	}


	@Override
	public List<User> selectFollowerList(String userId) {
		List<User> followerList = new ArrayList<>();
		followerList = personalRepository.selectFollowerList(userId);
		return followerList.isEmpty() ? null : followerList;
	}


	@Override
	public List<User> selectFollowingList(String userId) {
		List<User> followingList = new ArrayList<>();
		followingList = personalRepository.selectFollowingList(userId);
		return followingList.isEmpty() ? null : followingList;
	}


	@Override
	public int selectFollowerCount(String userId) {
		return personalRepository.selectFollowerCount(userId);
	}


	@Override
	public int selectFollowingCount(String userId) {
		return personalRepository.selectFollowingCount(userId);
	}
	
	

}
