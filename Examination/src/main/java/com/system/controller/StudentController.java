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
@RequestMapping(value = "/student")
public class StudentController {

    @Resource(name = "teacherServiceImpl")
    private TeacherService teacherService;

    @Resource(name = "courseServiceImpl")
    private CourseService courseService;

    @Resource(name = "studentServiceImpl")
    private StudentService studentService;

    @Resource(name = "selectedCourseServiceImpl")
    private SelectedCourseService selectedCourseService;

    @Resource(name = "noteServiceImpl")
    private NoteService noteService;

    @RequestMapping(value = "/")
    public String student() throws Exception {
        return "redirect:/student/showNote";
    }

    @RequestMapping(value = "/showCourse")
    public String stuCourseShow(Model model, Integer page) throws Exception {

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

        //获取已选课程数和已修课程数
        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();
        List<Selectedcourse> selectedCourses = selectedCourseService.findByStudentID(Integer.parseInt(username));
        int selectedCourseCount = 0, finishedCourseCount = 0;
        if(selectedCourses != null) {
            for(Selectedcourse tmp : selectedCourses) {
                if(tmp.getMark() == null) {
                    selectedCourseCount++;
                } else {
                    finishedCourseCount++;
                }
            }
        }
        model.addAttribute("selectedCourseCount", selectedCourseCount);
        model.addAttribute("finishedCourseCount", finishedCourseCount);
        model.addAttribute("courseCount", courseService.getCountCouse());

        model.addAttribute("courseList", list);
        model.addAttribute("pagingVO", pagingVO);

        model.addAttribute("noteCount", noteService.getCountNote());
        return "student/showCourse";
    }

    // 选课操作
    @RequestMapping(value = "/stuSelectedCourse")
    public String stuSelectedCourse(int id) throws Exception {
        //获取当前用户名
        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();

        SelectedCourseCustom selectedCourseCustom = new SelectedCourseCustom();
        selectedCourseCustom.setCourseid(id);
        selectedCourseCustom.setStudentid(Integer.parseInt(username));

        SelectedCourseCustom s = selectedCourseService.findOne(selectedCourseCustom);

        if (s == null) {
            selectedCourseService.save(selectedCourseCustom);
        } else {
            throw new CustomException("该门课程你已经选了，不能再选");
        }

        return "redirect:/student/selectedCourse";
    }

    // 退课操作
    @RequestMapping(value = "/outCourse")
    public String outCourse(int id) throws Exception {
        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();

        SelectedCourseCustom selectedCourseCustom = new SelectedCourseCustom();
        selectedCourseCustom.setCourseid(id);
        selectedCourseCustom.setStudentid(Integer.parseInt(username));

        selectedCourseService.remove(selectedCourseCustom);

        return "redirect:/student/selectedCourse";
    }

    // 已选课程
    @RequestMapping(value = "/selectedCourse")
    public String selectedCourse(Model model) throws Exception {
        //获取当前用户名
        Subject subject = SecurityUtils.getSubject();
        StudentCustom studentCustom = studentService.findStudentAndSelectCourseListByName((String) subject.getPrincipal());

        List<SelectedCourseCustom> list = studentCustom.getSelectedCourseList();

        model.addAttribute("selectedCourseList", list);

        //获取已选课程数和已修课程数
        String username = (String)subject.getPrincipal();
        List<Selectedcourse> selectedCourses = selectedCourseService.findByStudentID(Integer.parseInt(username));
        int selectedCourseCount = 0, finishedCourseCount = 0;
        if(selectedCourses != null) {
            for(Selectedcourse tmp : selectedCourses) {
                if(tmp.getMark() == null) {
                    selectedCourseCount++;
                } else {
                    finishedCourseCount++;
                }
            }
        }
        model.addAttribute("selectedCourseCount", selectedCourseCount);
        model.addAttribute("finishedCourseCount", finishedCourseCount);
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("noteCount", noteService.getCountNote());

        return "student/selectCourse";
    }

    // 已修课程
    @RequestMapping(value = "/overCourse")
    public String overCourse(Model model) throws Exception {

        //获取当前用户名
        Subject subject = SecurityUtils.getSubject();
        StudentCustom studentCustom = studentService.findStudentAndSelectCourseListByName((String) subject.getPrincipal());

        List<SelectedCourseCustom> list = studentCustom.getSelectedCourseList();

        model.addAttribute("selectedCourseList", list);

        //获取已选课程数和已修课程数
        String username = (String) subject.getPrincipal();
        List<Selectedcourse> selectedCourses = selectedCourseService.findByStudentID(Integer.parseInt(username));
        int selectedCourseCount = 0, finishedCourseCount = 0;
        if(selectedCourses != null) {
            for(Selectedcourse tmp : selectedCourses) {
                if(tmp.getMark() == null) {
                    selectedCourseCount++;
                } else {
                    finishedCourseCount++;
                }
            }
        }
        model.addAttribute("selectedCourseCount", selectedCourseCount);
        model.addAttribute("finishedCourseCount", finishedCourseCount);
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("noteCount", noteService.getCountNote());

        return "student/overCourse";
    }

    @RequestMapping(value = "selectCourse", method = {RequestMethod.POST})
    private String selectCourse(String findByName, Model model) throws Exception {
        findByName = findByName.trim();
        List<CourseCustom> list = courseService.findByName(findByName);

        model.addAttribute("courseList", list);

        return "student/showCourse";
    }
    //修改密码
    @RequestMapping(value = "/passwordRest")
    public String passwordRest(Model model) throws Exception {

        //获取已选课程数和已修课程数
        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();
        List<Selectedcourse> selectedCourses = selectedCourseService.findByStudentID(Integer.parseInt(username));
        int selectedCourseCount = 0, finishedCourseCount = 0;
        if(selectedCourses != null) {
            for(Selectedcourse tmp : selectedCourses) {
                if(tmp.getMark() == null) {
                    selectedCourseCount++;
                } else {
                    finishedCourseCount++;
                }
            }
        }
        model.addAttribute("selectedCourseCount", selectedCourseCount);
        model.addAttribute("finishedCourseCount", finishedCourseCount);
        model.addAttribute("courseCount", courseService.getCountCouse());
        model.addAttribute("noteCount", noteService.getCountNote());

        return "student/passwordRest";
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
        //获取已选课程数和已修课程数
        Subject subject = SecurityUtils.getSubject();
        String username = (String)subject.getPrincipal();
        List<Selectedcourse> selectedCourses = selectedCourseService.findByStudentID(Integer.parseInt(username));
        int selectedCourseCount = 0, finishedCourseCount = 0;
        if(selectedCourses != null) {
            for(Selectedcourse tmp : selectedCourses) {
                if(tmp.getMark() == null) {
                    selectedCourseCount++;
                } else {
                    finishedCourseCount++;
                }
            }
        }
        model.addAttribute("noteList", list);
        model.addAttribute("pagingVO", pagingVO);

        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("selectedCourseCount", selectedCourseCount);
        model.addAttribute("finishedCourseCount", finishedCourseCount);
        model.addAttribute("courseCount", courseService.getCountCouse());
        return "student/showNote";
    }

    @RequestMapping(value = "/selectNote", method = {RequestMethod.GET} )
    private String selectNote(Model model, Integer id) throws Exception {
        if (id == null) {
            return "redirect:/student/showNote";
        }
        Subject subject = SecurityUtils.getSubject();
        List<TeacherCustom> list = teacherService.findAll();
        model.addAttribute("teacherList", list);
        //获取已选课程数和已修课程数
        String username = (String)subject.getPrincipal();
        List<Selectedcourse> selectedCourses = selectedCourseService.findByStudentID(Integer.parseInt(username));
        int selectedCourseCount = 0, finishedCourseCount = 0;
        if(selectedCourses != null) {
            for(Selectedcourse tmp : selectedCourses) {
                if(tmp.getMark() == null) {
                    selectedCourseCount++;
                } else {
                    finishedCourseCount++;
                }
            }
        }
        Note note = noteService.findById(id);
        model.addAttribute("note", note);
        model.addAttribute("noteCount", noteService.getCountNote());
        model.addAttribute("selectedCourseCount", selectedCourseCount);
        model.addAttribute("finishedCourseCount", finishedCourseCount);
        model.addAttribute("courseCount", courseService.getCountCouse());
        return "student/selectNote";
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
        return "student/showNote";
    }
}
