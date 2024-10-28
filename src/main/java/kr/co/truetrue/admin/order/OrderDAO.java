package kr.co.truetrue.admin.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;

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
	
	public void selectAllOrder()throws SQLException{
		OrderVO oVO=new OrderVO();
		List<OrderVO> list= new ArrayList<OrderVO>();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			//3.Connection 얻기
				con=dbCon.getConn();
			//4.쿼리문생성객체 얻기
				
				StringBuilder selectOrder=new StringBuilder();
				selectOrder
				.append("select order_id, payment_date, total_price, zipcode,"
						+ "address, address_detail, delivery_status ");
				
				pstmt=con.prepareStatement(selectOrder.toString());
			//5.바인드 변수에 값 설정				
			//6.쿼리문 수행 후 결과 얻기
				rs=pstmt.executeQuery();
				if(rs.next()) {
					oVO.setOrder_id(rs.getInt("order_id"));
					oVO.setPayment_date(rs.getString("payment_date"));
					oVO.setTotal_price(rs.getInt("total_price"));
					oVO.setZip_code(rs.getString("zipcode"));
					oVO.setAddress(rs.getString("address"));
					oVO.setAddress_detail(rs.getString("address_detail"));
					oVO.setDelivery_status(rs.getString("delivery_status"));
				}
				
			}finally {
				//7.연결 끊기			
				dbCon.dbClose(rs, pstmt, con);
			}
	}
	
	public String selectUserId(int cartId)throws SQLException{
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			//3.Connection 얻기
				con=dbCon.getConn();
			//4.쿼리문생성객체 얻기
				
				StringBuilder userId=new StringBuilder();
				userId
				.append("	select 	user_id")
				.append("	from 	cart_product  ")
				.append("	where	 ");
				
				
			//5.바인드 변수에 값 설정
			//6.쿼리문 수행 후 결과 얻기
				
			}finally {
				//7.연결 끊기			
				dbCon.dbClose(rs, pstmt, con);
			}
		return "";
	}
}
