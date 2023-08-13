package com.board.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 상세 설명
 * 게시글 param vo
 * @author 최영철
 * @since 2023. 7. 28.
 * @column
 * seq : 게시글 index
 * srchTitle : 검색 할 제목
 * srchType : 검색 타입 (제목,컨텐츠 제목)
 * currentPage : 현재 페이지 (페이징 처리 시 필요)
 * page : 시작 페이지
 * amount : 가져 올 페이지 개수
 * 
 *      <pre> 
 * << 개정이력(Modification Information) >>
 *
 * 수정일           수정자          수정내용
 * ------------ ----------- ---------------------------
 *
 *      </pre>
 */
@Getter
@Setter
@ToString
public class GetBoardVo {
	
    private int seq;
    private String srchType;
    private String srchTxt;
    private int currentPage;
    private int page;
    private int amount;

}
