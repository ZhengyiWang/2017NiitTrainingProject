package cn.qdu.edu_admin.domain;
/**
 * 学生简略信息
 * @author ZheTang
 * @date 2015-6-13
 *
 */
public class StudentVo {
	private String studentNum;//学号
	private String studentName;//姓名
	private String className;//班级
	private String  sex;//性别
	private String phoneNum;//手机号
	private String dormitory;//宿舍
	
	public StudentVo() {
		super();
	}
	public StudentVo(String studentNum, String studentName, String className,
			String sex, String phoneNum, String dormitory) {
		super();
		this.studentNum = studentNum;
		this.studentName = studentName;
		this.className = className;
		this.sex = sex;
		this.phoneNum = phoneNum;
		this.dormitory = dormitory;
	}
	public String getStudentNum() {
		return studentNum;
	}
	public void setStudentNum(String studentNum) {
		this.studentNum = studentNum;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getDormitory() {
		return dormitory;
	}
	public void setDormitory(String dormitory) {
		this.dormitory = dormitory;
	}

	@Override
	public String toString() {
		return "studentVo [studentNum=" + studentNum + ", studentName="
				+ studentName + ", className=" + className + ", sex=" + sex
				+ ", phoneNum=" + phoneNum + ", dormitory=" + dormitory + "]";
	}
	
}
