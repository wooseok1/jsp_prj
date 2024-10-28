package kr.co.truetrue.admin.order;

public class OrderVO {
	private int order_id, cart_product_id,total_price;
	private String user_id, payment_date,  zip_code,
	address, address_detail, delivery_status;
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getCart_product_id() {
		return cart_product_id;
	}
	public void setCart_product_id(int cart_product_id) {
		this.cart_product_id = cart_product_id;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}
	public String getZip_code() {
		return zip_code;
	}
	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress_detail() {
		return address_detail;
	}
	public void setAddress_detail(String address_detail) {
		this.address_detail = address_detail;
	}
	public String getDelivery_status() {
		return delivery_status;
	}
	public void setDelivery_status(String delivery_status) {
		this.delivery_status = delivery_status;
	}
	@Override
	public String toString() {
		return "OrderVO [order_id=" + order_id + ", cart_product_id=" + cart_product_id + ", total_price=" + total_price
				+ ", user_id=" + user_id + ", payment_date=" + payment_date + ", zip_code=" + zip_code + ", address="
				+ address + ", address_detail=" + address_detail + ", delivery_status=" + delivery_status + "]";
	}
	
	
	
	
}
