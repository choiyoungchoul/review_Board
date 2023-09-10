package com.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.board.vo.BoardVo;
import com.board.vo.FileVo;
import com.board.vo.GetBoardVo;

/**
 * 상세 설명
 * BOARD MAPPER 인터페이스
 * @author 최영철
 * @since 2023. 6. 27.
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 * 수정일           수정자          수정내용
 * ------------ ----------- ---------------------------
 *
 * </pre>
 */
@Mapper
public interface BoardMapper {
	
	//메인 페이지 리스트 불러오는 쿼리
	List<BoardVo> qrySelectList(GetBoardVo insParam);
	
	//게시글 개수 가져오는 쿼리
	int qryTotalCount(GetBoardVo insParam);
	
	//글 상세 쿼리
	BoardVo qryDetail (String idx);
	
	//글 등록 쿼리(게시판 테이블)
	int insContent (BoardVo boardVo);
	
	//글 등록 쿼리(넷플릭스 테이블)
	int insNetContent (BoardVo boardVo);
	
	//글 삭제 쿼리
	int qryDelete (String idx);
	
	//글 수정 쿼리
	int qryUpdate (BoardVo boardVo);
	
	//글 조회 증가 쿼리
	int qryCountUp(String idx);
	
	//파일 업로드
	int insFileUpload(FileVo fileVo);
	
	//파일 정보 불러오는 쿼리
	FileVo qryFileInfo(String fileIdx);

}
