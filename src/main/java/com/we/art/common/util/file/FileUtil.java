package com.we.art.common.util.file;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import com.we.art.common.code.ConfigCode;

public class FileUtil {
	
	public List<FileVo> fileUpload(List<MultipartFile> files) throws IOException, Exception{
		
		List<FileVo> fileDatas = new ArrayList<FileVo>();
		String fSavePath = getSavePath();
		if(files.size() >= 1 && files.get(0).getOriginalFilename() != null) {
			for(MultipartFile multipartFile : files) {
				
				String fRename = UUID.randomUUID().toString();
				String fOrigin = multipartFile.getOriginalFilename();
				
				FileVo fileVo = new FileVo();
				fileVo.setfOrigin(fOrigin);
				fileVo.setfRename(fRename);
				fileVo.setfSavePath(fSavePath);
				fileDatas.add(fileVo);
				 
				saveFile(multipartFile,fileVo);
			}
		}
		return fileDatas;
	}
	
	private String getSavePath() {
		Calendar cal = Calendar.getInstance();
		return cal.get(Calendar.YEAR)
				+"/"+ (cal.get(Calendar.MONTH)+1)
				+"/"+ cal.get(Calendar.DAY_OF_MONTH) + "/";
	}
	
	private void saveFile(MultipartFile multipartFile, FileVo fileVo) throws Exception, IOException {
		File file = new File(fileVo.getFullPath() + fileVo.getfRename());
		if(!file.exists()) {
			new File(fileVo.getFullPath()).mkdirs();
		}
		multipartFile.transferTo(file);
	}
	
	private void deleteFile(String path, String fRename) {
		File file = new File(ConfigCode.UPLOAD_PATH + path + fRename);
		file.delete();
	}
	
}





















