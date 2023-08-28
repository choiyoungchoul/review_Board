package com.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.board.mapper.BoardMapper;
import com.board.vo.BoardVo;
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
	public int insContent(BoardVo boardVo) {
		
		//게시판 테이블 DB저장
		int result = boardMapper.insContent(boardVo);
		
		if(result == 1) {
			//컨텐츠 테이블에도 컨텐츠명 저장
			boardMapper.insNetContent(boardVo);
		}

		return result; 
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
	
	

}
