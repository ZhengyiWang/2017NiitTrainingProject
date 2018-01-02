package com.system.service;

import com.system.po.Note;

import java.util.List;

public interface NoteService {
    //获取公告总数
    int getCountNote() throws Exception;

    //根据id删除公告
    void removeById(Integer id) throws Exception;

    //保存公告
    Boolean save(Note note) throws Exception;

    //根据id个更新学生信息
    void updataById(Integer id, Note note) throws Exception;

    //分页查询公告
    List<Note> findByPaging(Integer toPageNo) throws Exception;

    //根据id获取学生信息
    Note findById(Integer id) throws Exception;

    //模糊搜索
    List<Note> findByName(String name);
}
