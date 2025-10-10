package net.koreate.hellking.board.service;

<<<<<<< HEAD
import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.dao.BoardDAO;
import net.koreate.hellking.board.vo.BoardVO;
import net.koreate.hellking.common.util.Criteria;
import net.koreate.hellking.common.util.PageMaker;
=======
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.dao.BoardDAO;
import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.BoardPageMaker;
import net.koreate.hellking.board.util.BoardSearchCriteria;
import net.koreate.hellking.board.util.FileUtils;
import net.koreate.hellking.board.vo.BoardVO;
import net.koreate.hellking.board.vo.FileVO;
>>>>>>> b65c320 (Initial commit)

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
<<<<<<< HEAD
	
	private final BoardDAO dao;

	@Override
	public String regist(BoardVO board) throws Exception {
		int result = dao.create(board);
		String message = (result != 0) ? "게시글 등록 성공" : "게시글 등록 실패";
		return message;
	}
=======
		
	private final BoardDAO dao;

	@Override
	public String regist(BoardVO board, MultipartFile[] uploadFile) throws Exception {
	    // 1. 글 등록
	    dao.create(board); // board.bno는 아직 없음

	    // 2. 방금 등록된 글 번호 가져오기
	    int bno = dao.getLastInsertedBno();
	    board.setBno(bno); // 파일에 연결할 글 번호
	    
	    System.out.println("등록된 bno = " + board.getBno());

	    // 3. 첨부파일 처리
	    FileUtils fileUtils = new FileUtils();
	    List<FileVO> files = fileUtils.parseFileInfo(uploadFile, board); // bno 포함됨

	    if (!files.isEmpty()) {
	        dao.insertFiles(files); // 파일 정보 DB 저장
	        board.setFiles(files);
	    }
	    return "게시글 등록 성공";
	}
	
>>>>>>> b65c320 (Initial commit)

	@Override
	public void updateCnt(int bno) throws Exception {
		dao.updateCnt(bno);
	}

<<<<<<< HEAD
	@Override
	public BoardVO read(int bno) throws Exception {
		return dao.read(bno);
	}

	@Override
	public String modify(BoardVO board) throws Exception {
		return dao.update(board) != 0 ? "게시글 수정 성공" : "게시글 수정 실패";
	}
=======

	@Override
	public BoardVO read(int bno) throws Exception {
	    BoardVO board = dao.read(bno);
	    // board_type이 비어 있으면 기본값 세팅
	      if (board.getBoard_type() == null || board.getBoard_type().isEmpty()) {
	            board.setBoard_type("free"); // 실제 사용하는 게시판 종류로 맞춤
	        }
	        List<FileVO> files = dao.getFilesByBno(bno, board.getBoard_type());
	        board.setFiles(files);
	        return board;
	    }


    @Override
    public String modify(BoardVO board, List<Integer> delFiles, MultipartFile[] uploadFiles) throws Exception {
        // 1. 게시글 텍스트 수정
        int updated = dao.update(board);

        FileUtils fileUtils = new FileUtils();
        // 2. 기존 파일 삭제
        if (delFiles != null) {
            for (Integer fno : delFiles) {
                FileVO file = dao.findFileByFno(fno);
                fileUtils.deleteFile(file);  // 실제 파일 삭제
                dao.deleteFile(fno);        // DB 삭제
            }
        }

        // 3. 새 파일 업로드
        if (uploadFiles != null && uploadFiles.length > 0) {
            List<FileVO> newFiles = fileUtils.parseFileInfo(uploadFiles, board);
            if (!newFiles.isEmpty()) {
                dao.insertFiles(newFiles);
            }
        }

        return updated > 0 ? "게시글 수정 성공" : "게시글 수정 실패";
    }
>>>>>>> b65c320 (Initial commit)

	@Override
	public String remove(int bno) throws Exception {
		return dao.delete(bno) == 1 ? "게시글 삭제 성공" : "게시글 삭제 실패";
	}

	@Override
<<<<<<< HEAD
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		return dao.listCriteria(cri);
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) throws Exception {
		// totalCount, Criteria, displayPageNum
		PageMaker pm = new PageMaker();
=======
	public List<BoardVO> listCriteria(BoardCriteria cri) throws Exception {
	    List<BoardVO> list = dao.listCriteria(cri);
	    for (BoardVO board : list) {
	        String bt = board.getBoard_type();
	        if (bt == null || bt.isEmpty()) bt = "free";
	        board.setFiles(dao.getFilesByBno(board.getBno(), bt));
	    }
	    return list;
	}

	@Override
	public BoardPageMaker getPageMaker(BoardCriteria cri) throws Exception {
		// totalCount, Criteria, displayPageNum
		BoardPageMaker pm = new BoardPageMaker();
>>>>>>> b65c320 (Initial commit)
		int totalCount = dao.totalCount();
		pm.setCri(cri);
		pm.setTotalCount(totalCount);
		pm.setDisplayPageNum(10);
		return pm;
	}

	@Override
<<<<<<< HEAD
	public List<BoardVO> getHotBoard(int HotAgree) throws Exception{
	    return dao.getHotBoard(HotAgree);
=======
	public List<BoardVO> getHotBoard(int HotAgree) throws Exception {
	    List<BoardVO> list = dao.getHotBoard(HotAgree);

	    for (BoardVO board : list) {
	        // board_type 값이 없으면 기본값 세팅
	        String bt = board.getBoard_type();
	        if (bt == null || bt.isEmpty()) bt = "free";

	        // 첨부파일 목록 채워 넣기
	        board.setFiles(dao.getFilesByBno(board.getBno(), bt));
	    }
	    return list;
>>>>>>> b65c320 (Initial commit)
	}

	@Override
	public void plusAgree(int bno) throws Exception {
		dao.plusAgree(bno);
<<<<<<< HEAD
		
=======
	}
	
	@Override
	public void minusAgree(int bno) throws Exception {
	    dao.minusAgree(bno);
>>>>>>> b65c320 (Initial commit)
	}

	@Override
	public int AgreeCount(int bno) throws Exception {
		return dao.AgreeCount(bno);
	}
<<<<<<< HEAD
=======
	
    @Override
    public List<BoardVO> listSearch(BoardSearchCriteria cri) throws Exception {
        return dao.listSearch(cri);
    }

    @Override
    public BoardPageMaker getPageMaker(BoardSearchCriteria cri) throws Exception {
        BoardPageMaker pm = new BoardPageMaker();
        pm.setCri(cri);
        pm.setDisplayPageNum(10);
        pm.setTotalCount(dao.countSearch(cri));
        return pm;
    }
    
    @Override
    public Map<String, Object> toggleAgree(int bno, String userId) throws Exception {
        Map<String, Object> result = new HashMap<>();
        if (dao.existsUserAgree(bno, userId)) {
            dao.deleteUserAgree(bno, userId);   // 추천 취소
            dao.minusAgree(bno);                // -1
            result.put("liked", false);
        } else {
            dao.insertUserAgree(bno, userId);   // 추천 추가
            dao.plusAgree(bno);                 // +1
            result.put("liked", true);
        }
        result.put("agreeCount", dao.AgreeCount(bno));
        return result;
    }

>>>>>>> b65c320 (Initial commit)

}
