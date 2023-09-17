package com.board.controller;

import java.awt.PageAttributes.MediaType;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.net.http.HttpHeaders;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.filechooser.FileSystemView;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriUtils;

import com.board.service.BoardService;
import com.board.vo.BoardVo;
import com.board.vo.FileVo;
import com.board.vo.GetBoardVo;
import com.configuration.AdminAuthorize;
import com.configuration.UserAuthorize;
import com.util.Crawling;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	//게시글 하단에 보여질 페이지 개수
	private static final Integer pagesPerBlock = 5;
	
	/**
	 * 상세 설명
	 * 게시판 메인페이지 이동 & 글목록 가져오는 컨트롤러
	 * @author 최영철
	 * @since 2023. 7. 25.
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
    @GetMapping("/main")
    public ModelAndView qryMainPageMethod(@AuthenticationPrincipal UserDetails user, GetBoardVo insParam) {
    	
        //ModelAndView (데이터와 뷰를 동시에 설정이 가능)
    	//@AuthenticationPrincipal 어노테이션은 현재 로그인 한 유저의 정보를 불러오는 어노테이션(시큐리티에서 제공)
        ModelAndView mv = new ModelAndView();
        
        //넷플릭스 타이틀 가져오기
        Crawling cs = new Crawling();
        
        //크롤링 한 현재 넷플릭스 TOP10 목록
        List<String> itemList = cs.getContent_Netflix_Title();
        
        //메인 페이지는 최근 등록 된 게시글 순으로 보여짐
        insParam.setPage(0);
        insParam.setAmount(10);
    	
        //작성된 총 게시글 가져오기
        int totalCount = boardService.qryTotalCount(insParam);
        
        //메인화면 게시글 목록 가져오기
    	mv.addObject("boardList", boardService.selectList(insParam));       
    	mv.addObject("totalCount", totalCount);  
    	//페이지 정보 가져오기( GetPageInfo(총 페이지 개수, 현재 페이지, 총 게시글 수))
    	mv.addObject("pageInfo", boardService.GetPageInfo(1, 10, Long.valueOf(totalCount))); 
    	//넷플릭스 TOP10 목록
    	mv.addObject("itemList", itemList); 
        
        //로그인 상태면 접속 user 정보 화면에 노출
        if(user != null) {
        	mv.addObject("userName", user.getUsername());                //로그인 유저 이름
        	mv.addObject("userAuthoritie", user.getAuthorities());       //로그인 유저의 권한(회원등급)
        }
        
        //return view
        mv.setViewName("/main");

        return mv;
    }
    
    
    
	/**
	 * 상세 설명
	 * 게시판 reload 비동기 처리 컨트롤러
	 * @author 최영철
	 * @since 2023. 7. 25.
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
    @PostMapping("/qryBoardList")
    @ResponseBody
    public Map<String, Object> qryReloadPageMethod(@RequestBody GetBoardVo insParam) {
    	
    	Map<String, Object> response = new HashMap<>();
        
        //작성된 총 게시글 가져오기
	    int totalCount = boardService.qryTotalCount(insParam);
	    
	    //메인화면 게시글 목록 가져오기
	    response.put("boardList", boardService.selectList(insParam));       
	    response.put("totalCount", totalCount);  
	    
	    //페이지 정보 가져오기( GetPageInfo(총 페이지 개수, 현재 페이지, 총 게시글 수))
	    response.put("pageInfo", boardService.GetPageInfo(insParam.getCurrentPage(), insParam.getAmount(), Long.valueOf(totalCount))); 

        return response;
    }
    
    
	/**
	 * 상세 설명  
	 * 게시글 등록 페이지 이동 컨트롤러
	 * @author 최영철
	 * @since 2023. 7. 25.
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
    @GetMapping("/join")
    public ModelAndView insRegisterMethod() {

        //데이터와 뷰를 동시에 설정이 가능
        ModelAndView mv = new ModelAndView();
        
        //return view
        mv.setViewName("/join");

        return mv;
    }
    
    
	/**
	 * 상세 설명
	 * 게시글 등록 aJax 컨트롤러
	 * @author 최영철
	 * @since 2023. 7. 25.
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
    @PostMapping("/writeProcess")
    @ResponseBody
    public Map<String, Object> insWritreContent(@AuthenticationPrincipal UserDetails user, BoardVo boardVo) {
    	
    	//현재 로그인중인 ID 작성자로 저장
    	boardVo.setWriter(user.getUsername());
    	
    	return boardService.insContent(boardVo);
    }
    
    
	/**
	 * 상세 설명
	 * 게시글 상세 aJax 컨트롤러
	 * @author 최영철
	 * @since 2023. 8. 1.
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
    @GetMapping("/detailProcess")
    @ResponseBody
    public Map<String, Object> qryDetailProcess(@AuthenticationPrincipal UserDetails user, @RequestParam String idx) {
    	
    	String username = "";
    	
    	//현재 로그인 된 사용자명 가져오기
    	if(user != null) {
    		username = user.getUsername();
    	}
    	
    	return boardService.qryDetail(username, idx);
    }
    
    
	/**
	 * 상세 설명
	 * 게시글 삭제 aJax 컨트롤러
	 * @author 최영철
	 * @since 2023. 8. 1.
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
    @GetMapping("/deleteProcess")
    @ResponseBody
    public Map<String, Object> qryDeleteProcess(@RequestParam String idx) {
    	
    	return boardService.qryDelete(idx);
    	
    }
    
    
	/**
	 * 상세 설명
	 * 게시글 수정 aJax 컨트롤러
	 * @author 최영철
	 * @since 2023. 8. 1.
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
    @PostMapping("/updateProcess")
    @ResponseBody
    public Map<String, Object> qryUpdateProcess(BoardVo boardVo) {
    	
    	return boardService.qryUpdate(boardVo);
    	
    }
    
    
    
	/**
	 * 상세 설명
	 * 파일업로드 aJax 컨트롤러
	 * @author 최영철
	 * @since 2023. 9. 7.
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
    @PostMapping("/fileUpload")
    @ResponseBody
    public int qryUpdateProcess(@RequestParam("boardNo") int boardNo, MultipartFile file) throws IOException {
    	
    	return boardService.fileUpload(file, boardNo);
    	
    }
    
    
	/**
	 * 상세 설명
	 * 파일 다운로드 aJax 컨트롤러
	 * @author 최영철
	 * @since 2023. 9. 9.
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
    // 첨부 파일 다운로드
    @GetMapping("/fileDownload")
    @ResponseBody
	public void downloadBoardFile(HttpServletResponse response, @RequestParam("boardNo") String fileIdx) throws Exception {
    	
    	//파일정보 가져오기
    	FileVo fileInfo = boardService.qryFileInfo(fileIdx);
    	
    	log.info("???????????????123123");
    	
		String fileName = fileInfo.getOrigin_name();
		
		byte[] files = FileUtils.readFileToByteArray(new File(fileInfo.getFile_path()));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(files.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8")+"\";");
		
		response.getOutputStream().write(files);
		response.getOutputStream().flush();
		response.getOutputStream().close();
		
	}
    
    
    
    /** 업로드 파일 삭제
     */
    @PostMapping("/removeFile")
    public ResponseEntity<Boolean> removeFile(String fileName){

        String srcFileName = null;
        
        String uploadPath = "";

        try{
        	
            srcFileName = URLDecoder.decode(fileName,"UTF-8");
            //UUID가 포함된 파일이름을 디코딩해줍니다.
            File file = new File(uploadPath +File.separator + srcFileName);
            boolean result = file.delete();

            File thumbnail = new File(file.getParent(),"s_"+file.getName());
            //getParent() - 현재 File 객체가 나태내는 파일의 디렉토리의 부모 디렉토리의 이름 을 String으로 리턴해준다.
            result = thumbnail.delete();
            return new ResponseEntity<>(result,HttpStatus.OK);
            
        }catch (UnsupportedEncodingException e){
        	
            e.printStackTrace();
            return new ResponseEntity<>(false,HttpStatus.INTERNAL_SERVER_ERROR);
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @GetMapping("/admin")
    @AdminAuthorize
    public ModelAndView adminSettingPage() {
    	
    	//@PreAuthorize API별로 권한 접근을 제어하는 어노테이션(시큐리티 제공)
    	//패키지Custom Annotation으로 커스텀으로 @AdminAuthorize , @UserAuthorize 지정
    	
    	log.info("운영자!!!!!!!");
    	
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/admin");
        
        return mv;
    }

    @GetMapping("/user")
    @UserAuthorize
    public ModelAndView userSettingPage() {
    	
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/user");
        
        log.info("유저!!!!!!!");
    	
        return mv;
    }
    
    
    
    

}
