package com.system.mapper;

import com.system.po.Note;
import com.system.po.NoteExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface NoteMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    Integer countByExample(NoteExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    int deleteByExample(NoteExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    int deleteByPrimaryKey(Integer noteid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    int insert(Note record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    int insertSelective(Note record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    List<Note> selectByExampleWithBLOBs(NoteExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    List<Note> selectByExample(NoteExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    Note selectByPrimaryKey(Integer noteid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    int updateByExampleSelective(@Param("record") Note record, @Param("example") NoteExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    int updateByExampleWithBLOBs(@Param("record") Note record, @Param("example") NoteExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    int updateByExample(@Param("record") Note record, @Param("example") NoteExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    int updateByPrimaryKeySelective(Note record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    int updateByPrimaryKeyWithBLOBs(Note record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table note
     *
     * @mbg.generated Tue Jan 02 02:54:36 CST 2018
     */
    int updateByPrimaryKey(Note record);
}