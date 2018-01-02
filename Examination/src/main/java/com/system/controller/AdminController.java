package com.system.controller;

import com.system.exception.CustomException;
import com.system.po.*;
import com.system.service.*;
import com.system.service.impl.CourseServiceImpl;
import com.system.service.impl.NoteServiceImpl;
import com.system.service.impl.StudentServiceImpl;
import com.system.service.impl.TeacherServiceImpl;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import java.util.List;


@Controller
@RequestMapping("/admin")
public class AdminController {

    @Resource(name = "studentServiceImpl")
    private StudentService studentService;

    @Resource(name = "teacherServiceImpl")
    private TeacherService teacherService;

    @Resource(name = "courseServiceImpl")
    private CourseService courseService;

    @Resource(name = "collegeServiceImpl")
    private CollegeService collegeService;

    @Resource(name = "userloginServiceImpl")
    private UserloginService userloginService;

    @Resource(name = "selectedCourseServiceImpl")
    private SelectedCourseService selectedCourseService;

    @Resource(name = "noteServiceImpl")
    private NoteService noteService;

    /*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<学生操作>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
    @RequestMapping("/")
    public String admin() throws Exception {
        return "redirect:/admin/showNote";
    }


    //  学生信息显示
    @RequestMapping("/showStudent")
    public String showStudent(Model model, Integer page) throws Exception {

        List<StudentCustom> list = null;
        //页码对象
        PagingVO pagingVO = new PagingVO();
        //设置总页数
        pagingVO.setTotalCount(studentService.getCountStudent());
        if (page == null || page == 0) {
            pagingVO.setToPageNo(1);
            list = studentService.findByPaging(1);
        } else {
            pagingVO.setToPageNo(page);
            list = studentService.findByPaging(page);
        }

        model.addAttribute("studentList", list);
        model.addAttribute("pagingVO", pagingVO);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());

        return "admin/showStudent";

    }

    //  添加学生信息页面显示
    @RequestMapping(value = "/addStudent", method = {RequestMethod.GET})
    public String addStudentUI(Model model) throws Exception {

        List<College> list = collegeService.finAll();

        model.addAttribute("collegeList", list);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());

        return "admin/addStudent";
    }

     // 添加学生信息操作
    @RequestMapping(value = "/addStudent", method = {RequestMethod.POST})
    public String addStudent(StudentCustom studentCustom, Model model) throws Exception {

        Boolean result = studentService.save(studentCustom);

        if (!result) {
            model.addAttribute("message", "学号重复");

            return "error";
        }
        //添加成功后，也添加到登录表
        Userlogin userlogin = new Userlogin();
        userlogin.setUsername(studentCustom.getUserid().toString());
        userlogin.setPassword("123");
        userlogin.setRole(2);
        userloginService.save(userlogin);

        //重定向
        return "redirect:/admin/showStudent";
    }

    // 修改学生信息页面显示
    @RequestMapping(value = "/editStudent", method = {RequestMethod.GET})
    public String editStudentUI(Integer id, Model model) throws Exception {
        if (id == null) {
            //加入没有带学生id就进来的话就返回学生显示页面
            return "redirect:/admin/showStudent";
        }
        StudentCustom studentCustom = studentService.findById(id);
        if (studentCustom == null) {
            throw new CustomException("未找到该名学生");
        }
        List<College> list = collegeService.finAll();

        model.addAttribute("collegeList", list);
        model.addAttribute("student", studentCustom);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());
        return "admin/editStudent";
    }

    // 修改学生信息处理
    @RequestMapping(value = "/editStudent", method = {RequestMethod.POST})
    public String editStudent(StudentCustom studentCustom) throws Exception {

        studentService.updataById(studentCustom.getUserid(), studentCustom);

        //重定向
        return "redirect:/admin/showStudent";
    }

    // 删除学生
    @RequestMapping(value = "/removeStudent", method = {RequestMethod.GET} )
    private String removeStudent(Integer id) throws Exception {
        if (id == null) {
            //加入没有带学生id就进来的话就返回学生显示页面

            return "redirect:/admin/showStudent";
        }
        studentService.removeById(id);
        userloginService.removeByName(id.toString());

        return "redirect:/admin/showStudent";
    }

    // 搜索学生
    @RequestMapping(value = "selectStudent", method = {RequestMethod.POST})
    private String selectStudent(String findByName, Model model) throws Exception {
        findByName = findByName.trim();
        List<StudentCustom> list = studentService.findByName(findByName);

        model.addAttribute("studentList", list);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());
        return "admin/showStudent";
    }

    /*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<教师操作>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/

    // 教师页面显示
    @RequestMapping("/showTeacher")
    public String showTeacher(Model model, Integer page) throws Exception {

        List<TeacherCustom> list = null;
        //页码对象
        PagingVO pagingVO = new PagingVO();
        //设置总页数
        pagingVO.setTotalCount(teacherService.getCountTeacher());
        if (page == null || page == 0) {
            pagingVO.setToPageNo(1);
            list = teacherService.findByPaging(1);
        } else {
            pagingVO.setToPageNo(page);
            list = teacherService.findByPaging(page);
        }

        model.addAttribute("teacherList", list);
        model.addAttribute("pagingVO", pagingVO);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());
        return "admin/showTeacher";

    }

    // 添加教师信息
    @RequestMapping(value = "/addTeacher", method = {RequestMethod.GET})
    public String addTeacherUI(Model model) throws Exception {

        List<College> list = collegeService.finAll();

        model.addAttribute("collegeList", list);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());
        return "admin/addTeacher";
    }

    // 添加教师信息处理
    @RequestMapping(value = "/addTeacher", method = {RequestMethod.POST})
    public String addTeacher(TeacherCustom teacherCustom, Model model) throws Exception {

        Boolean result = teacherService.save(teacherCustom);

        if (!result) {
            model.addAttribute("message", "工号重复");

            return "error";
        }
        //添加成功后，也添加到登录表
        Userlogin userlogin = new Userlogin();
        userlogin.setUsername(teacherCustom.getUserid().toString());
        userlogin.setPassword("123");
        userlogin.setRole(1);
        userloginService.save(userlogin);

        //重定向
        return "redirect:/admin/showTeacher";
    }

    // 修改教师信息页面显示
    @RequestMapping(value = "/editTeacher", method = {RequestMethod.GET})
    public String editTeacherUI(Integer id, Model model) throws Exception {
        if (id == null) {
            return "redirect:/admin/showTeacher";
        }
        TeacherCustom teacherCustom = teacherService.findById(id);
        if (teacherCustom == null) {
            throw new CustomException("未找到该名学生");
        }
        List<College> list = collegeService.finAll();

        model.addAttribute("collegeList", list);
        model.addAttribute("teacher", teacherCustom);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());
        return "admin/editTeacher";
    }

    // 修改教师信息页面处理
    @RequestMapping(value = "/editTeacher", method = {RequestMethod.POST})
    public String editTeacher(TeacherCustom teacherCustom) throws Exception {

        teacherService.updateById(teacherCustom.getUserid(), teacherCustom);

        //重定向
        return "redirect:/admin/showTeacher";
    }

    //删除教师
    @RequestMapping("/removeTeacher")
    public String removeTeacher(Integer id) throws Exception {
        if (id == null) {
            //加入没有带教师id就进来的话就返回教师显示页面
            return "redirect:/admin/showTeacher";
            //return "admin/showTeacher";
        }
        teacherService.removeById(id);
        userloginService.removeByName(id.toString());

        return "redirect:/admin/showTeacher";
    }

    //搜索教师
    @RequestMapping(value = "selectTeacher", method = {RequestMethod.POST})
    private String selectTeacher(String findByName, Model model) throws Exception {
        findByName = findByName.trim();
        List<TeacherCustom> list = teacherService.findByName(findByName);

        model.addAttribute("teacherList", list);
        return "admin/showTeacher";
    }

    /*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<课程操作>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/

    // 课程信息显示
    @RequestMapping("/showCourse")
    public String showCourse(Model model, Integer page) throws Exception {

        List<CourseCustom> list = null;
        //页码对象
        PagingVO pagingVO = new PagingVO();
        //设置总页数
        pagingVO.setTotalCount(courseService.getCountCouse());
        if (page == null || page == 0) {
            pagingVO.setToPageNo(1);
            list = courseService.findByPaging(1);
        } else {
            pagingVO.setToPageNo(page);
            list = courseService.findByPaging(page);
        }

        model.addAttribute("courseList", list);
        model.addAttribute("pagingVO", pagingVO);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());
        return "admin/showCourse";

    }

    //添加课程
    @RequestMapping(value = "/addCourse", method = {RequestMethod.GET})
    public String addCourseUI(Model model) throws Exception {

        List<TeacherCustom> list = teacherService.findAll();
        List<College> collegeList = collegeService.finAll();

        model.addAttribute("collegeList", collegeList);
        model.addAttribute("teacherList", list);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());
        return "admin/addCourse";
    }

    // 添加课程信息处理
    @RequestMapping(value = "/addCourse", method = {RequestMethod.POST})
    public String addCourse(CourseCustom courseCustom, Model model) throws Exception {

        Boolean result = courseService.save(courseCustom);

        if (!result) {
            model.addAttribute("message", "课程号重复");
            return "error";
        }


        //重定向
        return "redirect:/admin/showCourse";
    }

    // 修改教师信息页面显示
    @RequestMapping(value = "/editCourse", method = {RequestMethod.GET})
    public String editCourseUI(Integer id, Model model) throws Exception {
        if (id == null) {
            return "redirect:/admin/showCourse";
        }
        CourseCustom courseCustom = courseService.findById(id);
        if (courseCustom == null) {
            throw new CustomException("未找到该课程");
        }
        List<TeacherCustom> list = teacherService.findAll();
        List<College> collegeList = collegeService.finAll();

        model.addAttribute("teacherList", list);
        model.addAttribute("collegeList", collegeList);
        model.addAttribute("course", courseCustom);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());
        return "admin/editCourse";
    }

    // 修改教师信息页面处理
    @RequestMapping(value = "/editCourse", method = {RequestMethod.POST})
    public String editCourse(CourseCustom courseCustom) throws Exception {

        courseService.upadteById(courseCustom.getCourseid(), courseCustom);

        //重定向
        return "redirect:/admin/showCourse";
    }

    // 删除课程信息
    @RequestMapping("/removeCourse")
    public String removeCourse(Model model, Integer id) throws Exception {
        if (id == null) {
            //加入没有带教师id就进来的话就返回教师显示页面
            return "redirect:/admin/showCourse";
        }
        int count = selectedCourseService.countByCourseID(id);
        if(count != 0) {
            model.addAttribute("message", "已经有学生上了该课程，无法删除课程");
            return "error";
        }
        courseService.removeById(id);
        return "redirect:/admin/showCourse";
    }

    //搜索课程
    @RequestMapping(value = "selectCourse", method = {RequestMethod.POST})
    private String selectCourse(String findByName, Model model) throws Exception {
        findByName = findByName.trim();
        List<CourseCustom> list = courseService.findByName(findByName);

        model.addAttribute("courseList", list);

        return "admin/showCourse";
    }

    /*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<其他操作>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/

    // 普通用户账号密码重置
    @RequestMapping("/userPasswordRest")
    public String userPasswordRestUI(Model model) throws Exception {

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());
        return "admin/userPasswordRest";
    }

    // 普通用户账号密码重置处理
    @RequestMapping(value = "/userPasswordRest", method = {RequestMethod.POST})
    public String userPasswordRest(Userlogin userlogin) throws Exception {

        Userlogin u = userloginService.findByName(userlogin.getUsername());

        if (u != null) {
            if (u.getRole() == 0) {
                throw new CustomException("该账户为管理员账户，没法修改");
            }
            u.setPassword(userlogin.getPassword());
            userloginService.updateByName(userlogin.getUsername(), u);
        } else {
            throw new CustomException("没找到该用户");
        }

        return "admin/userPasswordRest";
    }

    // 本账户密码重置
    @RequestMapping("/passwordRest")
    public String passwordRestUI(Model model) throws Exception {

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());
        return "admin/passwordRest";
    }

    /*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<公告操作>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/

    @RequestMapping("/showNote")
    public String showNote(Model model, Integer page) throws Exception {
        List<Note> list = null;
        PagingVO pagingVO = new PagingVO();
        //设置总页数
        pagingVO.setTotalCount(noteService.getCountNote());
        if (page == null || page == 0) {
            pagingVO.setToPageNo(1);
            list = noteService.findByPaging(1);
        } else {
            pagingVO.setToPageNo(page);
            list = noteService.findByPaging(page);
        }

        model.addAttribute("noteList", list);
        model.addAttribute("pagingVO", pagingVO);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());

        return "admin/showNote";
    }

    @RequestMapping("/addNote")
    public String addNote(Model model) throws Exception {
        List<TeacherCustom> list = teacherService.findAll();
        model.addAttribute("teacherList", list);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());

        return "admin/addNote";
    }

    @RequestMapping(value = "/addNote", method = {RequestMethod.POST})
    public String addNote(Note note, Model model) throws Exception {
        note.setTeachername(teacherService.findById(note.getTeacherid()).getUsername());
        Boolean result = noteService.save(note);

        if (!result) {
            model.addAttribute("message", "公告号重复");

            return "error";
        }
        //重定向
        return "redirect:/admin/showNote";
    }

    @RequestMapping("/editNote")
    public String editNote(Model model, int id) throws Exception {
        List<TeacherCustom> list = teacherService.findAll();
        model.addAttribute("teacherList", list);
        Note note = noteService.findById(id);

        model.addAttribute("note", note);
        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());

        return "admin/editNote";
    }

    @RequestMapping(value="/editNote", method = {RequestMethod.POST})
    public String editNote(Model model, Note note) throws Exception {
        note.setTeachername(teacherService.findById(note.getTeacherid()).getUsername());
        noteService.updataById(note.getNoteid(), note);
        return "redirect:/admin/showNote";
    }

    @RequestMapping(value = "/removeNote", method = {RequestMethod.GET} )
    private String removeNote(Integer id) throws Exception {
        if (id == null) {
            return "redirect:/admin/showNote";
        }
        noteService.removeById(id);

        return "redirect:/admin/showNote";
    }

    @RequestMapping(value = "/selectNote", method = {RequestMethod.GET} )
    private String selectNote(Model model, Integer id) throws Exception {
        if (id == null) {
            return "redirect:/admin/showNote";
        }
        List<TeacherCustom> list = teacherService.findAll();
        model.addAttribute("teacherList", list);

        Note note = noteService.findById(id);
        model.addAttribute("note", note);
        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());

        return "admin/selectNote";
    }
    // 搜索公告
    @RequestMapping(value = "/searchNote", method = {RequestMethod.POST})
    private String searchNote(String findByName, Model model) throws Exception {
        findByName = findByName.trim();
        List<Note> list = noteService.findByName(findByName);

        model.addAttribute("noteList", list);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("studentCount", studentService.getCountStudent());
        model.addAttribute("teacherCount", teacherService.getCountTeacher());
        return "admin/showNote";
    }
}
