package net.koreate.hellking.common.utils;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

/**
 * 이미지로 판별할 MIME type을 저장해놓을 객체
 */
public class MediaUtils {
	
	private static Map<String,MediaType> mediaMap;
	
	static {
		mediaMap = new HashMap<>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("JPEG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}
	
	/**
	 * 확장자 명을 전달 받아 동일한 이름의 MediaType이 존재하는지
	 * 확인 후 반환
	 * @return null - 이미지가 아님
	 */
	public static MediaType getMediaType(String ext) {
		return mediaMap.get(ext.toUpperCase());
		
	}
	
}










