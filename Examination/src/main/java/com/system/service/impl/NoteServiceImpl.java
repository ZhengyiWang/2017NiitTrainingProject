package com.system.service.impl;

import com.system.mapper.NoteMapper;
import com.system.mapper.NoteMapperCustom;
import com.system.po.Note;
import com.system.po.NoteExample;
import com.system.po.PagingVO;
import com.system.service.NoteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoteServiceImpl implements NoteService {

    @Autowired
    private NoteMapperCustom noteMapperCustom;

    @Autowired
    private NoteMapper noteMapper;

    public int getCountNote() throws Exception {
        NoteExample noteExample = new NoteExample();
        NoteExample.Criteria criteria = noteExample.createCriteria();
        criteria.andNoteidIsNotNull();
        return noteMapper.countByExample(noteExample);
    }

    public void removeById(Integer id) throws Exception {
        noteMapper.deleteByPrimaryKey(id);
    }

    public Boolean save(Note note) throws Exception {
        try {
            noteMapper.insert(note);
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

    public void updataById(Integer id, Note note) throws Exception {
        try {
            noteMapper.updateByPrimaryKey(note);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public List<Note> findByPaging(Integer toPageNo) throws Exception {
        PagingVO pagingVO = new PagingVO();
        pagingVO.setToPageNo(toPageNo);

        List<Note> list = noteMapperCustom.findByPaging(pagingVO);

        return list;
    }

    public Note findById(Integer id) throws Exception {
        try {
            Note note = noteMapper.selectByPrimaryKey(id);
            return note;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Note> findByName(String name) {
        try {
            NoteExample noteExample = new NoteExample();
            //自定义查询条件
            NoteExample.Criteria criteria = noteExample.createCriteria();

            criteria.andTitleLike("%" + name + "%");

            List<Note> list = noteMapper.selectByExample(noteExample);
            return list;
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }

    }
}
