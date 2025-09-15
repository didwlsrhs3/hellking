package net.koreate.hellking.common.util;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import javax.imageio.ImageIO;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class QRCodeUtil {
    
    /**
     * QR 코드 생성
     */
    public static BufferedImage generateQRCode(String data, int width, int height) throws WriterException {
        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.MARGIN, 1);
        
        MultiFormatWriter writer = new MultiFormatWriter();
        BitMatrix bitMatrix = writer.encode(data, BarcodeFormat.QR_CODE, width, height, hints);
        
        return matrixToImage(bitMatrix);
    }
    
    /**
     * BitMatrix를 BufferedImage로 변환
     */
    private static BufferedImage matrixToImage(BitMatrix matrix) {
        int width = matrix.getWidth();
        int height = matrix.getHeight();
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        
        Graphics2D graphics = image.createGraphics();
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, width, height);
        graphics.setColor(Color.BLACK);
        
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                if (matrix.get(i, j)) {
                    graphics.fillRect(i, j, 1, 1);
                }
            }
        }
        
        return image;
    }
    
    /**
     * BufferedImage를 Base64 문자열로 변환
     */
    public static String bufferedImageToBase64(BufferedImage image) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image, "PNG", baos);
        byte[] imageBytes = baos.toByteArray();
        return "data:image/png;base64," + Base64.getEncoder().encodeToString(imageBytes);
    }
    
    /**
     * QR 코드 데이터 검증
     */
    public static boolean isValidQRData(String data) {
        if (data == null || data.trim().isEmpty()) {
            return false;
        }
        
        // HELLKING 형식 검증
        if (data.startsWith("HELLKING:")) {
            String[] parts = data.split(":");
            return parts.length >= 3;
        }
        
        return true;
    }
    
    /**
     * QR 코드 데이터에서 사용자 번호 추출
     */
    public static Long extractUserNum(String qrData) {
        if (qrData.startsWith("HELLKING:")) {
            String[] parts = qrData.split(":");
            if (parts.length >= 2) {
                try {
                    return Long.parseLong(parts[1]);
                } catch (NumberFormatException e) {
                    return null;
                }
            }
        }
        return null;
    }
}