<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="col-md-2">
    <ul class="nav nav-pills nav-stacked" id="nav">
        <li><a href="/teacher/showNote">公告管理<span class="badge pull-right">${noteCount}</span></a></li>
        <li><a href="/teacher/showCourse">我的课程<span class="badge pull-right">${courseCount}</span></a></li>
        <li><a href="/teacher/passwordRest">修改密码<sapn class="glyphicon glyphicon-pencil pull-right" /></a></li>
        <li><a href="/logout">退出系统<sapn class="glyphicon glyphicon-log-out pull-right" /></a></li>
    </ul>
</div>