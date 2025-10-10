package net.koreate.hellking.board.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import net.koreate.hellking.board.vo.BoardVO;
import net.koreate.hellking.board.vo.FileVO;

public class FileUtils {

    private static final String uploadFolder = "C:/upload/";

    public List<FileVO> parseFileInfo(MultipartFile[] files, BoardVO board) throws Exception {
        List<FileVO> list = new ArrayList<>();
        if (files == null) return list;

        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String originalName = file.getOriginalFilename();
                String savedName = UUID.randomUUID() + "_" + originalName;
                file.transferTo(new File(uploadFolder, savedName));

                FileVO vo = new FileVO();
                vo.setBno(board.getBno());
                vo.setBoard_type(board.getBoard_type());
                vo.setOriginalName(originalName);
                vo.setSavedName(savedName);
                vo.setUploadPath(uploadFolder);
                vo.setFileSize(file.getSize());
                list.add(vo);
            }
        }
        return list;
    }

    public void deleteFile(FileVO file) {
        if (file != null) {
            File f = new File(file.getUploadPath(), file.getSavedName());
            if (f.exists()) {
                f.delete();
            }
        }
    }
}
