package com.we.art.common.code;

public enum ConfigCode {

	DOMAIN("http:http://3.19.138.148:8080"),
    UPLOAD_PATH("/var/lib/tomcat8/webapps/upload/"),
	//DOMAIN("http://localhost:9898"),
    //UPLOAD_PATH("C:\\code\\resources\\upload\\"),
    EMAIL("weartist1@naver.com"),
	GALLERY_PATH("C:\\code\\resources\\gallery\\");
    public  String desc;

    ConfigCode(String desc){
        this.desc = desc;
    }

    @Override
    public String toString() {
        return desc;
    }
}