package com.system.mapper;

import com.system.po.Note;
import com.system.po.PagingVO;

import java.util.List;

public interface NoteMapperCustom {
    //分页查询公告
    List<Note> findByPaging(PagingVO pagingVO) throws Exception;
}
