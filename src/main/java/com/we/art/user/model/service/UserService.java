package com.we.art.user.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.we.art.user.model.vo.User;

public interface UserService {
	
	User selectUserById(String userId);
	User selectUserByNick(String nickName);
	int selectUserByEmail(String email);

	int insertUser(User persitInfo);
	void authenticateEmail(User persistInfo, String authPath);
	User selectUserForLogin(User user);

	int updateUser(User persistInfo);
	
	void insertProPic(String userId, List<MultipartFile> files);
	Map<String,Object> selectProPicByFIdx(String fIdx);
	int updateProPic(String userId);

	//김지연 비밀번호 찾기 시작

	String findPassword(String email);
	User checkUserForLogin(String userId, String password);
	
	//끝
	

}





