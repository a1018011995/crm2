package com.doocker.crm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 专门跳转到jsp页面 本地仓库次改了的地方
 * @author Administrator
 * 
 *  
 */
@Controller
public class PageController {
	
	//path.do?path=地址
	//html_path111.do
	@RequestMapping("{pathparams}")
	public String indexPage(
			//html_path111
			//@PathVariable 获取@RequestMapping中的占位符pathparams的值复制给 path
			@PathVariable(value="pathparams")String path){
		//html/path111
		String replace = path.replace("_", "/");
		///WEB-INF/jsp/html/path111.jsp
		return replace;
	}

}
