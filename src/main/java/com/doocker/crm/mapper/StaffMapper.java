package com.doocker.crm.mapper;

import com.doocker.crm.po.Staff;
import com.doocker.crm.po.StaffExample;

import java.util.HashMap;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface StaffMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table staff
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    int countByExample(StaffExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table staff
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    int deleteByExample(StaffExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table staff
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table staff
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    int insert(Staff record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table staff
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    int insertSelective(Staff record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table staff
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    List<Staff> selectByExample(StaffExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table staff
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    Staff selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table staff
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    int updateByExampleSelective(@Param("record") Staff record, @Param("example") StaffExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table staff
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    int updateByExample(@Param("record") Staff record, @Param("example") StaffExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table staff
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    int updateByPrimaryKeySelective(Staff record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table staff
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    int updateByPrimaryKey(Staff record);
    
    //根据员工名称，分页查询
    List<HashMap> selectByPage(@Param("staffName")String staffName);
}