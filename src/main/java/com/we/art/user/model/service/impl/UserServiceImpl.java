package com.we.art.user.model.service.impl;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.we.art.common.code.ConfigCode;
import com.we.art.common.code.ErrorCode;
import com.we.art.common.exception.ToAlertException;
import com.we.art.common.mail.MailSender;
import com.we.art.common.util.file.FileUtil;
import com.we.art.common.util.file.FileVo;
import com.we.art.user.model.repository.UserRepository;
import com.we.art.user.model.service.UserService;
import com.we.art.user.model.vo.User;

@Service
public class UserServiceImpl implements UserService {
	
	private final UserRepository userRepository;
	
	@Autowired
	private MailSender mail;
	
	@Autowired
	private RestTemplate http;
	
	@Autowired
	private PasswordEncoder encoder;
	
	public UserServiceImpl(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@Override
	public int insertUser(User persistInfo) {
		persistInfo.setPassword(encoder.encode(persistInfo.getPassword())); 
		return userRepository.insertUser(persistInfo);
	}

	@Override
	public User selectUserById(String userId) {
		return userRepository.selectUserById(userId);
	}
	
	@Override
	public User selectUserByNick(String nickName) {
		return userRepository.selectUserByNick(nickName);
	}


	
	@Override
	public void authenticateEmail(User persistInfo, String authPath) {
		//내부적으로 Map<String,List<k>> 를 구현
	      MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
	      body.add("mail-template", "temp_join");
	      body.add("userId", persistInfo.getUserId());
	      body.add("authPath", authPath);
	      
	      //RestTemplate의 기본 Content-type은 application/json
	      //Content-type을 form-url-encoded로 설정해서 통신해보기
	      RequestEntity<MultiValueMap<String, String>> request = 
	            RequestEntity
	            .post(ConfigCode.DOMAIN+"/mail")
	            .header("content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	            .body(body);
	      
	      ResponseEntity<String> response = http.exchange(request, String.class);
	      mail.send(persistInfo.getEmail(), "회원 가입을 축하드립니다.", response.getBody());
	}

	@Override
	public int selectUserByEmail(String email) {
		return userRepository.selectUserByEmail(email);
	}

	@Override
	public User selectUserForLogin(User user) {
		User userInfo = userRepository.selectUserById(user.getUserId());
		System.out.println(user.getPassword());
		//회원가입좀 하겠습니다 - 장영우
		//if(userInfo == null || !encoder.matches(user.getPassword(), userInfo.getPassword())) {
		//	return null;
		//} 
		if(userInfo ==null) {
			return null;
		}
		return userInfo;
	}

	/*
	@Override
	public User findPassword(String email) {
		email.setPassword(encoder.encode(user.getPassword()));
		return userRepository.findPassword(email);
		}
	*/
	
	@Override
	public String findPassword(String email){
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String result = null;
		
		//System.out.println("login 확인 : " + log);
		
		//회원정보 불러오기
		//User user = user.login(login);
		
		//가입된 이메일이 존재한다면 이메일 발송
		if(selectUserByEmail(email) > 0) {
			
			//임시 비밀번호 생성(UUID 이용 - 특수문자는 못넣음)
			String tempPw = UUID.randomUUID().toString().replace("-", ""); // -를 제거
			tempPw = tempPw.substring(0,10); //tempPw를 앞에서부터 10자리 잘라줌
			
			System.out.println("임시 비밀번호 확인 : " + tempPw);
			
			//내부적으로 Map<String,List<k>> 를 구현
		      MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		      body.add("mail-template", "temp_email");
		      body.add("email", email);
		      body.add("randPw", tempPw);
		      
		      //RestTemplate의 기본 Content-type은 application/json
		      //Content-type을 form-url-encoded로 설정해서 통신해보기
		      RequestEntity<MultiValueMap<String, String>> request = 
		            RequestEntity
		            .post(ConfigCode.DOMAIN+"/mail")
		            .header("content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE)
		            .body(body);
		      
		      ResponseEntity<String> response = http.exchange(request, String.class);
		      mail.send(email, "We Artist 임시비밀번호 입니다.", response.getBody());
		      
		      // 임시비밀번호 암호화 해서 변수
		      //String rePassword = encoder.encode(tempPw);
		      String password = tempPw;	//나중에 위에 쓸때주석하셈
		      System.out.println(password);
		      userRepository.changePassword(password, email);
			
			result = "Success";
			
			
			
		} else {
			
			result = "Fail";
		}
		return result;
		
		
		
	}

	@Override
	public int updateUser(User persistInfo) {
		persistInfo.setPassword(encoder.encode(persistInfo.getPassword())); 
		return userRepository.updateUser(persistInfo);
	}

	@Override
	public void insertProPic(String userId, List<MultipartFile> files) {
		FileUtil fileUtil = new FileUtil();

		try {
			List<FileVo> fileList = fileUtil.fileUpload(files);
			for(FileVo fileVo : fileList) {
				fileVo.setUserId(userId); // 파일 저장시 필요한 userId
				userRepository.insertFile(fileVo); // TB_FILE 테이블에 파일 넣기
			}
		} catch (Exception e) {
			throw new ToAlertException(ErrorCode.IB01,e);
		}
		
	}
	
	@Override
	public int updateProPic(String userId) {
		
		
		
		return userRepository.updateProPic(userId);
	}

	@Override
	public Map<String, Object> selectProPicByFIdx(String fIdx) {
		FileVo fileList = new FileVo();
		fileList = userRepository.selectProPicByFIdx(fIdx);
		Map<String,Object> commandMap = new HashMap<String,Object>();
		commandMap.put("files",fileList);
		return commandMap;
	}
	
	

	@Override
	public User checkUserForLogin(String userId, String password) {
		User userInfo = userRepository.selectUserById(userId);
		if(userInfo == null || !encoder.matches(password, userInfo.getPassword())) {
			return null;
		} 
		return userInfo;
	}

	

	

	


}


