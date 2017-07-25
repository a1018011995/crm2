package com.doocker.crm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.doocker.crm.controller.commont.EasyuiResult;
import com.doocker.crm.po.Dept;
import com.doocker.crm.service.DeptService;
import com.github.pagehelper.PageInfo;
/**
<<<<<<< HEAD
 * 处理部门的控制器
 * @author Administrator  dulong two
=======

>>>>>>> branch 'master' of https://github.com/doockercom/crm.git
 */
@Controller
@RequestMapping("dept")
public class DeptController {
	
	@Autowired
	private DeptService deptService;
	
	@RequestMapping("get")
	//作用是反悔的dept对象转化为json
	@ResponseBody
	public Dept getDept(Integer id){
		return deptService.getDept(id);
	}
	
	
	@RequestMapping("list")
	@ResponseBody
	public EasyuiResult listDept(
			//@RequestParam(value="deptname" 指的是表单中的name 
			//             ,required=false  这个参数是否必须,
			//				defaultValue="1" 此参数的默认值)
			@RequestParam(value="deptname",required=false)String deptName,
			@RequestParam(value="page",defaultValue="1")Integer page,
			@RequestParam(value="rows",defaultValue="3")Integer rows
			){
		PageInfo<Dept> list = new PageInfo<Dept>();
		//架空行
		try{
			list = deptService.selectListByPage(deptName,page,rows);
		}catch(Exception e){
			e.printStackTrace();
			return new EasyuiResult(0L,null,false,"error");
		}
		return new EasyuiResult(list.getTotal(),list.getList(),true,"success");
		
	}
	@RequestMapping("del")
	@ResponseBody
	public 	EasyuiResult delete(@RequestParam(value="id",required=true) Integer id){
		Integer ids = 0;
		try {
			ids =  deptService.deleteById(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new EasyuiResult(0L,null,false,"error");
		}
		return new EasyuiResult(0L,ids,true,"success");
	}
	@RequestMapping("add")
	@ResponseBody
	public 	EasyuiResult add(Dept dept){
		dept.setId(null);
		Integer ids = 0;
		try {
			ids =  deptService.add(dept);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new EasyuiResult(0L,null,false,"error");
		}
		return new EasyuiResult(0L,ids,true,"success");
	}
	@RequestMapping("update")
	@ResponseBody
	public 	EasyuiResult update(
			@RequestParam(value="id",required=true) Integer id,
			@RequestParam(value="deptName",required=true)String deptName){
		Integer ids = 0;
		try {
			Dept dept = new Dept();
			dept.setId(id);
			dept.setDeptName(deptName);
			ids =  deptService.updateDept(dept);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new EasyuiResult(0L,null,false,"error");
		}
		return new EasyuiResult(0L,ids,true,"success");
	}
}
