package com.we.art.common.code;

public enum ErrorCode {
	SM01("회원정보를 조회하는 도중 에러가 발생하였습니다.","/member/login"),
	IM01("회원정보를 입력하는 중 에러가 발생했습니다.","/member/join"),
	UM01("회원정보 수정 중 에러가 발생했습니다."),
	DM01("회원정보 삭제 중 에러가 발생했습니다."),
	IB01("게시글 등록 중 에러가 발생했습니다."),
	IF01("파일정보 등록 중 에러가 발생했습니다."),
	MAIL01("메일 발송 중 에러가 발생했습니다."),
	AUTH01("해당 페이지에 접근 하실 수 없습니다."),
	AUTH02("이미 인증이 만료된 링크입니다."),
	AUTH03("게시글은 로그인 후 작성할 수 있습니다."),
	API01("API통신 도중 에러가 발생하였습니다."),
	CD_404("존재하지 않는 경로입니다."),
	FILE01("파일 업로드중 예외가 발생하였습니다."),
	GALLERYISNULL("해당 갤러리는 준비중 입니다.","/search/main");
	
	
	//result.jsp를 사용해 띄울 안내문구
	private String errMsg;
	//result.jsp를 사용해 이동시킬 경로
	private String url = "/index";
	
	//index로 이동시킬 경우
	ErrorCode(String errMsg){
		this.errMsg = errMsg;
	}
	
	//index의 이외의 지정 페이지로 이동시킬 경우
	ErrorCode(String errMsg, String url){
		this.errMsg = errMsg;
		this.url = url;
	}
	
	public String errMsg() {
		return errMsg;
	}
	
	public String url() {
		return url;
	}
}
