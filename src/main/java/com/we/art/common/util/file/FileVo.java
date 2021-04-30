package com.we.art.common.util.file;

import com.we.art.common.code.ConfigCode;

import lombok.Data;


//@Data
public class FileVo {
	
	private String fIdx;
	private String fOrigin;
	private String fRename;
	private String fDate;
	private String userId;
	private String fSavePath;
	private int isDel;
	
	public String getfIdx() {
		return fIdx;
	}

	public void setfIdx(String fIdx) {
		this.fIdx = fIdx;
	}

	public String getfOrigin() {
		return fOrigin;
	}

	public void setfOrigin(String fOrigin) {
		this.fOrigin = fOrigin;
	}

	public String getfRename() {
		return fRename;
	}

	public void setfRename(String fRename) {
		this.fRename = fRename;
	}


	public String getfDate() {
		return fDate;
	}

	public void setfDate(String fDate) {
		this.fDate = fDate;
	}


	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getfSavePath() {
		return fSavePath;
	}

	public void setfSavePath(String fSavePath) {
		this.fSavePath = fSavePath;
	}

	public int getIsDel() {
		return isDel;
	}

	public void setIsDel(int isDel) {
		this.isDel = isDel;
	}

	public String getFullPath() {
		return ConfigCode.UPLOAD_PATH + fSavePath;
	}

	@Override
	public String toString() {
		return "FileVo [fIdx=" + fIdx + ", fOrigin=" + fOrigin + ", fRename=" + fRename + ", fDate=" + fDate
				+ ", userId=" + userId + ", fSavePath=" + fSavePath + ", isDel=" + isDel + "]";
	}
	
	
}
