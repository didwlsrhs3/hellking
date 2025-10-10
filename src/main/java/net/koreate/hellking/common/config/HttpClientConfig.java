package net.koreate.hellking.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.client.config.RequestConfig;

@Configuration
public class HttpClientConfig {
    
    /**
     * RestTemplate Bean 설정
     * 카카오 API 호출용 HTTP 클라이언트
     */
    @Bean
    public RestTemplate restTemplate() {
        // HttpClient 설정
        RequestConfig config = RequestConfig.custom()
                .setConnectTimeout(5000)        // 연결 타임아웃: 5초
                .setSocketTimeout(10000)        // 소켓 타임아웃: 10초
                .setConnectionRequestTimeout(3000) // 커넥션 풀에서 커넥션을 가져오는 타임아웃: 3초
                .build();
        
        org.apache.http.client.HttpClient httpClient = HttpClientBuilder.create()
                .setMaxConnTotal(100)           // 전체 커넥션 풀 크기
                .setMaxConnPerRoute(20)         // 호스트당 최대 커넥션 수
                .setDefaultRequestConfig(config)
                .build();
        
        // HttpComponentsClientHttpRequestFactory 설정
        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
        factory.setHttpClient(httpClient);
        
        return new RestTemplate(factory);
    }
    
    /**
     * 에러 처리를 위한 RestTemplate (선택사항)
     */
    @Bean(name = "kakaoApiRestTemplate")
    public RestTemplate kakaoApiRestTemplate() {
        RestTemplate restTemplate = restTemplate();
        
        // 에러 핸들러 추가 (필요시)
        restTemplate.setErrorHandler(new org.springframework.web.client.ResponseErrorHandler() {
            @Override
            public boolean hasError(org.springframework.http.client.ClientHttpResponse response) throws java.io.IOException {
                return response.getStatusCode().series() == org.springframework.http.HttpStatus.Series.CLIENT_ERROR ||
                       response.getStatusCode().series() == org.springframework.http.HttpStatus.Series.SERVER_ERROR;
            }
            
            @Override
            public void handleError(org.springframework.http.client.ClientHttpResponse response) throws java.io.IOException {
                System.err.println("카카오 API 호출 오류: " + response.getStatusCode() + " " + response.getStatusText());
                // 필요에 따라 커스텀 예외 처리
            }
        });
        
        return restTemplate;
    }
}