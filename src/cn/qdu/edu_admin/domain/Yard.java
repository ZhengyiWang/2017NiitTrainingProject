package cn.qdu.edu_admin.domain;

import java.io.Serializable;

/**
 * 区域
 */
@SuppressWarnings("serial")
public class Yard implements Serializable{
	// 区域Id
	private int yardId;
	// 区域名称
	private String yardName;
	// 区域管理员
	private String manager;
	// 联系电话
	private String tel;

	/**
	 * 区域Id
	 */
	public int getYardId() {
		return yardId;
	}
	/**
	 * 区域Id
	 */
	public void setYardId(int yardId) {
		this.yardId = yardId;
	}

	/**
	 * 区域名称
	 */
	public String getYardName() {
		return yardName;
	}
	/**
	 * 区域名称
	 */
	public void setYardName(String yardName) {
		this.yardName = yardName;
	}

	/**
	 * 区域管理员
	 */
	public String getManager() {
		return manager;
	}
	/**
	 * 区域管理员
	 */
	public void setManager(String manager) {
		this.manager = manager;
	}

	/**
	 * 联系电话
	 */
	public String getTel() {
		return tel;
	}
	/**
	 * 联系电话
	 */
	public void setTel(String tel) {
		this.tel = tel;
	}

}