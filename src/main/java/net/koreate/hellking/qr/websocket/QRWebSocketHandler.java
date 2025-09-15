package net.koreate.hellking.qr.websocket;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class QRWebSocketHandler extends TextWebSocketHandler {
    
    private final Map<String, WebSocketSession> sessions = new ConcurrentHashMap<>();
    private final ObjectMapper objectMapper = new ObjectMapper();
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String userNum = getUserNumFromSession(session);
        if (userNum != null) {
            sessions.put(userNum, session);
        }
    }
    
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String userNum = getUserNumFromSession(session);
        if (userNum != null) {
            sessions.remove(userNum);
        }
    }
    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 클라이언트로부터 메시지 처리 (필요 시)
    }
    
    // 특정 사용자에게 메시지 전송
    public void sendMessageToUser(String userNum, Object message) throws Exception {
        WebSocketSession session = sessions.get(userNum);
        if (session != null && session.isOpen()) {
            String jsonMessage = objectMapper.writeValueAsString(message);
            session.sendMessage(new TextMessage(jsonMessage));
        }
    }
    
    // 모든 연결된 사용자에게 브로드캐스트
    public void broadcastMessage(Object message) throws Exception {
        String jsonMessage = objectMapper.writeValueAsString(message);
        for (WebSocketSession session : sessions.values()) {
            if (session.isOpen()) {
                session.sendMessage(new TextMessage(jsonMessage));
            }
        }
    }
    
    private String getUserNumFromSession(WebSocketSession session) {
        // HttpSession에서 userNum 추출
        return (String) session.getAttributes().get("userNum");
    }
}