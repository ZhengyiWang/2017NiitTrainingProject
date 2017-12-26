package cn.qdu.edu_admin.admin.base.service;

import java.util.List;

import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.qdu.edu_admin.admin.base.dao.ClassDao;
import cn.qdu.edu_admin.domain.Class;

/**
 * 班级Service: 处理Class的业务逻辑
 */
 
public class ClassService {
	private ClassDao dao = ClassDao.getClassDaoInstance();
	
	public List<Class> listClassByMajorId(int majorId){
		return dao.listClassByMajorId(majorId);
	}
	
	public String add(Class grade){
		int result = dao.add(grade);
		if(result == 1)
			return "success";
		else
			return "添加班级信息失败！请稍后重试！";
	}
	
	public String update(Class class1){
		int result = dao.update(class1);
		if(result == 1)
			return "success";
		else
			return "更新班级信息失败！请稍后重试！";
	}
	
	public String delete(int classId){
		int result = dao.delete(classId);
		if(result == 1)
			return "success";
		else
			return "删除班级信息失败！请稍后重试！";
	}
	
	public Class getClassByClassId(int classId){
		return dao.getClassByClassId(classId);
	}
	public Class getClassByClassName(String className){
		return dao.getClassByClassName(className);
	}
	
	/**
	 * 判断班级名称是否存在数据库中
	 * 如果存在,返回1，不存在返回0；
	 */
	public int isExistClassName(String className){
		
		return dao.isExistClassName(className);
	}
}
