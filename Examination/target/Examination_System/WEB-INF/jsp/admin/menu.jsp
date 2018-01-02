<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="col-md-2">
    <ul class="nav nav-pills nav-stacked" id="nav">
        <li><a href="/admin/showNote">公告管理<span class="badge pull-right">${noteCount}</span></a></li>
        <li><a href="/admin/showCourse">课程管理<span class="badge pull-right">${courseCount}</span></a></li>
        <li><a href="/admin/showStudent">学生管理<span class="badge pull-right">${studentCount}</span></a></li>
        <li><a href="/admin/showTeacher">教师管理<span class="badge pull-right">${teacherCount}</span></a></li>
        <li><a href="/admin/userPasswordRest">账号密码重置<sapn class="glTyphicon glyphicon-repeat pull-right" /></a></li>
        <li><a href="/admin/passwordRest">修改密码<sapn class="glyphicon glyphicon-pencil pull-right" /></a></li>
        <li><a href="/logout">退出系统<sapn class="glyphicon glyphicon-log-out pull-right" /></a></li>
    </ul>
</div>