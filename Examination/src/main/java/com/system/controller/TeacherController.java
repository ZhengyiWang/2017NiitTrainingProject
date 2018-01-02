package com.system.controller;

import com.system.exception.CustomException;
import com.system.po.*;
import com.system.service.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import java.util.List;


@Controller
@RequestMapping(value = "/teacher")
public class TeacherController {

    @Resource(name = "teacherServiceImpl")
    private TeacherService teacherService;

    @Resource(name = "studentServiceImpl")
    private StudentService studentService;

    @Resource(name = "courseServiceImpl")
    private CourseService courseService;

    @Resource(name = "selectedCourseServiceImpl")
    private SelectedCourseService selectedCourseService;

    @Resource(name = "noteServiceImpl")
    private NoteService noteService;

    @RequestMapping(value = "/")
    public String teacher() throws Exception {
        return "redirect:/teacher/showNote";
    }

    // 显示我的课程
    @RequestMapping(value = "/showCourse")
    public String stuCourseShow(Model model) throws Exception {

        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();

        List<CourseCustom> list = courseService.findByTeacherID(Integer.parseInt(username));
        model.addAttribute("courseList", list);
        model.addAttribute("noteCount", noteService.getCountNote());

        model.addAttribute("courseCount", courseService.getCourseCountByTeacherID(Integer.parseInt(username)));
        return "teacher/showCourse";
    }

    //搜索课程
    @RequestMapping(value = "searchCourse", method = {RequestMethod.POST})
    private String selectCourse(String findByName, Model model) throws Exception {
        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();
        findByName = findByName.trim();
        List<CourseCustom> list = courseService.findByTeacherIDAndName(Integer.parseInt(username), findByName);

        model.addAttribute("courseList", list);

        return "teacher/showCourse";
    }

    // 显示成绩
    @RequestMapping(value = "/gradeCourse")
    public String gradeCourse(Integer id, Model model) throws Exception {
        if (id == null) {
            return "";
        }
        List<SelectedCourseCustom> list = selectedCourseService.findByCourseID(id);
        model.addAttribute("selectedCourseList", list);

        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();
        model.addAttribute("noteCount", noteService.getCountNote());

        model.addAttribute("courseCount", courseService.getCourseCountByTeacherID(Integer.parseInt(username)));
        return "teacher/showGrade";
    }

    // 打分
    @RequestMapping(value = "/mark", method = {RequestMethod.GET})
    public String markUI(SelectedCourseCustom scc, Model model) throws Exception {

        SelectedCourseCustom selectedCourseCustom = selectedCourseService.findOne(scc);

        model.addAttribute("selectedCourse", selectedCourseCustom);

        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();
        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCourseCountByTeacherID(Integer.parseInt(username)));

        return "teacher/mark";
    }

    // 打分
    @RequestMapping(value = "/mark", method = {RequestMethod.POST})
    public String mark(SelectedCourseCustom scc) throws Exception {

        selectedCourseService.updataOne(scc);

        return "redirect:/teacher/gradeCourse?id="+scc.getCourseid();
    }

    //修改密码
    @RequestMapping(value = "/passwordRest")
    public String passwordRest(Model model) throws Exception {
        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();
        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCourseCountByTeacherID(Integer.parseInt(username)));

        return "teacher/passwordRest";
    }
    /*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<公告操作>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
    @RequestMapping("/showNote")
    public String showNote(Model model, Integer page) throws Exception {
        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();
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
        model.addAttribute("courseCount", courseService.getCourseCountByTeacherID(Integer.parseInt(username)));

        return "teacher/showNote";
    }

    @RequestMapping(value = "/selectNote", method = {RequestMethod.GET} )
    private String selectNote(Model model, Integer id) throws Exception {
        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();
        if (id == null) {
            return "redirect:/teacher/showNote";
        }
        List<TeacherCustom> list = teacherService.findAll();
        model.addAttribute("teacherList", list);

        Note note = noteService.findById(id);
        model.addAttribute("note", note);
        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCourseCountByTeacherID(Integer.parseInt(username)));

        return "teacher/selectNote";
    }

    @RequestMapping("/addNote")
    public String addNote(Model model) throws Exception {
        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();
        List<TeacherCustom> list = teacherService.findAll();
        model.addAttribute("teacherList", list);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("courseCount", courseService.getCourseCountByTeacherID(Integer.parseInt(username)));

        return "teacher/addNote";
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
        return "redirect:/teacher/showNote";
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
        return "teacher/showNote";
    }
}
