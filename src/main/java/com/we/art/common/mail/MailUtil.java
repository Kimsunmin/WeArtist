package com.we.art.common.mail;

import com.we.art.user.model.vo.User;

public class MailUtil {
	
	public void sendMail(User user) throws Exception{
		//Mail 서버 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "wco0207";
		String hostSMTPpw = "weartist150";
		
		//보내는 사람
		String fromEmail = "wco0207@naver.com";
		String fromName = "WeArtist";
		
		String subject = "";
		String msg = "";
		
		subject = "[WeArtist] 임시 비밀번호 발급 안내";
		msg += "<div align='left'>";
		msg += "<h3>";
		msg += user.getEmail() + "님의 임시 비밀번호입니다.<br>비밀번호를 변경하여 사용하세요.</h3>";
		msg += "<p>임시 비밀번호 : ";
		msg += user.getPassword() + "</p></div>";
		
		//email 전송
		String mailRecipient = user.getEmail(); //받는 사람 이메일 주소
		try {
			//객체 선언
			//MailSender mail = new MailSender();
			/*mail.setform(true);
			mail.setCharset(charSet);
			mail.setSSLOnConnect(true); //SSL 사용 (TLS가 없는 경우에 SSL사용)
			mail.setHostName(hostSMTP);
			mail.setSmtpPort(587); 		//SMTP 포트 번호
			mail.setAuthentication(hostSMTPid, hostSMTPpw);
			mail.setStartTLSEnabled(true); //TLS 사용
			mail.addTo(mailRecipient, charSet);
			mail.setFrom(fromEmail, fromName, charSet);
			mail.setSubject(subject);
			mail.setHtmlMsg(msg);
			mail.send();
			*/
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
