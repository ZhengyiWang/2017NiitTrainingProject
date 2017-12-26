package cn.qdu.edu_admin.admin.base.dao;


import java.util.List;

import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.qdu.edu_admin.domain.Major;
import cn.qdu.edu_admin.util.DatabaseUtil;
import cn.qdu.edu_admin.util.MyQueryRunner;

/**
 * @描述:Major的数据库操作
 */
public class MajorDao {
	private MyQueryRunner runner = new MyQueryRunner(DatabaseUtil.getDataSource());
	
	/*创建类的实体,保证在同一线程中运作*/
	private MajorDao(){}
	private static ThreadLocal<MajorDao> map = new ThreadLocal<MajorDao>();
	//这里值得学习，保证同一个线程运行。
	public static MajorDao getMajorDaoInstance(){
		MajorDao instance = map.get();
		if(instance == null){
			instance = new MajorDao();
			map.set(instance);
		}
		return instance;
	}
	
	/**
	 * 查询某个学院下的所有专业
	 * @param academyId 学院Id
	 * @return List<Major>
	 */
	public List<Major> listMajorByAcademyId(Integer academyId){
		
		String sql = " SELECT * " + " FROM major " + " WHERE academyId = ? ";
		List<Major> list = runner.query(sql, new BeanListHandler<Major>(Major.class), academyId);
		return list;
	}
	
	/**
	 * 添加专业信息
	 * @param major 专业实体
	 * @return 受影响行数
	 */
	public int add(Major major){
		String sql = "INSERT INTO major" + "(academyId,majorName,counselor,tel)" +
				     "VALUES(?,?,?,?)";
		int result = runner.update(sql, major.getAcademyId(),major.getMajorName(),major.getCounselor(),major.getTel());	
		return result;
	}
	
	/**
	 * 修改专业信息
	 * @param major 专业实体
	 * @return 受影响行数
	 */
	public int update(Major major){
		String sql = "UPDATE major SET " + "majorName=?,counselor=?,tel=? " + "WHERE majorId =?";
		int result =runner.update(sql, major.getMajorName(),major.getCounselor(),major.getTel(),major.getMajorId());
		return result;
	}
	
	/**
	 * 删除专业信息
	 * @param major 专业实体
	 * @return 受影响行数
	 */
	public int delete(int major){
		String sql = "DELETE FROM  major WHERE majorId = ?";
		int result = runner.update(sql,major);
		return result;
	}
	/**
	 * 根据id查找到major对象
	 * @param majorId
	 * @return
	 */
	public Major queryMajorById(int majorId){
		String sql = " SELECT * " +
			     " FROM major " +
			     " WHERE majorId = ? ";
		return runner.query(sql,new BeanHandler<Major>(Major.class),majorId);
	}
	
	/**
	 * 判断专业名称是否存在数据库中
	 * 如果存在,返回1，不存在返回0；
	 */
	public int isExistMajorName(String majorName){
		String sql = "select majorName from major Where majorName=? LIMIT 0,1";
		Object result = runner.query(sql,new ScalarHandler(), majorName);
		  if(result==null){
		    	return 0;
		    }
		return 1;
	}
}












