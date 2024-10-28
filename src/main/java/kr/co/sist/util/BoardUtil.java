package kr.co.sist.util;

import kr.co.sist.user.board.SearchVO;

public class BoardUtil {
	private static String[] columName={"subject","content","writer"};
			
	
	public static String numToField(String fieldNum) {
		return columName[Integer.parseInt(fieldNum)];
	}
	
	/**
	 * 페이지 네이션을 사용하면 매개변수로 입력되는 객체의
	 * currentPage 번호, totalPage 수 , totalCount 수
	 * 검색을 수행하면 field 값, keyword, url이 반드시 입력되어야 합니다.
	 * @param sVO
	 * @return
	 */
	public String pagination(SearchVO sVO) {
		StringBuilder pagination=new StringBuilder();
	
		if(sVO.getTotalCount()!=0) {
			//1.한 화면에 보여줄 페이지 인덱스 수 [1][2][3]
			int pageNumber=3;
			//2.화면에 보여줄 시작페이지 번호
			int startPage=((sVO.getCurrentPage()-1)/pageNumber)*pageNumber+1;
			//3.화면에 보여줄 마지막 페이지 번호
			int endPage=startPage+pageNumber-1;
			//4.총페이지 수가 마지막 연산된 마지막 페이지 수보다 작다면 총 페이지 수가 마지막 페이지 수로 설정
			if(sVO.getTotalPage()<=endPage){
				endPage=sVO.getTotalPage();
			}
			//5.첫 페이지가 인덱스 화면이 아닌경우
			int movePage=0;
			StringBuilder prevMark=new StringBuilder();
			prevMark.append("[&lt;&lt; ]");
	
			if(sVO.getCurrentPage()>pageNumber){//현재 페이지가 pagination의 수 보다 크면
				prevMark.delete(0, prevMark.length());
				//이전으로 가기 링크를 만들어 준다.
	    		movePage=startPage-1;
	    		prevMark.append("[ <a href=\"")
	    		.append(sVO.getUrl())
	    		.append("?currentPage=")
	    		.append(movePage);
	    		//검색 키워드가 존재할 때
	    		if(sVO.getKeyword()!=null&& !"".equals(sVO.getKeyword())) {
	    			prevMark.append("&field=").append(sVO.getField())
	    			.append("&keyword=").append(sVO.getKeyword());
	    		}
	    		prevMark.append("\"> &lt;&lt;</a>]");
	    	}
			prevMark.append("...");
			
			pagination.append(prevMark);
			
			movePage=startPage;
			StringBuilder pageLink=new StringBuilder();
			
			while(movePage<=endPage){
				if(movePage==sVO.getCurrentPage()){//현재 페이지는 링크를 설정하지 않는다.
					pageLink.append("[").append(movePage).append("]");
				}else {//현재페이지가 아니면 링크를 설정한다.
					pageLink.append("[ <a href='")
					.append(sVO.getUrl())
					.append("?currentPage=")
					.append(movePage);
					
					//검색 키워드가 존재할 때
		    		if(sVO.getKeyword()!=null&& !"".equals(sVO.getKeyword())) {
		    			pageLink.append("&field=").append(sVO.getField())
		    			.append("&keyword=").append(sVO.getKeyword());
		    		}
					
					pageLink.append("'>")
					.append(movePage)
					.append("</a> ]");				
				}
				movePage++;
			}
			pagination.append(pageLink);
			pagination.append("...");
			
			//7. 뒤에 페이지가 더 있는 경우 [1][2][3] [4]
			StringBuilder nextMark=new StringBuilder();
			nextMark.append("[&gt;&gt;]");
			
			if(sVO.getTotalPage()> endPage){
				nextMark.delete(0, nextMark.length());
				movePage=endPage+1;
				nextMark.append("[ <a href='")
				.append(sVO.getUrl())
				.append("?currentPage=")
				.append(movePage);
				
				//검색 키워드가 존재할 때
	    		if(sVO.getKeyword()!=null&& !"".equals(sVO.getKeyword())) {
	    			nextMark.append("&field=").append(sVO.getField())
	    			.append("&keyword=").append(sVO.getKeyword());
	    		}
				
				nextMark.append("'>&gt;&gt;</a>]");
			}//end if
	    	
			pagination.append(nextMark);
		}//end if
		return pagination.toString();
	}
	
}
