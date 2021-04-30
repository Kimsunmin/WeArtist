package com.we.art.user.validator;


import java.util.regex.Pattern;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.we.art.user.model.repository.UserRepository;
import com.we.art.user.model.vo.User;

@Component
public class UserValidator implements Validator{

	private final UserRepository userRepository;
	
	public UserValidator(UserRepository userRepository) {
		this.userRepository = userRepository;
	}
	
	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Pattern pattern = Pattern.compile("^(?!.*[ㄱ-힣])(?=.*\\W)(?=.*\\d)(?=.*[a-zA-Z])(?=.{8,})");
		User persistInfo = (User) target;
		
		if(userRepository.selectUserById(persistInfo.getUserId()) != null) {
			errors.rejectValue("userId", "error.userId", "이미 존재하는 아이디입니다.");
		}
		
		if(userRepository.selectUserByNick(persistInfo.getNickName()) != null) {
			errors.rejectValue("nickName", "error.nickName", "이미 존재하는 닉네임입니다.");
		}
		
		if(!pattern.matcher(persistInfo.getPassword()).find()) {
			errors.rejectValue("password", "error.password", "비밀번호는 숫자, 영문자, 특수문자 조합의 8글자 이상인 문자열입니다.");
		}
		if(userRepository.selectUserByEmail(persistInfo.getEmail()) > 0) {
			errors.rejectValue("email", "error.email", "이미 존재하는 이메일입니다.");
		}
		
	}
	


}
