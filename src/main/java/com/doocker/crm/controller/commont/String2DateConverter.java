package com.doocker.crm.controller.commont;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;


//s表示source 传入的参数 String 
//t target 目标类型 Date 
//匹配的原则是 出入参数的key 是 handler中参数的key 并且 出入参数的value必须是String 接受参数的类型必须是Date
public class String2DateConverter implements Converter<String, Date> {

	@Override
	public Date convert(String source) {
		//传入时间字符串的类型是2017-07-07
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date parse  = null;
		try {
			parse = sdf.parse(source);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
		return parse;
	}

}
