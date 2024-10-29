package kr.co.truetrue.admin.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;
import kr.co.sist.user.board.SearchVO;

public class OrderDAO {
	private static OrderDAO oDAO;
	
	private OrderDAO() {
		
	}
	
	public static OrderDAO getInstance() {
		if(oDAO==null) {
			oDAO=new OrderDAO();
		}
		return oDAO;
	}
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
			.append("select count(order_id) cnt from orders");
			
			pstmt=con.prepareStatement(selectCount.toString());
			//5.바인드 변수에 값 설정

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
	
	
	public List<OrderVO> selectAllOrder() throws SQLException {
	    List<OrderVO> list = new ArrayList<OrderVO>();

	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    DbConnection dbCon = DbConnection.getInstance();

	    try {
	        con = dbCon.getConn();

	        StringBuilder selectOrder = new StringBuilder();
	        selectOrder
	            .append(" SELECT ")
	            .append(" o.order_id, ")
	            .append(" cp.user_id, ")
	            .append(" TO_CHAR(o.payment_date, 'YYYY-MM-DD') AS payment_date, ")
	            .append(" o.total_price, ")
	            .append(" o.zip_code || ' ' || o.address || ' ' || o.address_detail AS address, ")
	            .append(" CASE ")
	            .append("     WHEN o.delivery_status = 'P' THEN '주문 확인' ")
	            .append("     WHEN o.delivery_status = 'S' THEN '배송중' ")
	            .append("     WHEN o.delivery_status = 'C' THEN '배송완료' ")
	            .append("     WHEN o.delivery_status = 'X' THEN '배송취소' ")
	            .append(" END AS delivery_status ")
	            .append(" FROM ")
	            .append(" orders o ")
	            .append(" JOIN ")
	            .append(" cart_product cp ON o.cart_product_id = cp.cart_product_id ")
	            .append(" WHERE ")
	            .append(" o.payment_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') ")
	            .append(" AND TO_DATE('2024-12-31', 'YYYY-MM-DD') ")
	            .append(" ORDER BY ")
	            .append(" o.payment_date DESC ");

	        pstmt = con.prepareStatement(selectOrder.toString());
	        rs = pstmt.executeQuery();

	        while(rs.next()) {
	            OrderVO oVO = new OrderVO();
	            oVO.setOrder_id(rs.getInt("order_id"));
	            oVO.setUser_id(rs.getString("user_id"));
	            oVO.setPayment_date(rs.getString("payment_date"));
	            oVO.setTotal_price(rs.getInt("total_price"));
	            oVO.setAddress(rs.getString("address"));
	            oVO.setDelivery_status(rs.getString("delivery_status"));
	            list.add(oVO);
	        }

	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }

	    return list;
	}
	
}
