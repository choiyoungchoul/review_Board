package com.board.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;




/**
 * 상세 설명
 * 게시글 리스트 vo
 * @author 최영철
 * @since 2023. 7. 25.
 * @column
 * title : 글 제목
 * contents : 글 내용
 * count : 조회수
 * content_title : 컨텐츠 제목
 * writer : 작성자
 * 
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
public class BoardVo {

	private int idx;
	private String title;
	private String contents;
	private int count;
	private int grades;
	private String contents_title;
	private String contents_url;
	private String writer;
	private String regdate;
	private String file_idx;
	private String origin_name;
	private double avg_grades;

}
