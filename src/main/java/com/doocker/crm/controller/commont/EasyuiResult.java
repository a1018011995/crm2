package com.doocker.crm.controller.commont;

public class EasyuiResult {

	private long total;
	private Object rows;
	private boolean flag;
	private String msg;
	public EasyuiResult(long total,Object rows,boolean flag,String msg){
		this.total = total;
		this.flag = flag;
		this.msg = msg;
		this.rows= rows;
	}
	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	public Object getRows() {
		return rows;
	}
	public void setRows(Object rows) {
		this.rows = rows;
	}
	public boolean isFlag() {
		return flag;
	}
	public void setFlag(boolean flag) {
		this.flag = flag;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	@Override
	public String toString() {
		return "EasyuiResult [total=" + total + ", rows=" + rows + ", flag=" + flag + ", msg=" + msg + "]";
	}
	
}
