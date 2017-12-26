package cn.qdu.edu_admin.admin.student.service;

import java.util.Date;
import java.util.List;

import cn.qdu.edu_admin.domain.ScoreResult;
import cn.qdu.edu_admin.domain.Student;
import cn.qdu.edu_admin.admin.student.dao.StudentDao;
import cn.qdu.edu_admin.util.GenericUtil;

/**
 * 学生Service: 处理Student的逻辑业务
 */
public class StudentService {
	private StudentDao dao = new StudentDao();
	
	public Student login(Student student) {		
		String password = GenericUtil.encrypt(student.getStudentNum(), student.getPassword());		
		student.setPassword(password);
		
		return dao.login(student);
	}

	public boolean isExistApplyType(String studentNum, int parseInt) {
		return dao.isExistApplyType(studentNum, parseInt);
	}

	public String getExistFileName(String studentNum, int parseInt) {
		return dao.getExistFileName(studentNum,parseInt);
	}

	public boolean addApplyToDB(String id,String applyWordFileName,
			Date date,String newFileName, String studentNum, int parseInt) {
		return dao.addApplyToDB(id,applyWordFileName,
				date,newFileName,studentNum,parseInt);
	}

	public boolean updateApplyInfo(String applyWordFileName, Date date,String studentNum,int applyType) {
		return dao.updateApplyInfo(applyWordFileName,date,studentNum,applyType);
	}

	public List<Student> queryPermission(int i) {
		return dao.queryPermission(i);
	}

	public void addApplyToApplyinfo(String studentNum, String id, int parseInt,
			int classId, String studentName) {
		dao.addApplyToApplyinfo(studentNum, id, parseInt, classId, studentName);
		
	}

	public void addPointsToPoor(String string, Integer integer,String string2) {
		dao.addPointsToPoor(string,integer,string2);
		
	}

	public Student queryStudentByStudentNum(String studentnum){
		return dao.queryStudentByStudentNum(studentnum);
	}

	public void addstudentToFamily(Student student, String householdType,
			int homenumber, int everybodyGet, String comment) {
		dao.addstudentToFamily(student,householdType,homenumber,
				everybodyGet,comment);
	}

	public void addstudentToLoanmoney(Student student, int loansmoney) {
		dao.addstudentToLoanmoney(student,loansmoney);
	}

	public void addstudentTojobtemp(Student student, int salary,
			String workpalce) {
		dao.addstudentTojobtemp(student,salary,workpalce);
	}

	public String getStudentClassName(int classId) {
		return dao.getStudentClassName(classId);
	}
	
}
