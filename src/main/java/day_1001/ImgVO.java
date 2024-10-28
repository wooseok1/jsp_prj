package day_1001;

public class ImgVO {
	private String img;
	private String info;
	
	public ImgVO(String img, String info) {
		this.img = img;
		this.info = info;
	}
	public ImgVO() {
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	@Override
	
	public String toString() {
		return "ImgVO [img=" + img + ", info=" + info + "]";
	}
	
}
