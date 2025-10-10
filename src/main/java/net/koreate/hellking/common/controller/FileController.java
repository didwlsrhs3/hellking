package net.koreate.hellking.common.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.common.utils.FileUtils;

@RestController
@RequiredArgsConstructor
public class FileController {
	
	private final String uploadPath;
	
	private final ServletContext servletContext;
	
	// 완성된 실제 저장 폴더 경로
	private String realPath;
	
	@PostConstruct
	public void initPath() {
		realPath = servletContext.getRealPath(
			File.separator+uploadPath
		);
		File file = new File(realPath);
		if(!file.exists()) {
			file.mkdirs();
			System.out.println("경로 생성 완료");
		}
		System.out.println("FileController 초기화 완료");
	}
	
	@GetMapping("displayFile")
	public ResponseEntity<byte[]> displayFile(
				String fileName
			)throws Exception{
		System.out.println("displayFile : "+fileName);
		return new ResponseEntity<>(
			FileUtils.getBytes(realPath, fileName),
			FileUtils.getHeaders(fileName),
			HttpStatus.CREATED
		);
	}
	
	
	@PostMapping("uploadfile")
	public List<String> uploadFile(List<MultipartFile> files) throws Exception{
	    String uploadPath = servletContext.getRealPath("/resources/upload/");
	    
	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdirs();
	    }
	    
		List<String> list = new ArrayList<>();
		for(MultipartFile f : files) {
			list.add(FileUtils.uploadFile(realPath, f));
		}
		return list;
	}
	
	
	@DeleteMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(
				@RequestBody String fileName
			)throws Exception{
		boolean isDeleted
			= FileUtils.deleteFile(realPath, fileName);
		if(isDeleted) {
			return new ResponseEntity<>("DELETED",HttpStatus.OK);
		}
		return new ResponseEntity<>("FAILED",HttpStatus.BAD_REQUEST);
	}
	

}












