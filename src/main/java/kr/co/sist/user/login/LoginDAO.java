package kr.co.sist.user.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.sist.dao.DbConnection;
import kr.co.sist.user.mamber.WebMemberVO;

public class LoginDAO {
	
	private static LoginDAO lDAO;
	
	private LoginDAO() {
		
	}
	
	public static LoginDAO getInstance() {
		if(lDAO==null) {
			lDAO=new LoginDAO();
		}
		return lDAO;
	}
	/**
	 * 자바의 객체는 하나이므로 입력된 객체에 값을 넣으면 저장된 값을 호출한 곳에서
	 * getter를 호출하여 사용할 수 있다.
	 * @param wmVO-
	 * @return
	 */
	public void selectLogin(WebMemberVO wmVO)throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		//1.JNDI 사용객체 생성
		//2.DBCP에서 DataSource 얻기
		DbConnection dbCon=DbConnection.getInstance();
		try {
		//3.Connection얻기
			con=dbCon.getConn();
		//4.쿼리문 생성객체 얻기
			StringBuilder select=new StringBuilder()
					.append("	select name,tel,zipcode,addr,addr2")
					.append("	from	web_member")
					.append("	where	id=? and pass=?");
			
			pstmt=con.prepareStatement(select.toString());
					
		//5.바인드 변수에 값 설정
			pstmt.setString(1, wmVO.getId());
			pstmt.setString(2, wmVO.getPass());
		//6.쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			if(rs.next()) {
				wmVO.setName(rs.getString("name"));
				wmVO.setCellphone(rs.getString("tel"));
				wmVO.setZipcode(rs.getString("zipcode"));
				wmVO.setAddr1(rs.getString("addr"));
				wmVO.setAddr2(rs.getString("addr2"));
			}
		}finally {
			//7.연결 끊기
			dbCon.dbClose(rs, pstmt, con);
		}
		
	}
}
