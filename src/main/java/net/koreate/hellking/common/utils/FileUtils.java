package net.koreate.hellking.common.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.StreamUtils;
import org.springframework.web.multipart.MultipartFile;

public class FileUtils {
	
	/**
	 * file upload 처리 후 업로된 파일 이름 반환
	 */
	public static String uploadFile(String realPath, MultipartFile file) throws Exception{
	    String uploadFileName = "";
	    
	    String originalName = file.getOriginalFilename();
	    
	    // 원본 파일명이 너무 긴 경우 미리 자르기
	    if (originalName != null && originalName.length() > 100) {
	        String extension = "";
	        int dotIndex = originalName.lastIndexOf('.');
	        if (dotIndex > 0) {
	            extension = originalName.substring(dotIndex);
	        }
	        
	        String nameWithoutExt = originalName.substring(0, Math.min(dotIndex, 100 - extension.length()));
	        originalName = nameWithoutExt + extension;
	        System.out.println("원본 파일명 길이 제한: " + originalName);
	    }
	    
	    UUID uid = UUID.randomUUID(); // 중복 방지 위한 이름 설정
	    
	    String savedName = uid.toString().replace("-","");
	    // _를 기준으로 원본파일이름을 구분할 것이기 때문에 원본파일에 포함된 _ 특수문자를 공백으로 치환
	    uploadFileName = savedName + "_"+(originalName.replace("_", " "));
	    
	    // 최종 파일명이 너무 긴 경우 추가 제한 (경로 포함 200자 제한 고려)
	    if (uploadFileName.length() > 150) { // 경로를 위한 여유분 50자
	        String extension = "";
	        int dotIndex = uploadFileName.lastIndexOf('.');
	        if (dotIndex > 0) {
	            extension = uploadFileName.substring(dotIndex);
	        }
	        
	        // UUID 부분은 그대로 두고 원본 파일명 부분만 자르기
	        String uuidPart = savedName + "_";
	        int maxOriginalLength = 150 - uuidPart.length() - extension.length();
	        
	        if (maxOriginalLength > 0) {
	            String originalPart = uploadFileName.substring(uuidPart.length(), uploadFileName.lastIndexOf('.'));
	            if (originalPart.length() > maxOriginalLength) {
	                originalPart = originalPart.substring(0, maxOriginalLength);
	            }
	            uploadFileName = uuidPart + originalPart + extension;
	        }
	        
	        System.out.println("파일명 길이 제한 적용: " + uploadFileName);
	    }
	    
	    // 날짜별 디렉토리 생성
	    String datePath = calcDatePath(realPath);
	    
	    File uploadFile = new File(realPath + datePath, uploadFileName);
	    System.out.println("uploadFileName : " + uploadFileName);
	    
	    // 일반 파일
	    String originalUploadFileName = makeFileName(datePath,uploadFileName);
	    file.transferTo(uploadFile);
	    
	    // 업로드된 파일의 확장자
	    String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
	    System.out.println(formatName);
	    
	    if(MediaUtils.getMediaType(formatName) != null) {
	        // 이미지 파일
	        uploadFileName = makeThumbnail(realPath,datePath,uploadFileName);
	    }else {
	        uploadFileName = originalUploadFileName;
	    }
	    
	    // 최종 반환값 길이 체크
	    System.out.println("최종 파일명 길이: " + uploadFileName.length());
	    
	    return uploadFileName;
	}
	
	// 디렉토리 구분자를 URL 구분자로 변경하여 반환
	private static String makeFileName(String datePath, String uploadFileName) {
		String fileName = datePath + File.separator + uploadFileName;
		return fileName.replace(File.separatorChar, '/');
	}
	
	// 썸네일 생성 후 URL 경로로 썸네일 이미지 경로 반환
	private static String makeThumbnail(String realPath, String datePath, String savedName) throws IOException {
	    try {
	        File file = new File(realPath + datePath, savedName);
	        System.out.println("read exists : " + file.exists());
	        System.out.println(file.getAbsolutePath());
	        
	        // 파일 존재 확인
	        if (!file.exists()) {
	            System.out.println("원본 파일이 존재하지 않음. 썸네일 생성 건너뜀.");
	            return makeFileName(datePath, savedName);
	        }
	        
	        BufferedImage image = ImageIO.read(file);
	        
	        // 이미지 로딩 실패시 원본 반환
	        if (image == null) {
	            System.out.println("이미지 로딩 실패. 원본 파일 경로 반환.");
	            return makeFileName(datePath, savedName);
	        }
	        
	        BufferedImage sourceImage = Scalr.resize(image, 
	            Scalr.Method.AUTOMATIC,
	            Scalr.Mode.FIT_TO_HEIGHT,
	            100);
	            
	        String thumbnailImage = realPath + datePath + File.separator + "s_" + savedName;
	        String ext = savedName.substring(savedName.lastIndexOf(".") + 1);
	        File f = new File(thumbnailImage);
	        
	        ImageIO.write(sourceImage, ext, f);
	        
	        String name = thumbnailImage.substring(realPath.length()).replace(File.separatorChar, '/');
	        System.out.println("썸네일 생성 성공: " + name);
	        return name;
	        
	    } catch (Exception e) {
	        System.err.println("썸네일 생성 실패: " + e.getMessage());
	        e.printStackTrace();
	        // 예외 발생시 원본 파일 경로 반환
	        return makeFileName(datePath, savedName);
	    }
	}


	//   \yyyy\mm\dd 형식의 폴더 생성 및 경로를 문자열로 반환
	//   유닉스 /yyyy/mm/dd
	private static String calcDatePath(String realPath) {
		// 현재 시간에 대한 정보를 저장하고 있는 객체
		LocalDateTime date = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(
			File.separator+"yyyy"+File.separator+"MM"+File.separator+"dd"
		);
		String datePath = date.format(dtf);
		File file = new File(realPath, datePath);
		if(!file.exists()) {
			file.mkdirs();
		}
		return datePath;
	}

	/**
	 * 업로드 경로 와 파일이름을 매개변수로 전달 받아
	 * 지정된 위치에 파일 정보를 byte[] 이진데이터로 반환
	 */
	public static byte[] getBytes(String realPath, String fileName) throws Exception{
		File file = new File(realPath, fileName);
		InputStream is = new FileInputStream(file);
		return StreamUtils.copyToByteArray(is);
	} // getBytes end
	
	// 다운로드 파일 헤더 정보 반환
	public static HttpHeaders getHeaders(String fileName) throws Exception{
		HttpHeaders headers = new HttpHeaders();
		String ext = fileName.substring(fileName.lastIndexOf(".")+1);
		
		MediaType m = MediaUtils.getMediaType(ext);
		System.out.println(m);
		if(m != null) {
			headers.setContentType(m);
		}else {
			/*
			 *	8비트 / 1byte 단위의 이진 데이터 임을 의미
			 *  옥텟은 컴퓨팅에서 8개의 비트가 하나로 모인것을 의미
			 *  브라우저는 이진데이터는 해석할 수 없으므로 다운로드를 받아 사용자가 처리하도록 데이터를 처리한다. 
			 */
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			// headers.set("Content-Type", "application/octet-stream");
			
			// 조합된 이름에서 원본파일 이름 추출
			String origin = fileName.substring( fileName.lastIndexOf("_") + 1 );
			/*
			// URL이 해석할수 있는 인코딩 형식으로 변경
			origin = new String(origin.getBytes("UTF-8"), "ISO-8859-1");
			// 일반 HTTP 응답에서 Content-Disposition 응답 헤더는 콘텐츠가 브라우저에 인라인 으로 표시되어야 하는지 , 
			// 즉 웹 페이지나 웹 페이지의 일부 또는 첨부 파일 로 표시되는지 여부를 나타내는 헤더 입니다. 
			// 다운로드되어 로컬에 저장됩니다.
			 // disposition : 배치, 조치
			 // attachment : 부착 , 첨부물- 파일
			// fileName 옵션 - 전송되는 첨부 데이터의 이름 명시
			headers.add("Content-Disposition", "attachment;fileName=\""+origin+"\"");
			*/
			
			ContentDisposition cd = ContentDisposition
									.attachment()
									// 어떤 언어 형식으로 되어 있는 문자열인지 알아야 decoding 할수 있으므로
									// 언어 형식 지정
									.filename(origin, Charset.forName("UTF-8"))
									.build();
			
			headers.setContentDisposition(cd);
		}
		System.out.println(headers);
		return headers;
	}

	/**
	 * 파일 제거 후 결과 반환
	 */
	public static boolean deleteFile(String realPath, String fileName) {
		boolean isDeleted = false;
		System.out.println("deleteFile realpath : " + realPath);
		System.out.println("deleteFile fileName : " + fileName);
		fileName = (fileName).replace('/', File.separatorChar);
		// 일반 파일이나, 썸네일 이미지 삭제
		File file = new File(realPath,fileName);
		System.out.println(file.getAbsolutePath());	
		isDeleted = file.delete();
		return isDeleted;
	}
	
	
}












