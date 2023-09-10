package com.board.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.board.mapper.BoardMapper;
import com.board.vo.BoardVo;
import com.board.vo.FileVo;
import com.board.vo.GetBoardVo;
import com.util.Paginator;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardService {

	@Autowired
	private BoardMapper boardMapper;
	
	//게시글 하단에 보여질 페이지 개수
	private static final Integer pagesPerBlock = 5;
	
	/**
	 * 상세 설명
	 * 게시글 리스트 가져오는 서비스
	 * @author 최영철
	 * @since 2023. 7. 25.
	 * @see
	 *
	 *      <pre
	 * << 개정이력(Modification Information) >>
	 *
	 * 수정일           수정자          수정내용
	 * ------------ ----------- ---------------------------
	 *
	 *      </pre>
	 */
	public List<BoardVo> selectList(GetBoardVo insParam) {
		
		return boardMapper.qrySelectList(insParam);
	}
	
	/**
	 * 상세 설명
	 * 게시글 총개수 가져오는 서비스
	 * @author 최영철
	 * @since 2023. 7. 29.
	 * @see
	 *
	 *      <pre>
	 * << 개정이력(Modification Information) >>
	 *
	 * 수정일           수정자          수정내용
	 * ------------ ----------- ---------------------------
	 *
	 *      </pre>
	 */
	public int qryTotalCount(GetBoardVo insParam) {
		
		return boardMapper.qryTotalCount(insParam);
	}
	
	/**
	 * 상세 설명
	 * 게시글 등록 서비스
	 * @author 최영철
	 * @since 2023. 7. 25.
	 * @see
	 *
	 *      <pre>
	 * << 개정이력(Modification Information) >>
	 *
	 * 수정일           수정자          수정내용
	 * ------------ ----------- ---------------------------
	 */
	@Transactional
	public Map<String, Object> insContent(BoardVo boardVo) {
		
		Map<String, Object> response = new HashMap<>();
		
		//게시판 테이블 DB저장
		int result = boardMapper.insContent(boardVo);
		
		if(result == 1) {
			
			//컨텐츠 테이블에도 컨텐츠명 저장
			boardMapper.insNetContent(boardVo);
			
		}
		
		//방금 등록된 게시글 return 해주기
		response.put("idx", boardVo.getIdx());
		response.put("result", result);
		
		return response; 
	}
	
	/**
	 * 상세 설명
	 * 게시글 상세 가져오기 서비스
	 * @author 최영철
	 * @since 2023. 8. 1.
	 * @parameter
	 * currentPage : 현재 페이지
	 * postsPerPage : 보여줄 게시글 수
	 * total : 총 페이지 수
	 * 
	 *      <pre>
	 * << 개정이력(Modification Information) >>
	 *
	 * 수정일           수정자          수정내용
	 * ------------ ----------- ---------------------------
	 *
	 *      </pre>
	 */
	public  Map<String, Object> qryDetail(String userName, String idx) {
		
		//글 상세 정보 가져오기
		BoardVo detailContent = boardMapper.qryDetail(idx);
		
		//로그인 사용자와 글작성자 일치여부 flag(수정,삭제,조회수 count에 이용 됨)
		String writerYn = "";
		
		//현재 로그인 사용자와 글작성자 비교
		if(userName.equals(detailContent.getWriter())) {
			writerYn = "Y";
		}else {
			writerYn = "N";
			//조회수 증가
			boardMapper.qryCountUp(idx);
			int count = detailContent.getCount();
			detailContent.setCount(count+=1);
		}
		
		Map<String, Object> response = new HashMap<>();
		
		response.put("detailContent", detailContent);
		response.put("writerYn", writerYn);
		
		
		return response;
		
	}
	
	/**
	 * 상세 설명
	 * 게시글 삭제하기 서비스
	 * @author 최영철
	 * @since 2023. 8. 1.
	 * @parameter
	 * currentPage : 현재 페이지
	 * postsPerPage : 보여줄 게시글 수
	 * total : 총 페이지 수
	 * 
	 *      <pre>
	 * << 개정이력(Modification Information) >>
	 *
	 * 수정일           수정자          수정내용
	 * ------------ ----------- ---------------------------
	 *
	 *      </pre>
	 */
	public  Map<String, Object> qryDelete(String idx) {
		
		//글 상세 정보 가져오기
		int result = boardMapper.qryDelete(idx);
		
		Map<String, Object> response = new HashMap<>();
		
		response.put("result", result);
				
		return response;
		
	}
	
	
	/**
	 * 상세 설명
	 * 게시글 수정하기 서비스
	 * @author 최영철
	 * @since 2023. 8. 2.
	 * @parameter
	 * currentPage : 현재 페이지
	 * postsPerPage : 보여줄 게시글 수
	 * total : 총 페이지 수
	 * 
	 *      <pre>
	 * << 개정이력(Modification Information) >>
	 *
	 * 수정일           수정자          수정내용
	 * ------------ ----------- ---------------------------
	 *
	 *      </pre>
	 */
	public  Map<String, Object> qryUpdate(BoardVo boardVo) {
		
		//글 상세 정보 가져오기
		int result = boardMapper.qryUpdate(boardVo);
		
		Map<String, Object> response = new HashMap<>();
		
		response.put("result", result);
				
		return response;
		
	}
	
	/**
	 * 상세 설명
	 * 페이징 처리 서비스
	 * @author 최영철
	 * @since 2023. 7. 29.
	 * @parameter
	 * currentPage : 현재 페이지
	 * postsPerPage : 보여줄 게시글 수
	 * total : 총 페이지 수
	 * 
	 *      <pre>
	 * << 개정이력(Modification Information) >>
	 *
	 * 수정일           수정자          수정내용
	 * ------------ ----------- ---------------------------
	 *
	 *      </pre>
	 */
	public  Map<String, Object> GetPageInfo(int currentPage, int postsPerPage, long total) {
		
		Paginator paginator = new Paginator(pagesPerBlock, postsPerPage, total);
		
		Map<String, Object> pageInfo = paginator.getFixedBlock(currentPage);
		
		return pageInfo;
		
	}
	
	
	
	/**
	 * 상세 설명
	 * 파일 업로드 서비스
	 * @author 최영철
	 * @since 2023. 7. 29.
	 * @parameter
	 * Board_no : 게시글 번호
	 * postsPerPage : 보여줄 게시글 수
	 * total : 총 페이지 수
	 * 
	 *      <pre>
	 * << 개정이력(Modification Information) >>
	 *
	 * 수정일           수정자          수정내용
	 * ------------ ----------- ---------------------------
	 *
	 *      </pre>
	 */
    public int fileUpload(MultipartFile file, int boardNo) throws IOException {
    	
    	//DB저장 결과값
    	int result = 0;

        // 원래 파일 이름 추출
        String origName = file.getOriginalFilename();

        // 파일 이름으로 쓸 uuid 생성
        String uuid = UUID.randomUUID().toString();

        // 확장자 추출(ex : .png)
        String extension = origName.substring(origName.lastIndexOf("."));

        // uuid와 확장자 결합
        String savedName = uuid + extension;
 
        // 파일을 불러올 때 사용할 파일 경로
        String originalFileName = file.getOriginalFilename();
        File destination = new File("D:\\file\\" + originalFileName);
        
        String savedPath = destination + savedName;

        // 실제로 로컬에 uuid를 파일명으로 저장
        file.transferTo(new File(savedPath));
        
        
        //업로드한 파일정보 DB에 저장
        FileVo fileVo = new FileVo();
        
        fileVo.setBoard_no(boardNo);
        fileVo.setFile_name(savedName);
        fileVo.setFile_path(savedPath);
        fileVo.setFile_type(extension);
        fileVo.setOrigin_name(origName);
        
        result = boardMapper.insFileUpload(fileVo);

        return result;
        
    }
    
    
    
    
    
	/**
	 * 상세 설명
	 * 파일 정보 조회 서비스
	 * @author 최영철
	 * @since 2023. 9. 8.
	 * @parameter
	 * Board_no : 게시글 번호
	 * postsPerPage : 보여줄 게시글 수
	 * total : 총 페이지 수
	 * 
	 *      <pre>
	 * << 개정이력(Modification Information) >>
	 *
	 * 수정일           수정자          수정내용
	 * ------------ ----------- ---------------------------
	 *
	 *      </pre>
	 */
    public FileVo qryFileInfo(String fileIdx) throws IOException {
    	
    	FileVo fileInfo = boardMapper.qryFileInfo(fileIdx);

        return fileInfo;
        
    }
	
}
