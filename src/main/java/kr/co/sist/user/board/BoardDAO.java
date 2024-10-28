package kr.co.sist.user.board;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;
import kr.co.sist.util.BoardUtil;

/**
 * 게시판의 리스트, 상세조회, 추가, 삭제, 변경 업무
 */
public class BoardDAO {
private static BoardDAO bDAO;
	
	private BoardDAO() {
		
	}
	
	public static BoardDAO getInstance() {
		if(bDAO==null) {
			bDAO=new BoardDAO();
		}
		return bDAO;
	}
	
	/**
	 * 총 게시물의 수 검색
	 * @param sVO
	 * @return
	 * @throws SQLException
	 */
	public int selectTotalCount(SearchVO sVO)throws SQLException{
		int totalCount=0;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		//1.JNDI사용객체 생성
		//2.DBCP에서 DataSource 얻기
		
		try {
		//3.Connection 얻기
			con=dbCon.getConn();
		//4.쿼리문생성객체 얻기
			StringBuilder selectCount=new StringBuilder();
			selectCount
			.append("select count(num) cnt from board");
			
			//dynamic query : 검색 키워드를 판단 기준으로 where절이 동적 생성되어야 한다.
			if(sVO.getKeyword()!=null&&!"".equals(sVO.getKeyword())) {
				selectCount.
				append(" where instr( ")
				.append(BoardUtil.numToField(sVO.getField()))
				.append(" ,?) !=0  ");
			}
			
			pstmt=con.prepareStatement(selectCount.toString());
		//5.바인드 변수에 값 설정
			if(sVO.getKeyword()!=null&&!"".equals(sVO.getKeyword())) {
				pstmt.setString(1, sVO.getKeyword());
			}
		//6.쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			if(rs.next()) {
				totalCount=rs.getInt("cnt");
			}
		}finally {
			//7.연결 끊기			
			dbCon.dbClose(rs, pstmt, con);
		}
		
		return totalCount;
	}
	
	public List<BoardVO> selectBoard(SearchVO sVO)throws SQLException{
		List<BoardVO> list=new ArrayList<BoardVO>();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			con=dbCon.getConn();
			
			StringBuilder selectBoard=new StringBuilder();
			selectBoard
			.append("	select NUM, SUBJECT, WRITER, INPUT_DATE, IP	")
			.append("	FROM(select NUM, SUBJECT, WRITER, INPUT_DATE, IP,	")
			.append("	row_number() over(order by input_date desc) rnum	")
			.append("	from board	");
			
			//dynamic query : 검색 키워드를 판단 기준으로 where절이 동적 생성되어야 한다.
			if(sVO.getKeyword()!=null&&!"".equals(sVO.getKeyword())) {
				selectBoard.
				append(" where instr( ")
				.append(BoardUtil.numToField(sVO.getField()))
				.append(" ,?) !=0  ");
			}
			
			selectBoard.append("	)where rnum between ? and ?	");
			
			System.out.println(selectBoard);
			pstmt=con.prepareStatement(selectBoard.toString());
			int bindInd=0;
			if(sVO.getKeyword()!=null&&!"".equals(sVO.getKeyword())) {
				pstmt.setString(++bindInd, sVO.getKeyword());
			}
			
			pstmt.setInt(++bindInd, sVO.getStartNum());
			pstmt.setInt(++bindInd, sVO.getEndNum());
			
			
			//쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			BoardVO bVO=null;
			while(rs.next()) {
				bVO=new BoardVO();
				bVO.setNum(rs.getInt("num"));
				bVO.setSubject(rs.getString("subject"));
				bVO.setWriter(rs.getString("writer"));
				bVO.setInput_date(rs.getDate("input_date"));
				bVO.setIp(rs.getString("ip"));
				
				list.add(bVO);
			}
			
		}finally {
			dbCon.dbClose(rs, pstmt, con);
		}
		
		return list;
	}
	
	/**
	 * 입력 값을 board 테이블에 추가하는 일
	 * @param bVO
	 * @throws SQLException
	 */
	public void insertBoard(BoardVO bVO) throws SQLException{
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			con=dbCon.getConn();
			
			StringBuilder insertBoard=new StringBuilder();
			insertBoard
			.append("	insert into board(num,subject,content,writer,ip)	")
			.append("	values(seq_board.nextval,?,?,?,?)	")
			;
			
			
			pstmt=con.prepareStatement(insertBoard.toString());
			
			pstmt.setString(1, bVO.getSubject());
			pstmt.setString(2, bVO.getContent());
			pstmt.setString(3, bVO.getWriter());
			pstmt.setString(4, bVO.getIp());
			
			//쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();
			
		}finally {
			dbCon.dbClose(null, pstmt, con);
		}
		
	}//inserBoard
	
	/**
	 * 입력된 글번호에 해당하는 글 하나 조회
	 * @param num
	 * @return
	 * @throws SQLException
	 */
	public BoardVO selectDetailBoard(int num)throws SQLException{
		BoardVO bVO=null;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			con=dbCon.getConn();
			
			StringBuilder selectOneBoard=new StringBuilder();
			selectOneBoard
			.append("	select num, SUBJECT,content, WRITER, INPUT_DATE, IP	")
			.append("	FROM board ")
			.append("	where num=?	")
			;
			pstmt=con.prepareStatement(selectOneBoard.toString());
			
			pstmt.setInt(1, num);
			
			//쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				bVO=new BoardVO();
				bVO.setNum(num);
				bVO.setSubject(rs.getString("subject"));
				bVO.setWriter(rs.getString("writer"));
				bVO.setInput_date(rs.getDate("input_date"));
				bVO.setIp(rs.getString("ip"));
				
				//CLOB데이터를 읽어들이기 위해서 별도의 stream을 연결한다.
				BufferedReader br=new BufferedReader(
						rs.getClob("content").getCharacterStream());
				
				StringBuilder content=new StringBuilder();
				String temp;//한줄 읽어들인 데이터를 저장할 변수
				try {
					while((temp=br.readLine())!=null) {	
						content.append(temp).append("\n");
				}
					//모든 줄을 읽어들여 저장한 변수를 BoardVO객체에 할당한다.
					bVO.setContent(content.toString());
				}catch (IOException ie) {
				}
			}
			
		}finally {
			dbCon.dbClose(rs, pstmt, con);
		}
		
		return bVO;
	}
	
	/**
	 * 글 번호와 아이디에 해당하는 글의 내용을 변경
	 * @param bVO
	 * @return
	 * @throws SQLException
	 */
	public int updateBoard(BoardVO bVO)throws SQLException{
		int rowCnt=0;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			con=dbCon.getConn();
			
			StringBuilder updateBoard=new StringBuilder();
			updateBoard
			.append("	update	board")
			.append("	set	content=?")
			.append("	where	num=? and writer=?")
			;
			
			
			pstmt=con.prepareStatement(updateBoard.toString());
			
			pstmt.setString(1, bVO.getContent());
			pstmt.setInt(2, bVO.getNum());
			pstmt.setString(3, bVO.getWriter());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt=pstmt.executeUpdate();
			
		}finally {
			dbCon.dbClose(null, pstmt, con);
		}
		
		
		
		return rowCnt;
	}
	
	public int deleteBoard(BoardVO bVO)throws SQLException{
		int rowCnt=0;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			con=dbCon.getConn();
			
			StringBuilder deleteBoard=new StringBuilder();
			deleteBoard
			.append("	delete from	board ")
			.append("	where	num=? and writer=?")
			;
			
			
			pstmt=con.prepareStatement(deleteBoard.toString());
			
			pstmt.setInt(1, bVO.getNum());
			pstmt.setString(2, bVO.getWriter());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt=pstmt.executeUpdate();
			
		}finally {
			dbCon.dbClose(null, pstmt, con);
		}
		
		
		
		return rowCnt;
	}
	
}//class