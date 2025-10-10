package net.koreate.hellking.board.util;

import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

public class FileUpload implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/upload/**") // 웹에서 접근할 경로
                .addResourceLocations("file:///C:/upload/"); // 실제 파일 저장 경로
    }
}
